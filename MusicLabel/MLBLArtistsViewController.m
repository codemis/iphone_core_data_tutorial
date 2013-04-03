#import "MLBLArtistsViewController.h"
#import "MLBLAppDelegate.h"
#import "Artist.h"
#import "MLBLAlbumsViewController.h"

@interface MLBLArtistsViewController ()
@property (strong, nonatomic) NSArray *artists;
@end

@implementation MLBLArtistsViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadArtists];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.artists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArtistCell"
                                                            forIndexPath:indexPath];
    cell.textLabel.text = ((Artist *)self.artists[indexPath.row]).name;
    return cell;
}

#pragma mark - Segue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AlbumsSegue"])
    {
        NSInteger indexRow = self.tableView.indexPathForSelectedRow.row;
        ((MLBLAlbumsViewController *)segue.destinationViewController).artistID = [self.artists[indexRow] objectID];
    }
}

#pragma mark - Private methods
- (MLBLAppDelegate *)appDelegate {
    return (MLBLAppDelegate *)UIApplication.sharedApplication.delegate;
}

-(void) loadArtists
{
    NSManagedObjectContext *context = self.appDelegate.managedObjectContext;
    NSFetchRequest *fetchRequest = NSFetchRequest.new;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Artist"
                                              inManagedObjectContext:context];
    fetchRequest.entity = entity;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"label == %@",
                              [context objectWithID:self.labelID]];
    fetchRequest.predicate = predicate;
    // Add an NSSortDescriptor to sort the labels alphabetically
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                        ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    NSError *error = nil;
    self.artists = [context executeFetchRequest:fetchRequest error:&error];
    [self.tableView reloadData];
}
@end
