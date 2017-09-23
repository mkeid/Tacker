//
//  AppDelegate.m
//  Tacker
//
//  Created by Mohamed Eid on 11/15/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "AppDelegate.h"

#import "FriendsViewController.h"
#import "RequestsViewController.h"
#import "SettingsViewController.h"
#import "TackerAPI.h"
#import "TackerHTTP.h"
#import "TrackersViewController.h"
#import "WelcomeViewController.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor colorWithRed:239/255.0f green:64/255.0f blue:73/255.0f alpha:1.0f];
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    self.tackerAPI = [[TackerAPI alloc] init];
    self.tackerAPI.tackerAuth = [[TackerAuth alloc] init];
    
     NSArray *accountsArray = [SSKeychain accountsForService:@"tacker"];
     if(accountsArray.count == 0) {
         [self showWelcome];
     }
     else {
         NSString *account = (NSString *)[[accountsArray valueForKey:@"acct"] objectAtIndex:0];
         NSString *password = [SSKeychain passwordForService:@"tacker" account:account];
         [TackerAuth signIn:@{@"user":@{@"signin": account, @"password": password}} completionBlock:^(NSDictionary *userDictionary){
             if(userDictionary && ![userDictionary objectForKey:@"errors"]) {
                 // Add the confirmed account to the keychain.
                 [SSKeychain setPassword:password forService:@"tacker" account:account];
                 
                 User *currentUser = [User createUserFromDict:[(NSDictionary *)userDictionary objectForKey:@"me"]];
                 MY_APPDELEGATE.tackerAPI.tackerAuth.currentUser = currentUser;
                 [self showSession];
             }
             else {
                 NSLog(@"HERE");
                 NSLog([NSString stringWithFormat:@"%@",userDictionary]);
                 [self showWelcome];
             }
         }];
     }
    [self setApplicationBadgeCount];
    return YES;
}

- (void)showWelcome {
    WelcomeViewController *welcomeViewController = [[WelcomeViewController alloc] initWithNibName:@"WelcomeView" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:welcomeViewController];
    UIColor * color = [UIColor colorWithRed:239/255.0f green:64/255.0f blue:73/255.0f alpha:1.0f];
    navigationController.navigationBar.tintColor = [UIColor whiteColor];
    navigationController.navigationBar.barTintColor = color;
    
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    navigationController.navigationBar.titleTextAttributes = navbarTitleTextAttributes;
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
}

- (void)showSession {
    TrackersViewController *trackersViewController = [[TrackersViewController alloc] initWithNibName:@"TrackersView" bundle:nil];
    RequestsViewController *requestsViewController = [[RequestsViewController alloc] initWithNibName:@"RequestsView" bundle:nil];
    FriendsViewController *friendsViewController = [[FriendsViewController alloc] initWithNibName:@"FriendsView" bundle:nil];
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsView" bundle:nil];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController.tabBar setSelectedImageTintColor:[UIColor whiteColor]];
    [tabBarController.tabBar setTintColor:[UIColor whiteColor]];
    tabBarController.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"tab-bar-item-selected-red"];
    tabBarController.viewControllers = @[trackersViewController,requestsViewController,friendsViewController,settingsViewController];
    
    
    [((UITabBarItem *)[tabBarController.tabBar.items objectAtIndex:0]) setImage:[UIImage imageNamed:@"trackers-item"]];
    [((UITabBarItem *)[tabBarController.tabBar.items objectAtIndex:1]) setImage:[UIImage imageNamed:@"requests-item"]];
    [((UITabBarItem *)[tabBarController.tabBar.items objectAtIndex:2]) setImage:[UIImage imageNamed:@"friends-item"]];
    [((UITabBarItem *)[tabBarController.tabBar.items objectAtIndex:3]) setImage:[UIImage imageNamed:@"settings-item"]];
    
    MY_APPDELEGATE.tabBarController = tabBarController;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    
    [navigationController setNavigationBarHidden:YES];
    [navigationController setViewControllers:@[tabBarController] animated:YES];
    
    UIColor * color = [UIColor colorWithRed:239/255.0f green:64/255.0f blue:73/255.0f alpha:1.0f];
    navigationController.navigationBar.tintColor = [UIColor whiteColor];
    navigationController.navigationBar.barTintColor = color;
    
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    navigationController.navigationBar.titleTextAttributes = navbarTitleTextAttributes;
    
    // Let the device know we want to receive push notifications.
    [MY_APPDELEGATE askToSendPushNotifications];
    
    [MY_APPDELEGATE setApplicationBadgeCount];
    [MY_APPDELEGATE setRequestsBadgeCount];
    [MY_APPDELEGATE setTrackersBadgeCount];

    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
}

