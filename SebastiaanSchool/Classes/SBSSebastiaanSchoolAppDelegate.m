#import <Parse/Parse.h>
#import "SBSSebastiaanSchoolAppDelegate.h"
#import "SBSRootViewController.h"
#import "SBSNewsLetterTableViewController.h"
#import "SBSContactTableViewController.h"
#import "SBSInfoViewController.h"
#import "SBSStaffViewController.h"

@implementation SBSSebastiaanSchoolAppDelegate


#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Parse setApplicationId:PARSE_APPLICATION_ID
                  clientKey:PARSE_CLIENT_KEY];
    
    [PFUser enableAutomaticUser];
    
    PFACL *defaultACL = [PFACL ACL];

    // If you would like all objects to be private by default, remove this line.
    [defaultACL setPublicReadAccess:YES];
    
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    //TODO make a nice property and utility out of this.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL enableStaffLogin = [defaults boolForKey:@"enableStaffLogin"];
    
    // Override point for customization after application launch.
    [self.rootViewController addChildViewController:[self createInfoViewController]];
    [self.rootViewController addChildViewController:[self createNewsLetterController]];
    [self.rootViewController addChildViewController:[self createRootViewController]];
    [self.rootViewController addChildViewController:[self createContactViewController]];
    
    if (enableStaffLogin) {
        [self.rootViewController addChildViewController:[self createStaffViewController]];
    }
    
    self.window.rootViewController = self.rootViewController;
    [self.window makeKeyAndVisible];
    
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
                                                    UIRemoteNotificationTypeAlert|
                                                    UIRemoteNotificationTypeSound];
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
    [PFPush storeDeviceToken:newDeviceToken];
    [PFPush subscribeToChannelInBackground:@"" target:self selector:@selector(subscribeFinished:error:)];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if (error.code == 3010) {
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    } else {
        // show some alert or otherwise handle the failure to register.
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
	}
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark - UIViewController creation

-(UIViewController *) createInfoViewController {
    SBSInfoViewController *controller = [[SBSInfoViewController alloc] init];
    controller.title = NSLocalizedString(@"Seb@stiaan", nil);
    
    UINavigationController * navController =  [self createNavControllerWithRootController:controller];
    navController.tabBarItem.title = controller.title;
    return navController;
}


-(UIViewController *) createNewsLetterController {
    SBSNewsLetterTableViewController *controller = [[SBSNewsLetterTableViewController alloc] initWithStyle:UITableViewStylePlain];
    controller.title = NSLocalizedString(@"News letter", nil);
    
    UINavigationController * navController =  [self createNavControllerWithRootController:controller];
    navController.tabBarItem.title = controller.title;
    return navController;
}

-(UIViewController *) createRootViewController {
    SBSRootViewController *controller = [[SBSRootViewController alloc] init];
    controller.title = NSLocalizedString(@"Root", nil);
    
    UINavigationController * navController =  [self createNavControllerWithRootController:controller];
    navController.tabBarItem.title = controller.title;
    return navController;
}

-(UIViewController *) createContactViewController {
    SBSContactTableViewController *controller = [[SBSContactTableViewController alloc] init];
    controller.title = NSLocalizedString(@"Contact", nil);
    
    UINavigationController * navController = [self createNavControllerWithRootController:controller];
    navController.tabBarItem.title = controller.title;
    return navController;
}

-(UIViewController *) createStaffViewController {
    SBSStaffViewController *controller = [[SBSStaffViewController alloc] init];
    controller.title = NSLocalizedString(@"Staff", nil);
    
    UINavigationController * navController =  [self createNavControllerWithRootController:controller];
    navController.tabBarItem.title = controller.title;
    return navController;
}


-(UINavigationController *) createNavControllerWithRootController:(UIViewController *)rootController {
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootController];
    navController.navigationBar.tintColor = [SBSStyle sebastiaanBlueColor];

    return navController;
}


#pragma mark - ()

- (void)subscribeFinished:(NSNumber *)result error:(NSError *)error {
    if ([result boolValue]) {
        NSLog(@"Sebastiaan app successfully subscribed to push notifications on the broadcast channel.");
    } else {
        NSLog(@"Sebastiaan app failed to subscribe to push notifications on the broadcast channel.");
    }
}


@end
