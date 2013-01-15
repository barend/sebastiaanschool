//
//  SBSStaffViewController.m
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 12-01-13.
//
//

#import "SBSStaffViewController.h"

@implementation SBSStaffViewController

@synthesize welcomeLabel;

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    if (![PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]]) {
        [welcomeLabel setText:[NSString stringWithFormat:NSLocalizedString(@"Welcome %@!", nil), [[PFUser currentUser] username]]];
    } else {
        [welcomeLabel setText:NSLocalizedString(@"Not logged in", nil)];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self updateButtonText];
}


#pragma mark - PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length && password.length) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [self updateButtonText];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
    
    [self updateButtonText];
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
    
    [self updateButtonText];
}


#pragma mark - Logout button handler

- (IBAction)logOutButtonTapAction:(id)sender {
    
    if ([PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]]) { // No user logged in
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        logInViewController.title = NSLocalizedString(@"Login", nil);
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        logInViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton;
        
        // Present the log in view controller
        [self.navigationController pushViewController:logInViewController animated:YES];
    } else {

        [PFUser logOut];
    }
    
    [self updateButtonText];
}

-(void)updateButtonText {
    if (![PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]]) {
        [welcomeLabel setText:[NSString stringWithFormat:NSLocalizedString(@"Welcome %@!", nil), [[PFUser currentUser] username]]];
        [self.loginButton setTitle:NSLocalizedString(@"Sign out", nil)forState:UIControlStateNormal];
    } else {
        [welcomeLabel setText:@"Not logged in"];
        [self.loginButton setTitle:NSLocalizedString(@"Sign in...", nil)forState:UIControlStateNormal];
    }
}

@end
