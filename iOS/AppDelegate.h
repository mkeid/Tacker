//
//  AppDelegate.h
//  Tacker
//
//  Created by Mohamed Eid on 11/15/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <iAd/iAd.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <QuartzCore/QuartzCore.h>
#import <SSKeychain/SSKeychain.h>

#import "TackerAPI.h"
#import "TackerAuth.h"
#import "UIViewController+Utilities.h"

#import "BlockedUser.h"
#import "Friendship.h"
#import "RecentFriendship.h"
#import "Request.h"
#import "Tracker.h"
#import "User.h"

#define MY_APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define CURRENT_USER MY_APPDELEGATE.tackerAPI.tackerAuth.currentUser

@class TackerAPI;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)resetKeychain;
- (void)showWelcome;
- (void)showSession;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

// Custom
@property (strong, nonatomic) TackerAPI *tackerAPI;
@property (strong, nonatomic) UITabBarController *tabBarController;

- (void)switchToSession:(UINavigationController *)navigationController;
- (void)askToSendPushNotifications;
- (void)setApplicationBadgeCount;
- (void)setRequestsBadgeCount;
- (void)setTrackersBadgeCount;

@end
