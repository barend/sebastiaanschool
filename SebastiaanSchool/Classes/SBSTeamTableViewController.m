//
//  SBSContactViewController.m
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 12-01-13.
//
//

#import "SBSTeamTableViewController.h"
#import "SBSAddTeamMemberViewController.h"

@interface SBSTeamTableViewController ()
@property (nonatomic, strong) NSIndexPath *currentlyEditedIndexPath;
@end

@implementation SBSTeamTableViewController

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
        self.className = @"ContactItem";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"displayName";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = NO;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = NO;
        
        // The number of objects to show per page
        self.objectsPerPage = 5;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [TestFlight passCheckpoint:[NSString stringWithFormat:@"Loaded VC %@", self.title]];
}

-(void)viewWillAppear:(BOOL)animated {
    [self updateBarButtonItemAnimated:animated];
}

-(void)updateBarButtonItemAnimated:(BOOL)animated {
    if ([[SBSSecurity instance] currentUserStaffUser]) {
        if (self.navigationItem.rightBarButtonItem == nil) {
            UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTeamMember)];
            [self.navigationItem setRightBarButtonItem:addButton animated:animated];
        }
    } else {
        [self.navigationItem setRightBarButtonItem:nil animated:animated];
    }
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
    
    [query orderByAscending:@"order"];
    
    return query;
}

- (void)addTeamMember {
    SBSAddTeamMemberViewController *addTeamMemberVC = [[SBSAddTeamMemberViewController alloc]init];
    addTeamMemberVC.delegate = self;
    [self.navigationController pushViewController:addTeamMemberVC animated:YES];
}

-(void)createdTeamMember:(PFObject *)newTeamMember {
    [newTeamMember saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            //Do a big reload since the framework VC doesn't support nice view insertions and removal.
            [self loadObjects];
        } else {
            ULog(@"Error while adding bulletin: %@", error);
        }
    }];
    
    [self.navigationController popToViewController:self animated:YES];
}


// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"contactCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        UIView * const newSelectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
        newSelectedBackgroundView.backgroundColor = [SBSStyle sebastiaanBlueColor];
        newSelectedBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        cell.selectedBackgroundView = newSelectedBackgroundView;
    }
    
    // Configure the cell
    cell.textLabel.text = [object objectForKey:@"displayName"];
    cell.detailTextLabel.text = [object objectForKey:@"description"];
    
    return cell;
}


#pragma mark - Table view data source

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return [SBSSecurity instance].currentUserStaffUser;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PFObject *contactItem = [self objectAtIndexPath:indexPath];
        NSString *contactItemName = [contactItem objectForKey:@"displayName"];
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:[NSString stringWithFormat: NSLocalizedString(@"Are you sure you want to delete \"%@\"?", nil), contactItemName] delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:NSLocalizedString(@"Delete", nil) otherButtonTitles:nil];
        self.currentlyEditedIndexPath = indexPath;
        
        [actionSheet showInView:[UIApplication sharedApplication].delegate.window.rootViewController.view];
    }
}

#pragma mark - Action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex || self.currentlyEditedIndexPath == nil) {
        return;
    }
    
    // Delete the row from the data source
    PFObject *deletedTeamMember = [self objectAtIndexPath:self.currentlyEditedIndexPath];
    [deletedTeamMember deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            //Do a big reload since the framework VC doesn't support nice view insertions and removal.
            [self loadObjects];
        } else {
            ULog(@"Failed to delete buletin");
        }
    }];

}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    PFObject *selectedContactItem = [self objectAtIndexPath:indexPath];
    
    NSString *displayName = [selectedContactItem objectForKey:@"displayName"];
    NSString *emailRecipient = [selectedContactItem objectForKey:@"email"];

    if ([emailRecipient length] ==0) {
        NSString *title = NSLocalizedString(@"Unknown email addres", nil);
        NSString *message = [NSString stringWithFormat:NSLocalizedString(@"No email address of %@ on file.", nil),displayName ];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        
        [alert show];
        return;
    }
    
    if (![MFMailComposeViewController canSendMail]) {
        UIPasteboard *pb = [UIPasteboard generalPasteboard];
        [pb setString:emailRecipient];
        
        NSString *title = NSLocalizedString(@"Your device can not send email", nil);
        NSString *message = [NSString stringWithFormat:NSLocalizedString(@"The email address %@ of %@ has been copied to the pasteboard.", nil), emailRecipient, displayName ];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        
        [alert show];
        
        return;
    }

    
    NSString *messageBody = [NSString stringWithFormat:NSLocalizedString(@"Dear %@,\n\n", nil), displayName];
    // To address
    NSArray *toRecipents = @[emailRecipient];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            DLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            DLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            DLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            ALog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Listen for security role changes

-(void)userRoleChanged:(NSNotification *)notification {
    [self updateBarButtonItemAnimated:YES];
}

@end
