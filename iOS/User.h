//
//  User.h
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@class BlockedUser, Friendship, Tracker;
@interface User : NSObject

/*******************
 Properties
 *******************/

@property (nonatomic) NSString *user_id;
@property (nonatomic) NSString *email;
@property (nonatomic) BOOL is_blocked;
@property (nonatomic) BOOL is_friended;
@property (nonatomic) BOOL is_pending;
@property (nonatomic) BOOL is_private;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *phone_number;
@property (nonatomic) NSString *username;

@property (nonatomic) NSMutableArray *blockedUsersArray;
@property (nonatomic) NSMutableArray *contactsArray;
@property (nonatomic) NSMutableArray *friendshipsArray;
@property (nonatomic) NSMutableArray *inviteeArray;
@property (nonatomic) NSMutableArray *recentFriendshipsArray;
@property (nonatomic) NSMutableArray *requestsArray;
@property (nonatomic) BOOL *shouldReloadBlockedUsers;
@property (nonatomic) BOOL *shouldRefreshFriends;
@property (nonatomic) BOOL *shouldRefreshRequests;
@property (nonatomic) BOOL *shouldRefreshTrackers;
@property (nonatomic) BOOL *shouldReloadFriends;
@property (nonatomic) BOOL *shouldReloadRequests;
@property (nonatomic) BOOL *shouldReloadTrackers;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (nonatomic) NSMutableArray *trackersArray;

/*******************
 Class Methods
 *******************/

+ (void)create:(NSDictionary *)userDictionary completionBlock:(void (^)(User *user))completionBlock ;
+ (User *)createUserFromDict:(NSDictionary *)userDict;
+ (User *)parse:(NSDictionary *)object;

/*******************
 Instance Methods
 *******************/

- (void)addBlockedUser:(BlockedUser *)blockedUser;
- (void)addFriendship:(Friendship *)friendship;
- (void)addTracker:(Tracker *)tracker;
- (BOOL *)removeBlockedUser:(NSString *)blockedUserId;
- (BOOL *)removeFriendship:(NSString *)friendshipId;
- (BOOL *)removeFriendshipWithUserId:(NSString *)userId;
- (BOOL *)removeTracker:(NSString *)trackerId;
- (void)assignBlockedUsersArray:(NSArray *)array;
- (void)assignFriendshipsArray:(NSArray *)array;
- (void)assignRecentFriendshipsArray:(NSArray *)array;
- (void)assignRequestsArray:(NSArray *)array;
- (void)assignTrackersArray:(NSArray *)array;

- (void)askToTrack:(void(^)(BOOL success))completionBlock;
- (void)block:(void(^)(BOOL success))completionBlock;
- (void)friend:(void(^)(BOOL success))completionBlock;
- (void)unfriend:(void(^)(BOOL success))completionBlock;
@end
