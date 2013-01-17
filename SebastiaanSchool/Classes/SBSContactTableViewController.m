//
//  SBSContactViewController.m
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 12-01-13.
//
//

#import "SBSContactTableViewController.h"

@interface SBSContactTableViewController ()

@end

@implementation SBSContactTableViewController


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
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

//    UIButton *mailButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    mailButton.frame = CGRectMake(10, 10, 100, 40);
//    [mailButton addTarget:self action:@selector(sendMail:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:mailButton];
}


#pragma mark - Parse

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}


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
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
