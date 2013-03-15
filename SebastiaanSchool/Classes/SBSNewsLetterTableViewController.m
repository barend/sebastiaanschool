//
//  SBSNewsLetterViewController.m
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 11-01-13.
//

#import "SBSNewsLetterTableViewController.h"

#import "SBSNewsLetterViewController.h"

@interface SBSNewsLetterTableViewController ()

@end

@implementation SBSNewsLetterTableViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userRoleChanged:) name:SBSUserRoleDidChangeNotification object:nil];
        
        // Custom the table
        
        // The className to query on
        self.className = @"NewsLetter";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"name";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = NO;
        
        // The number of objects to show per page
        self.objectsPerPage = 5;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [TestFlight passCheckpoint:[NSString stringWithFormat:@"Loaded VC %@", self.title]];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated {
    [self updateBarButtonItemAnimated:animated];
}

-(void)updateBarButtonItemAnimated:(BOOL)animated {
    if ([[SBSSecurity instance] currentUserStaffUser]) {
        if (self.navigationItem.rightBarButtonItem == nil) {
            UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshNewsletters)];
            [self.navigationItem setRightBarButtonItem:addButton animated:animated];
        }
    } else {
        [self.navigationItem setRightBarButtonItem:nil animated:animated];
    }
}

- (void)refreshNewsletters {
}

#pragma mark - Parse

// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.className];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"publishedAt"];
    
    return query;
}



// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"newsLetterCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        cell.selectedBackgroundView = [SBSStyle selectedBackgroundView];
        cell.selectedBackgroundView.frame = cell.bounds;
    }
    
    // Configure the cell
    cell.textLabel.text = [[object objectForKey:@"name"] capitalizedString];
    cell.detailTextLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Published: %@", nil), [[SBSStyle longStyleDateFormatter] stringFromDate:[object objectForKey:@"publishedAt"]]];
    
    return cell;
}

#pragma mark - Table view data source

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFObject *newsLetter = [self objectAtIndexPath:indexPath];
    SBSNewsLetterViewController *newsletterViewController = [[SBSNewsLetterViewController alloc]initWithNewsLetter:newsLetter];
    newsletterViewController.title = [[newsLetter objectForKey:@"name"] capitalizedString];
    [self.navigationController pushViewController:newsletterViewController animated:YES];
}

#pragma mark - Listen for security role changes

-(void)userRoleChanged:(NSNotification *)notification {
    [self updateBarButtonItemAnimated:YES];
}


@end
