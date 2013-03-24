//
//  SBSAgendaTableViewController.m
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 18-01-13.
//
//

#import <EventKit/EventKit.h>

#import "SBSAgendaTableViewController.h"
#import "SBSSebastiaanSchoolAppDelegate.h"

@interface SBSAgendaTableViewController ()
@property (nonatomic, strong)EKEventStore *eventStore;

@end

@implementation SBSAgendaTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"AgendaItem";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"name";
        
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
    self.eventStore = [[EKEventStore alloc]init];
	// Do any additional setup after loading the view.
    [TestFlight passCheckpoint:[NSString stringWithFormat:@"Loaded VC %@", self.title]];
}


#pragma mark - Parse

// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByAscending:@"start"];
    
    return query;
}



// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"agendaCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        cell.selectedBackgroundView = [SBSStyle selectedBackgroundView];
        cell.selectedBackgroundView.frame = cell.bounds;
    }
    
    // Configure the cell
    cell.textLabel.text = [object objectForKey:@"name"];
    NSDate *startDate = [object objectForKey:@"start"];
    NSDate *endDate = [object objectForKey:@"end"];
    
    if (startDate != nil && endDate != nil && [startDate compare:endDate] == NSOrderedAscending) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@",
                                     [[SBSStyle longStyleDateFormatter] stringFromDate:startDate],
                                     [[SBSStyle longStyleDateFormatter] stringFromDate:endDate]];
    } else if (startDate != nil) {
        cell.detailTextLabel.text = [[SBSStyle longStyleDateFormatter] stringFromDate:startDate];
    } else {
        DLog(@"Missing start and end on event.");
    }
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
    PFObject *agendaItem = [self objectAtIndexPath:indexPath];
    NSString *agendaItemName = [agendaItem objectForKey:@"name"];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:[NSString stringWithFormat: NSLocalizedString(@"Add \"%@\" to your default calendar?", nil), agendaItemName] delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Add to calendar", nil), nil];
    
    [actionSheet showInView:[UIApplication sharedApplication].delegate.window.rootViewController.view];
}

#pragma mark - Action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    __weak typeof(self) weakSelf = self;
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];

    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    
    PFObject *agendaItem = [self objectAtIndexPath:self.tableView.indexPathForSelectedRow];
    NSString *agendaItemName = [agendaItem objectForKey:@"name"];
    NSDate *agendaItemStartDate = [agendaItem objectForKey:@"start"];
    NSDate *agendaItemEndDate = [agendaItem objectForKey:@"end"];
    
    EKEvent *event=[EKEvent eventWithEventStore:self.eventStore];
    event.allDay = YES;
    event.title=agendaItemName;
    event.startDate=agendaItemStartDate;
    event.endDate=agendaItemEndDate;
    [event setCalendar:[self.eventStore defaultCalendarForNewEvents]];

    
    if([self.eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        [weakSelf.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if (granted) {
                NSError *error;
                [weakSelf.eventStore saveEvent:event span:EKSpanThisEvent error:&error];
            }
        }];
    } else {
        NSError *error;
        [self.eventStore saveEvent:event span:EKSpanThisEvent error:&error];
    }
}

@end
