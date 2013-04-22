//
//  SBSAddTeamMemberViewController.m
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 09-02-13.
//
//

#import "SBSEditTeamMemberViewController.h"

#import "UIView+JLFrameAdditions.h"

@interface SBSEditTeamMemberViewController ()

@property (weak, nonatomic) IBOutlet UILabel *displayNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *displayNameTextView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextView *emailTextView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
- (IBAction)deleteButtonPressed:(id)sender;

@end

@implementation SBSEditTeamMemberViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Team Member", nil);
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonPressed:)];
    
    self.displayNameLabel.text = NSLocalizedString(@"Name", nil);
    self.detailLabel.text = NSLocalizedString(@"Detail content", nil);
    self.emailLabel.text = NSLocalizedString(@"Email", nil);
    
    [SBSStyle applyStyleToTextView:self.displayNameTextView];
    [SBSStyle applyStyleToTextView:self.detailTextView];
    [SBSStyle applyStyleToTextView:self.emailTextView];
    
    [self updateLayout];
    
    self.displayNameTextView.text = self.contact.displayName;
    self.detailTextView.text = self.contact.detailText;
    self.emailTextView.text = self.contact.email;
    
    [SBSStyle applyStyleToDeleteButton:self.deleteButton];

    self.displayNameTextView.inputAccessoryView = self.textViewAccessoryView;
    self.detailTextView.inputAccessoryView = self.textViewAccessoryView;
    self.emailTextView.inputAccessoryView = self.textViewAccessoryView;
}

- (void)setContact:(SBSContactItem *)contact {
    _contact = contact;
    
    [self updateLayout];
}

- (void) updateLayout {
    self.deleteButton.hidden = self.contact == nil;
}

-(void)saveButtonPressed:(id) sender {
    SBSContactItem *contact = self.contact;
    if (self.contact == nil) {
        contact = [[SBSContactItem alloc]init];
    }
    if (self.displayNameTextView.text.length != 0 && self.detailTextView.text.length) {
        contact.displayName = self.displayNameTextView.text;
        contact.detailText = self.detailTextView.text;
        contact.email = self.emailTextView.text;
        
        if (self.contact == nil) {
            [self.delegate createTeamMember:contact];
        } else {
            [self.delegate updateTeamMember:contact];
        }
    }
}

- (void)viewDidUnload {
    self.displayNameLabel = nil;
    self.displayNameTextView = nil;
    self.detailLabel = nil;
    self.detailTextView = nil;
    self.emailLabel = nil;
    self.emailTextView = nil;
    [self setDeleteButton:nil];
    [super viewDidUnload];
}
- (IBAction)deleteButtonPressed:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:NSLocalizedString(@"Delete Bulletin?", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:NSLocalizedString(@"Delete", nil) otherButtonTitles: nil];
    
    [actionSheet showInView:[UIApplication sharedApplication].delegate.window.rootViewController.view];
}

#pragma mark - Action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != actionSheet.destructiveButtonIndex) {
        return;
    }

    [self.delegate deleteTeamMember:self.contact];
}
@end
