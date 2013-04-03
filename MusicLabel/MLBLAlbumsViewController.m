#import "MLBLAlbumsViewController.h"
#import "Album.h"
#import "MLBLAppDelegate.h"

@interface MLBLAlbumsViewController ()
@property (strong, nonatomic)NSArray *albums;
@end

@implementation MLBLAlbumsViewController

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadAlbums];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.albums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumCell"
                                                            forIndexPath:indexPath];
    cell.textLabel.text = ((Album *)self.albums[indexPath.row]).title;
    return cell;
}

#pragma mark - Private methods
- (MLBLAppDelegate *)appDelegate {
    return (MLBLAppDelegate *)UIApplication.sharedApplication.delegate;
}

-(void) loadAlbums
{
    NSManagedObjectContext *context = self.appDelegate.managedObjectContext;
    NSFetchRequest *fetchRequest = NSFetchRequest.new;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Album"
                                              inManagedObjectContext:context];
    fetchRequest.entity = entity;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"artist == %@",
                              [context objectWithID:self.artistID]];
    fetchRequest.predicate = predicate;
    // Add an NSSortDescriptor to sort the labels alphabetically
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title"
                                                                   ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    NSError *error = nil;
    self.albums = [context executeFetchRequest:fetchRequest error:&error];
    [self.tableView reloadData];
}

@end
