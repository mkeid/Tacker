//
//  TackerAPI.h
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "AppDelegate.h"

#define API_URL (NSString *) @"https://api.tacker.me/v1"

@class BlockedUser, Friendship, Tracker, TackerAuth, User;
@interface TackerAPI : NSObject

/********************
 Properties.
 *******************/
@property (strong, nonatomic) TackerAuth *tackerAuth;

/********************
 Instance methods.
 *******************/
// Blocked Users
- (void)postBlockedUsersCreate:(NSDictionary *)blocked_user completionBlock:(void(^)(BlockedUser *blockedUser))completionBlock;
- (void)postBlockedUsersDestroy:(NSDictionary *)blocked_user completionBlock:(void(^)(BOOL success))completionBlock;

// Friendships
- (void)postFriendshipsAskToCreate:(NSDictionary *)friendship completionBlock:(void(^)(BOOL success))completionBlock;
- (void)postFriendshipsCreate:(NSDictionary *)friendship completionBlock:(void(^)(Friendship *friendship))completionBlock;
- (void)postFriendshipsDestroy:(NSDictionary *)friendship completionBlock:(void(^)(BOOL success))completionBlock;
- (void)postFriendshipsUpdate:(NSDictionary *)friendship completionBlock:(void(^)(Friendship *friendship))completionBlock;

// Me
- (void)getMeBlockedUsers:(void(^)(NSArray *array))completionBlock;
- (void)getMeFriendships:(void(^)(NSArray *array))completionBlock;
- (void)getMeRecentFriendships:(void(^)(NSArray *array))completionBlock;
- (void)getMeRequests:(void(^)(NSArray *array))completionBlock;
- (void)getMeTrackers:(void(^)(NSArray *array))completionBlock;
- (void)postMeUpdateAccount:(NSDictionary *)user completionBlock:(void(^)(NSDictionary *dictionary))completionBlock;
- (void)postMeUpdateName:(NSDictionary *)user completionBlock:(void(^)(NSDictionary *dictionary))completionBlock;
- (void)postMeUpdatePassword:(NSDictionary *)passwords completionBlock:(void(^)(BOOL success))completionBlock;
- (void)postMeUpdatePushDevice:(NSData *)deviceToken;

// Requests
- (void)postRequestsApprove:(NSDictionary *)request completionBlock:(void(^)(NSDictionary *responseObject))completionBlock;
- (void)postRequestsCreate:(NSDictionary *)request completionBlock:(void(^)(BOOL success))completionBlock;
- (void)postRequestsDestroy:(NSDictionary *)request completionBlock:(void(^)(BOOL success))completionBlock;

// Trackers
- (void)postTrackersDestroy:(NSDictionary *)trackerDictionary completionBlock:(void(^)(BOOL success))completionBlock;
- (void)postTrackersSee:(NSDictionary *)trackerDictionary completionBlock:(void(^)(Tracker *tracker))completionBlock;

// Users
- (void)getUsersFindFromContacts:(NSDictionary *)phoneNumbers completionBlock:(void(^)(NSDictionary *dictionary))completionBlock;
- (void)postUsersCreate:(NSDictionary *)user completionBlock:(void(^)(User *user))completionBlock;

@end
