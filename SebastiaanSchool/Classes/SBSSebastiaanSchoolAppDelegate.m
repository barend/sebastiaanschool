#import "SBSSebastiaanSchoolAppDelegate.h"
#import "SBSBulletinViewController.h"
#import "SBSNewsLetterTableViewController.h"
#import "SBSTeamTableViewController.h"
#import "SBSAgendaTableViewController.h"
#import "SBSInfoViewController.h"
#import "SBSStaffViewController.h"

#import "SBSAgendaItem.h"
#import "SBSBulletin.h"
#import "SBSContactItem.h"
#import "SBSNewsLetter.h"

typedef NS_ENUM (NSInteger, SBSNotificationType) {
    SBSNotificationTypeInfo = 0,
    SBSNotificationTypeBulletin = 1,
    SBSNotificationTypeNewsletter = 2,
    SBSNotificationTypeStaff = 4,
};
@implementation SBSSebastiaanSchoolAppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    bootstrapTestFlight();
    
    [SBSAgendaItem  registerSubclass];
    [SBSBulletin    registerSubclass];
    [SBSContactItem registerSubclass];
    [SBSNewsLetter  registerSubclass];
    
    [Parse setApplicationId:PARSE_APPLICATION_ID
                  clientKey:PARSE_CLIENT_KEY];
    
    [PFUser enableAutomaticUser];
        
    PFACL *defaultACL = [PFACL ACL];

    // If you would like all objects to be private by default, remove this line.
    [defaultACL setPublicReadAccess:YES];
    [defaultACL setWriteAccess:YES forRoleWithName:@"staff"];
    [defaultACL setReadAccess:YES forRoleWithName:@"staff"];
    
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];


    // Apply UIAppearance
    [[UIButton appearance] setTintColor:[SBSStyle sebastiaanBlueColor]];
    [[UINavigationBar appearance] setTintColor:[SBSStyle sebastiaanBlueColor]];

    [self.rootViewController setViewControllers:[self getTabVCs] animated:NO];
    
    self.window.rootViewController = self.rootViewController;
    [self.window makeKeyAndVisible];
    
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
                                                    UIRemoteNotificationTypeAlert|
                                                    UIRemoteNotificationTypeSound];
    
    NSDictionary *notificationPayload = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    [self handleRemoteNotification:notificationPayload];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
    [PFPush storeDeviceToken:newDeviceToken];
    [[PFInstallation currentInstallation] addUniqueObject:@"" forKey:@"channels"];
#ifdef DEBUG
    [[PFInstallation currentInstallation] addUniqueObject:@"debug" forKey:@"channels"];
#endif
    [[PFInstallation currentInstallation] saveEventually];
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
    [self handleRemoteNotification:userInfo];
}

- (void)handleRemoteNotification:(NSDictionary *) notificationPayload {
    // Extract the notification data
    NSNumber * notificationType = [notificationPayload objectForKey:@"t"];
    switch ((SBSNotificationType)notificationType.intValue) {
        case SBSNotificationTypeBulletin:
            self.rootViewController.selectedIndex = 2;
            break;
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self.rootViewController setViewControllers:[self getTabVCs] animated:YES];
}

- (NSArray *)getTabVCs{
    static NSArray *allTabs;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        allTabs = @[[self createInfoViewController],
                    [self createNewsLetterController],
                    [self createBulletinViewController],
                    [self createStaffViewController]];
    });
    
    if ([NSUserDefaults enableStaffLogin]) {
        return allTabs;
    } else {
        return [allTabs subarrayWithRange:NSMakeRange(0, allTabs.count -1)];
    }
}

#pragma mark - UIViewController creation

-(UIViewController *) createInfoViewController {
    SBSInfoViewController *controller = [[SBSInfoViewController alloc] init];
    controller.title = NSLocalizedString(@"Seb@stiaan", nil);
    
    UINavigationController * navController =  [self createNavControllerWithRootController:controller];
    navController.tabBarItem.title = controller.title;
    navController.tabBarItem.image = [UIImage imageNamed:@"287-at"];
    return navController;
}


-(UIViewController *) createNewsLetterController {
    SBSNewsLetterTableViewController *controller = [[SBSNewsLetterTableViewController alloc] initWithStyle:UITableViewStylePlain];
    controller.title = NSLocalizedString(@"Newsletter", nil);
    
    UINavigationController * navController =  [self createNavControllerWithRootController:controller];
    navController.tabBarItem.title = controller.title;
    navController.tabBarItem.image = [UIImage imageNamed:@"162-receipt"];
    return navController;
}

-(UIViewController *) createBulletinViewController {
    SBSBulletinViewController *controller = [[SBSBulletinViewController alloc] init];
    controller.title = NSLocalizedString(@"Bulletin", nil);
    
    UINavigationController * navController =  [self createNavControllerWithRootController:controller];
    navController.tabBarItem.title = controller.title;
    navController.tabBarItem.image = [UIImage imageNamed:@"275-broadcast"];
    return navController;
}

-(UIViewController *) createStaffViewController {
    SBSStaffViewController *controller = [[SBSStaffViewController alloc] init];
    controller.title = NSLocalizedString(@"Staff", nil);
    
    UINavigationController * navController = [self createNavControllerWithRootController:controller];
    navController.tabBarItem.title = controller.title;
    navController.tabBarItem.image = [UIImage imageNamed:@"237-key"];
    return navController;
}

-(UINavigationController *) createNavControllerWithRootController:(UIViewController *)rootController {
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootController];

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
