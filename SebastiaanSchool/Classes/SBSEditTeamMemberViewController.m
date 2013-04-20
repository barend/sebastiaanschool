//
//  SBSAddTeamMemberViewController.m
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 09-02-13.
//
//

#import "SBSEditTeamMemberViewController.h"

#import "UIView+JLFrameAdditions.h"

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@interface SBSEditTeamMemberViewController ()<UITextViewDelegate>
{
    CGFloat animatedDistance;
}

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
    
    self.displayNameTextView.layer.borderWidth = 1.0f;
    self.displayNameTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.displayNameTextView.font = [SBSStyle titleFont];
    
    
    self.detailLabel.text = NSLocalizedString(@"Detail content", nil);
    
    self.detailTextView.layer.borderWidth = 1.0f;
    self.detailTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.detailTextView.font = [SBSStyle bodyFont];
    
    
    self.emailLabel.text = NSLocalizedString(@"Email", nil);
    
    self.emailTextView.layer.borderWidth = 1.0f;
    self.emailTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.emailTextView.font = [SBSStyle bodyFont];
    
    [self updateLayout];
    
//    self.displayNameTextView.text = self.bulletin.title;
//    self.detailTextView.text = self.bulletin.body;
//    self.emailTextView.text = self.bulletin.body;
    
    [self.deleteButton setBackgroundImage:[[UIImage imageNamed:@"redButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 0, 16)] forState:UIControlStateNormal];
    [self.deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.deleteButton setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.deleteButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    self.deleteButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.deleteButton setTitle:NSLocalizedString(@"Delete", nil) forState:UIControlStateNormal];
    
    //Assign delegates.
    self.displayNameTextView.delegate = self;
    self.detailTextView.delegate = self;
    self.emailTextView.delegate = self;
    
    UIToolbar * accessoryView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [SBSStyle phoneWidth], 44.0)];
    accessoryView.barStyle = UIBarStyleBlack;
    accessoryView.translucent = YES;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    
    accessoryView.items = @[[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton];
    
    self.displayNameTextView.inputAccessoryView = accessoryView;
    self.detailTextView.inputAccessoryView = accessoryView;
    self.emailTextView.inputAccessoryView = accessoryView;
}


- (void)setContact:(SBSContactItem *)contact {
    _contact = contact;
    
    [self updateLayout];
}

- (void) updateLayout {
    if (self.contact == nil) {
        self.deleteButton.hidden = YES;
    } else {
        self.deleteButton.hidden = NO;
#warning Implement.
//        self.bodyTextView._height = self.view._height - self.bodyTextView._y - self.deleteButton._height -30;
    }
#warning Implement.
//    self.bodyTextView._height = self.view._height - self.bodyTextView._y - self.deleteButton._height -30;
}

-(void)doneButtonPressed:(id) sender {
#warning Implement.
//    if(self.titleTextView.isFirstResponder) {
//        [self.titleTextView resignFirstResponder];
//    }
//    if(self.bodyTextView.isFirstResponder) {
//        [self.bodyTextView resignFirstResponder];
//    }
}


-(void)saveButtonPressed:(id) sender {
    SBSContactItem *contact = self.contact;
    if (self.contact == nil) {
        contact = [[SBSContactItem alloc]init];
    }
#warning Implement.
//    if (self.titleTextView.text.length !=0) {
//        bulletin.title = self.titleTextView.text;
//        if (self.bodyTextView.text.length !=0) {
//            bulletin.body = self.bodyTextView.text;
//        }
//        if (self.contact == nil) {
//            [self.delegate createdTeamMember:contact];
//        } else {
//            [self.delegate updatedTeamMember:contact];
//        }
//    }
    //-(void)doneButtonPressed:(id) sender {
    //    SBSContactItem *newTeamMember = [[SBSContactItem alloc]init];
    //    if (self.displayNameField.text.length !=0 && self.detailTextField.text.length !=0) {
    //        newTeamMember.displayName = self.displayNameField.text;
    //        newTeamMember.detailText = self.detailTextField.text;
    //        newTeamMember.email = self.emailField.text;
    //        [self.delegate createdTeamMember:newTeamMember];
    //    }
    //}

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

#pragma mark - Text view delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    CGRect textFieldRect =
    [self.view.window convertRect:textView.bounds fromView:textView];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
#warning Implement
//    if (textView == self.titleTextView) {
//        const CGFloat availableWidth = [SBSStyle phoneWidth] - [SBSStyle standardMargin] *2;
//        
//        NSString *newText = [textView.text stringByReplacingCharactersInRange:range withString:text];
//        
//        CGSize size = [newText sizeWithFont:[SBSStyle titleFont]];
//        BOOL result = availableWidth >= size.width;
//        return result;
//    }
//    
    return YES;
}

#pragma mark - Action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != actionSheet.destructiveButtonIndex) {
        return;
    }

    [self.delegate deleteTeamMember:self.contact];
}
@end
