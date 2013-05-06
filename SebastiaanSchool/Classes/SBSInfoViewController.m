//
//  SBSInfoViewController.m
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 12-01-13.
//
//

#import "SBSInfoViewController.h"

#import "SBSAgendaTableViewController.h"
#import "SBSTeamTableViewController.h"

@interface SBSInfoViewController ()

@end

@implementation SBSInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [TestFlight passCheckpoint:[NSString stringWithFormat:@"Loaded VC %@", self.title]];
    self.view.backgroundColor = [SBSStyle sebastiaanBlueColor];
    [self applyTitle:NSLocalizedString(@"Call", nil) andWithImageNamed:@"75-phone" toButton:self.callButton];
    [self applyTitle:NSLocalizedString(@"@KBSebastiaan", nil) andWithImageNamed:@"twitter-bird" toButton:self.twitterButton];
    [self applyTitle:NSLocalizedString(@"Yurl site", nil) andWithImageNamed:@"yurl-logo" toButton:self.yurlButton];
    [self applyTitle:NSLocalizedString(@"Agenda", nil) andWithImageNamed:@"259-list" toButton:self.agendaButton];
    [self applyTitle:NSLocalizedString(@"Team", nil) andWithImageNamed:@"112-group" toButton:self.teamButton];
    
    UILongPressGestureRecognizer * bonusLongPressRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(doTapOnIcon:)];
    [self.iconImageView addGestureRecognizer:bonusLongPressRecognizer];

    UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doBonusTapOnIcon:)];
    [self.iconImageView addGestureRecognizer:tapRecognizer];

    self.iconImageView.userInteractionEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateLayout];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
    [self updateLayout];
}

- (void) updateLayout {
    const CGFloat halfViewWidth = self.view.bounds.size.width / 2.0f;
    
    CGRect twitterFrame = self.twitterButton.frame;
    twitterFrame.size.width = halfViewWidth - 20.0f - 5.0f;
    twitterFrame.origin.x = 20.0f;
    self.twitterButton.frame = twitterFrame;
    
    CGRect yurlFrame = self.yurlButton.frame;
    yurlFrame.size.width = halfViewWidth - 20.0f - 5.0f;
    yurlFrame.origin.x = halfViewWidth + 5.0f;
    self.yurlButton.frame = yurlFrame;
    
    self.iconImageView.center = CGPointMake(halfViewWidth, twitterFrame.origin.y / 2.0f);
}

-(void)doBonusTapOnIcon:(id)sender {
    NSURL *url = [[NSURL alloc]initWithString: NSLocalizedString(@"http://www.sebastiaanschool.nl", nil)];
    [[UIApplication sharedApplication] openURL:url];
}

-(void)doTapOnIcon:(id)sender {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
    animation.autoreverses = NO;
    animation.repeatCount = 3;
    [self.iconImageView.layer addAnimation:animation forKey:@"360"];
}

- (void)applyTitle:(NSString *)title andWithImageNamed:(NSString *)imageName toButton:(UIButton*)button {
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *whiteImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@-white", imageName]];
    
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:whiteImage forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    button.tintColor = [SBSStyle sebastiaanBlueColor];
    
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -image.size.width, -25.0, 0.0)]; // Left inset is the negative of image width.
    [button setImageEdgeInsets:UIEdgeInsetsMake(-15.0, 0.0, 0.0, -button.titleLabel.bounds.size.width)]; // Right inset is the negative of text bounds width.
}

- (IBAction)buttonTapped:(id)sender {
    DLog(@"Button %@ tapped.", [sender currentTitle]);
    
    if (sender == self.callButton) {
        NSURL *url = [NSURL URLWithString:@"telprompt://+31555335355"];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            [TestFlight passCheckpoint:@"Call button tapped on phone."];
            [[UIApplication sharedApplication] openURL:url];
        } else {
            [TestFlight passCheckpoint:@"Call button tapped on non-phone."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Your device does not support phone calls. Please call 055 53 35 355 with your phone.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
            [alert show];
        }
    } else if(sender == self.twitterButton) {
        NSURL *twitterAppUrl = [NSURL URLWithString:@"twitter://user?id=424159127"];
        if([[UIApplication sharedApplication] canOpenURL:twitterAppUrl]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?id=424159127"]];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/KBSebastiaan"]];
        }
    } else if(sender == self.agendaButton) {
        [TestFlight passCheckpoint:@"Agenda button tapped on phone."];
        SBSAgendaTableViewController *agendaController = [[SBSAgendaTableViewController alloc] init];
        agendaController.title = NSLocalizedString(@"Agenda", nil);
        
        [self.navigationController pushViewController:agendaController animated:YES];
    } else if(sender == self.teamButton) {
        SBSTeamTableViewController *contactController = [[SBSTeamTableViewController alloc] init];
        contactController.title = NSLocalizedString(@"Team", nil);

        [self.navigationController pushViewController:contactController animated:YES];
    } else if (sender == self.yurlButton) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://sebastiaan.yurls.net"]];
    } else {
        NSAssert(NO, @"Unknown button tapped.");
    }
}

@end
