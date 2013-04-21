//
//  SBSEditAgendaViewController.m
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 21-04-13.
//
//

#import "SBSEditAgendaViewController.h"

@interface SBSEditAgendaViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *nameTextView;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UITextView *startDateTextView;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UITextView *endDateTextView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
- (IBAction)deleteButtonPressed:(id)sender;

@end

@implementation SBSEditAgendaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Agenda Item", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonPressed:)];
    
    self.nameLabel.text = NSLocalizedString(@"Name", nil);
    self.startDateLabel.text = NSLocalizedString(@"Start", nil);
    self.endDateLabel.text = NSLocalizedString(@"End", nil);
    
    [SBSStyle applyStyleToTextView:self.nameTextView];
    [SBSStyle applyStyleToTextView:self.startDateTextView];
    [SBSStyle applyStyleToTextView:self.endDateTextView];
    
    self.nameTextView.text = self.agendaItem.name;
    self.startDateTextView.text = self.agendaItem.start.description;
    self.endDateTextView.text = self.agendaItem.end.description;
    
    [SBSStyle applyStyleToDeleteButton:self.deleteButton];
    
    self.nameTextView.inputAccessoryView = self.textViewAccessoryView;
    self.startDateTextView.inputAccessoryView = self.textViewAccessoryView;
    self.endDateTextView.inputAccessoryView = self.textViewAccessoryView;
}

- (void)setAgendaItem:(SBSAgendaItem *)agendaItem {
    _agendaItem = agendaItem;
    
    [self updateLayout];
}

- (void) updateLayout {
    self.deleteButton.hidden = self.agendaItem == nil;
}

-(void)saveButtonPressed:(id) sender {
    SBSAgendaItem *agendaItem = self.agendaItem;
    if (self.agendaItem == nil) {
        agendaItem = [[SBSAgendaItem alloc]init];
    }
    
    if (self.nameTextView.text.length !=0 && self.startDateTextView.text.length != 0) {
        agendaItem.name = self.nameTextView.text;
        agendaItem.start = self.startDateTextView.text;
        agendaItem.end = self.endDateTextView.text;
        if (self.agendaItem == nil) {
            [self.delegate createAgendaItem:agendaItem];
        } else {
            [self.delegate updateAgendaItem:agendaItem];
        }
    }
}

- (void)viewDidUnload {
    [self setNameTextView:nil];
    [self setStartDateTextView:nil];
    [self setEndDateTextView:nil];
    [self setNameLabel:nil];
    [self setStartDateLabel:nil];
    [self setEndDateLabel:nil];
    [self setDeleteButton:nil];
    [super viewDidUnload];
}

- (IBAction)deleteButtonPressed:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:NSLocalizedString(@"Delete Agenda Item?", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:NSLocalizedString(@"Delete", nil) otherButtonTitles: nil];
    
    [actionSheet showInView:[UIApplication sharedApplication].delegate.window.rootViewController.view];
}

#pragma mark - Action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != actionSheet.destructiveButtonIndex) {
        return;
    }
    
    [self.delegate deleteAgendaItem:self.agendaItem];
}
@end