- (void)resetKeychain {
    NSArray *accountsArray = [SSKeychain accountsForService:@"tacker"];
    NSString *account = (NSString *)[[accountsArray valueForKey:@"acct"] objectAtIndex:0];
    [SSKeychain deletePasswordForService:@"tacker" account:account];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if(CURRENT_USER) {
        CURRENT_USER.shouldRefreshRequests = (BOOL *)YES;
        CURRENT_USER.shouldRefreshTrackers = (BOOL *)YES;
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Tacker" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Tacker.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

// The application did register for push notifications.
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	NSLog(@"My token is: %@", deviceToken);
    [_tackerAPI postMeUpdatePushDevice:deviceToken];
}

// The application failed to register for push notifications.
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}

// Switch to the session part of the application.
- (void)switchToSession:(UINavigationController *)navigationController {
    TrackersViewController *trackersViewController = [[TrackersViewController alloc] initWithNibName:@"TrackersView" bundle:nil];
    RequestsViewController *requestsViewController = [[RequestsViewController alloc] initWithNibName:@"RequestsView" bundle:nil];
    FriendsViewController *friendsViewController = [[FriendsViewController alloc] initWithNibName:@"FriendsView" bundle:nil];
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsView" bundle:nil];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController.tabBar setSelectedImageTintColor:[UIColor whiteColor]];
    [tabBarController.tabBar setTintColor:[UIColor whiteColor]];
    tabBarController.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"tab-bar-item-selected-red"];
    tabBarController.viewControllers = @[trackersViewController,requestsViewController,friendsViewController,settingsViewController];
    
    
    [((UITabBarItem *)[tabBarController.tabBar.items objectAtIndex:0]) setImage:[UIImage imageNamed:@"trackers-item"]];
    [((UITabBarItem *)[tabBarController.tabBar.items objectAtIndex:1]) setImage:[UIImage imageNamed:@"requests-item"]];
    [((UITabBarItem *)[tabBarController.tabBar.items objectAtIndex:2]) setImage:[UIImage imageNamed:@"friends-item"]];
    [((UITabBarItem *)[tabBarController.tabBar.items objectAtIndex:3]) setImage:[UIImage imageNamed:@"settings-item"]];
    
    MY_APPDELEGATE.tabBarController = tabBarController;
    
    // Set TabBar item badge counts.
    [self setRequestsBadgeCount];
    [self setTrackersBadgeCount];
    
    // Let the device know we want to receive push notifications.
    [MY_APPDELEGATE askToSendPushNotifications];
    
    [navigationController setNavigationBarHidden:YES];
    [navigationController setViewControllers:@[tabBarController] animated:YES];
}

// Let the device know we want to receive push notifications.
- (void)askToSendPushNotifications {
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
}


// If the application receives a push notification it will do something depending on what the notification was for.
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Set the application badge count.
    int badgeCount = [[userInfo objectForKey:@"badge"] intValue];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badgeCount];
    
    NSString *notificationKind = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"kind"]];
    NSLog(notificationKind);
    if([notificationKind isEqualToString:@"Friendship"]) {
        CURRENT_USER.shouldRefreshFriends = (BOOL *)YES;
    }
    if([notificationKind isEqualToString:@"Request"]) {
        [MY_APPDELEGATE.tackerAPI getMeRequests:^(NSArray *array){
            if(array) {
                [CURRENT_USER assignRequestsArray:array];
                CURRENT_USER.shouldRefreshRequests = (BOOL *)YES;
            }
        }];
    }
    if([notificationKind isEqualToString:@"Tracker"]) {
        [MY_APPDELEGATE.tackerAPI getMeTrackers:^(NSArray *array){
            if(array) {
                [CURRENT_USER assignTrackersArray:array];
                CURRENT_USER.shouldRefreshTrackers = (BOOL *)YES;
            }
        }];
    }
}

- (void)setApplicationBadgeCount {
    if(CURRENT_USER) {
        int badgeCount = CURRENT_USER.requestsArray.count;
        for(int x = 0; x < CURRENT_USER.trackersArray.count; x++) {
            Tracker *tracker = (Tracker *)CURRENT_USER.trackersArray[x];
            if(!tracker.seen) {
                badgeCount++;
            }
        }
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badgeCount];
    }
}

- (void)setRequestsBadgeCount {
    if(CURRENT_USER.requestsArray.count == 0) {
        [[[_tabBarController.tabBar items] objectAtIndex:1] setBadgeValue:nil];
    }
    else {
        [[[_tabBarController.tabBar items] objectAtIndex:1] setBadgeValue:[NSString stringWithFormat:@"%lu",(unsigned long)CURRENT_USER.requestsArray.count]];
    }
}

- (void)setTrackersBadgeCount {
    int unseenTrackersCount = 0;
    
    for(int x = 0; x < CURRENT_USER.trackersArray.count; x++) {
        Tracker *tracker = CURRENT_USER.trackersArray[x];
        if(!tracker.seen) {
            unseenTrackersCount++;
        }
    }
    
    if(unseenTrackersCount == 0) {
        [[[_tabBarController.tabBar items] objectAtIndex:0] setBadgeValue:nil];
    }
    else {
        [[[_tabBarController.tabBar items] objectAtIndex:0] setBadgeValue:[NSString stringWithFormat:@"%lu",(unsigned long)unseenTrackersCount]];
    }
}

@end
