//
//  SBSEditBulletinViewController.m
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 22-03-13.
//
//

#import "SBSEditBulletinViewController.h"

#import "UIView+JLFrameAdditions.h"

@interface SBSEditBulletinViewController ()

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(doneButtonPressed:)];
    
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

#pragma mark - Action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != actionSheet.destructiveButtonIndex) {
        return;
    }

    [self.delegate deleteBulletin:self.bulletin];
}
@end
