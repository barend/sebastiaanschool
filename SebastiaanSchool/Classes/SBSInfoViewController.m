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
    [self applyTitle:NSLocalizedString(@"About", nil) andWithImageNamed:@"123-id-card" toButton:self.aboutButton];
    [self applyTitle:NSLocalizedString(@"Agenda", nil) andWithImageNamed:@"259-list" toButton:self.agendaButton];
    [self applyTitle:NSLocalizedString(@"Staff", nil) andWithImageNamed:@"112-group" toButton:self.teamButton];
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
    } else if(sender == self.aboutButton) {
        ULog(@"Not implemented yet.");
    } else if(sender == self.agendaButton) {
        [TestFlight passCheckpoint:@"Agenda button tapped on phone."];
        SBSAgendaTableViewController *agendaController = [[SBSAgendaTableViewController alloc] init];
        agendaController.title = NSLocalizedString(@"Agenda", nil);
        
        [self.navigationController pushViewController:agendaController animated:YES];
    } else if(sender == self.teamButton) {
        SBSTeamTableViewController *contactController = [[SBSTeamTableViewController alloc] init];
        contactController.title = NSLocalizedString(@"Team", nil);

        [self.navigationController pushViewController:contactController animated:YES];
    } else {
        NSAssert(NO, @"Unknown button tapped.");
    }
}



@end
