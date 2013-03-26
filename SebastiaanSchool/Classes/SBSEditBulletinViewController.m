//
//  SBSEditBulletinViewController.m
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 22-03-13.
//
//

#import "SBSEditBulletinViewController.h"

#import "UIView+JLFrameAdditions.h"

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@interface SBSEditBulletinViewController ()<UITextViewDelegate>
{
    CGFloat animatedDistance;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *titleTextView;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
- (IBAction)deleteButtonPressed:(id)sender;

@end

@implementation SBSEditBulletinViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Bulletin", nil);
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonPressed:)];
    
    self.titleLabel.text = NSLocalizedString(@"Message", nil);
    
    self.titleTextView.layer.borderWidth = 1.0f;
    self.titleTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.titleTextView.font = [SBSStyle titleFont];
    

    self.bodyLabel.text = NSLocalizedString(@"Message content", nil);

    self.bodyTextView.layer.borderWidth = 1.0f;
    self.bodyTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bodyTextView.font = [SBSStyle bodyFont];

    [self updateLayout];
    
    self.titleTextView.text = self.bulletin.title;
    self.bodyTextView.text = self.bulletin.body;

    [self.deleteButton setBackgroundImage:[[UIImage imageNamed:@"redButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 0, 16)] forState:UIControlStateNormal];
    [self.deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.deleteButton setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.deleteButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    self.deleteButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.deleteButton setTitle:NSLocalizedString(@"Delete", nil) forState:UIControlStateNormal];

    //Assign delegates.
    self.titleTextView.delegate = self;
    self.bodyTextView.delegate = self;

    UIToolbar * accessoryView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [SBSStyle phoneWidth], 44.0)];
    accessoryView.barStyle = UIBarStyleBlack;
    accessoryView.translucent = YES;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    
    accessoryView.items = @[[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton];
    
    self.titleTextView.inputAccessoryView = accessoryView;
    self.bodyTextView.inputAccessoryView = accessoryView;
}

- (void)setBulletin:(SBSBulletin *)bulletin {
    _bulletin = bulletin;
    
    [self updateLayout];
}

- (void) updateLayout {
    if (self.bulletin == nil) {
        self.deleteButton.hidden = YES;
        self.bodyTextView._height = self.view._height - self.bodyTextView._y -20;
    } else {
        self.deleteButton.hidden = NO;
        self.bodyTextView._height = self.view._height - self.bodyTextView._y - self.deleteButton._height -30;
    }
}

-(void)doneButtonPressed:(id) sender {
    if(self.titleTextView.isFirstResponder) {
        [self.titleTextView resignFirstResponder];
    }
    if(self.bodyTextView.isFirstResponder) {
        [self.bodyTextView resignFirstResponder];
    }
}


-(void)saveButtonPressed:(id) sender {
    SBSBulletin *bulletin = self.bulletin;
    if (self.bulletin == nil) {
        bulletin = [[SBSBulletin alloc]init];
    }
    
    if (self.titleTextView.text.length !=0) {
        bulletin.title = self.titleTextView.text;
        if (self.bodyTextView.text.length !=0) {
            bulletin.body = self.bodyTextView.text;
        }
        if (self.bulletin == nil) {
            [self.delegate createBulletin:bulletin];
        } else {
            [self.delegate updateBulletin:bulletin];
        }
    }
}

- (void)viewDidUnload {
    [self setTitleTextView:nil];
    [self setBodyTextView:nil];
    [self setTitleLabel:nil];
    [self setBodyLabel:nil];
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
    if (textView == self.titleTextView) {
        const CGFloat availableWidth = [SBSStyle phoneWidth] - [SBSStyle standardMargin] *2;
        
        NSString *newText = [textView.text stringByReplacingCharactersInRange:range withString:text];

        CGSize size = [newText sizeWithFont:[SBSStyle titleFont]];
        BOOL result = availableWidth >= size.width;
        return result;
    }
    
    return YES;
}

#pragma mark - Action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != actionSheet.destructiveButtonIndex) {
        return;
    }

    [self.delegate deleteBulletin:self.bulletin];
}
@end
