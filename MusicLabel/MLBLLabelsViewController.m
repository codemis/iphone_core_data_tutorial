#import "MLBLLabelsViewController.h"
#import "MLBLArtistsViewController.h"
#import "Label.h"
#import "MLBLAppDelegate.h"

@interface MLBLLabelsViewController ()
@property (strong, nonatomic) NSArray *labels;
@end

@implementation MLBLLabelsViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadLabels];
}
#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    return self.labels.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LabelCell"
                                                            forIndexPath:indexPath];
    cell.textLabel.text = ((Label *)self.labels[indexPath.row]).name;
    return cell;
}
#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ArtistsSegue"])
    {
        NSInteger indexRow = self.tableView.indexPathForSelectedRow.row;
        ((MLBLArtistsViewController *)segue.destinationViewController).labelID =
        [self.labels[indexRow] objectID];
    }
}
#pragma mark - Private methods
-(MLBLAppDelegate *)appDelegate {
    return (MLBLAppDelegate *)UIApplication.sharedApplication.delegate;
}
-(void) loadLabels {
    NSManagedObjectContext *context = self.appDelegate.managedObjectContext;
    NSFetchRequest *fetchRequest = NSFetchRequest.new;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Label"
                                              inManagedObjectContext:context];
    fetchRequest.entity = entity;
    // Add an NSSortDescriptor to sort the labels alphabetically
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                                                   ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    NSError *error = nil;
    self.labels = [context executeFetchRequest:fetchRequest error:&error];
    [self.tableView reloadData];
}
@end
