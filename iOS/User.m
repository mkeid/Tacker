//
//  User.m
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "User.h"

@implementation User

/*******************
 Class Methods
 *******************/

+ (void)create:(NSDictionary *)userDictionary completionBlock:(void (^)(User *user))completionBlock {
    [MY_APPDELEGATE.tackerAPI postUsersCreate:userDictionary completionBlock:^(User *user){
        if(user) {
            MY_APPDELEGATE.tackerAPI.tackerAuth.currentUser = user;
            completionBlock(user);
        }
    }];
}

+ (User *)createUserFromDict:(NSDictionary *)userDict {
    if(!userDict)return nil;
    
    User *user = [[User alloc] init]; // alloc and init user
    
    user.email = [userDict objectForKey:@"email"]; // set user email
    
    // the following sets privacy of user
    user.is_private = NO;
    if([[NSString stringWithFormat:@"%@",[userDict objectForKey:@"is_private"]] isEqualToString:@"1"]) {
        user.is_private = YES;
    }
    user.name = [userDict objectForKey:@"name"]; // set user self given display name
    
    user.phone_number = [userDict objectForKey:@"phone_number"]; // set user phone number
    user.username = [userDict objectForKey:@"username"]; // set user username
    
    user.blockedUsersArray = [[NSMutableArray alloc] init]; // alloc and init blocked users array
    user.friendshipsArray = [[NSMutableArray alloc] init]; // alloc and init friendships array
    user.contactsArray = [[NSMutableArray alloc] init]; // alloc and init contacts array
    user.inviteeArray = [[NSMutableArray alloc] init]; // alloc and init invitee array
    user.recentFriendshipsArray = [[NSMutableArray alloc] init]; // alloc and init recent friendships array
    user.requestsArray = [[NSMutableArray alloc] init]; // alloc and init requests array
    user.trackersArray = [[NSMutableArray alloc] init]; // alloc and init trackers array
    
    user.shouldReloadFriends = NO;
    user.shouldReloadRequests = NO;
    user.shouldReloadTrackers = NO;
    
    
    // the following section sets the various relational arrays belonging to the current user based on JSON data through NSArrays.
    NSMutableArray *array = (NSMutableArray *)[userDict objectForKey:@"blocked_users"];
    // loop through the array and init blocked user objects
    for(int x = 0; x < [array count]; x++) {
        user.blockedUsersArray[x] = (BlockedUser *)[BlockedUser parse:array[x]];
    }
    
    array = (NSMutableArray *)[userDict objectForKey:@"friendships"];
    // loop through the array and init friendship objects
    for(int x = 0; x < [array count]; x++) {
        user.friendshipsArray[x] = (Friendship *)[Friendship parse:array[x]];
    }
    
    array = (NSMutableArray *)[userDict objectForKey:@"recent_friendships"];
    // loop through the array and init recent friendship objects
    for(int x = 0; x < [array count]; x++) {
        user.recentFriendshipsArray[x] = (RecentFriendship *)[RecentFriendship parse:array[x]];
    }
    
    array = (NSMutableArray *)[userDict objectForKey:@"requests"];
    // loop through the array and init request objects
    for(int x = 0; x < [array count]; x++) {
        user.requestsArray[x] = (Request *)[Request parse:array[x]];
    }
    
    array = (NSMutableArray *)[userDict objectForKey:@"trackers"];
    // loop through the array and init tracker objects
    for(int x = 0; x < [array count]; x++) {
        user.trackersArray[x] = (Tracker *)[Tracker parse:array[x]];
    }
    
    return user;
}

// This function allocs and inits a user objects and sets its properties based on JSON data through a NSDictionary.
+ (User *)parse:(NSDictionary *)object {
    User *user = [[User alloc] init]; // alloc and init user object
    
    // set the user object's properties based on JSON data from dictionary
    user.is_friended = [[object objectForKey:@"is_friended"] boolValue];
    user.is_pending = [[object objectForKey:@"is_pending"] boolValue];
    user.is_private = [[object objectForKey:@"is_private"] boolValue];
    user.phone_number = [NSString stringWithFormat:@"%@", [object objectForKey:@"phone_number"]];
    user.user_id = [NSString stringWithFormat:@"%@", [object objectForKey:@"id"]];
    user.username = [NSString stringWithFormat:@"%@", [object objectForKey:@"username"]];
    
    return user;
}

/*******************
 Instance Methods
 *******************/


// This function will add a blockedUser object to the current user's blockedUsers array given a blockedUser object.
- (void)addBlockedUser:(BlockedUser *)blockedUser {
    [_blockedUsersArray addObject:blockedUser];
    _shouldReloadBlockedUsers = (BOOL *)YES;
}

// This function will add a friendship object to the current user's friendships array given a friendship object.
- (void)addFriendship:(Friendship *)friendship {
    [_friendshipsArray addObject:friendship];
    _shouldReloadFriends = (BOOL *)YES;
}

- (void)addTracker:(Tracker *)tracker {
    [_trackersArray addObject:tracker];
    _shouldReloadTrackers = (BOOL *)YES;
    [MY_APPDELEGATE setTrackersBadgeCount];
}

- (BOOL *)removeBlockedUser:(NSString *)blockedUserId {
    BOOL *success = NO;
    int x = 0;
    while(x < [_blockedUsersArray count] && !success) {
        BlockedUser *blockedUser = (BlockedUser *)_blockedUsersArray[x];
        if([blockedUser.blockedUserId isEqualToString:blockedUserId]) {
            [_blockedUsersArray removeObjectAtIndex:x];
            _shouldReloadBlockedUsers = (BOOL *)YES;
            success = (BOOL *)YES;
        }
        x++;
    }
    return success;
}

// This function will remove a friendship object from the current user's friendships array given a friendshio id.
- (BOOL *)removeFriendship:(NSString *)friendshipId {
    BOOL *success = NO;
    int x = 0;
    while(x < [_friendshipsArray count] && !success) {
        Friendship *friendship = (Friendship *)_friendshipsArray[x];
        if([friendship.friendship_id isEqualToString:friendshipId]) {
            [_friendshipsArray removeObjectAtIndex:x];
            _shouldReloadFriends = (BOOL *)YES;
            success = (BOOL *)YES;
        }
        x++;
    }
    return success;
}

- (BOOL *)removeFriendshipWithUserId:(NSString *)userId {
    BOOL *success = NO;
    int x = 0;
    while(x < [_friendshipsArray count] && !success) {
        Friendship *friendship = (Friendship *)_friendshipsArray[x];
        if([friendship.friendedUser.user_id isEqualToString:userId]) {
            [_friendshipsArray removeObjectAtIndex:x];
            success = (BOOL *)YES;
        }
        x++;
    }
    return success;
}

- (BOOL *)removeTracker:(NSString *)trackerId {
    BOOL *success = NO;
    int x = 0;
    while(x < [_trackersArray count] && !success) {
        Tracker *tracker = (Tracker *)_trackersArray[x];
        if([tracker.tracker_id isEqualToString:trackerId]) {
            [_trackersArray removeObjectAtIndex:x];
            success = (BOOL *)YES;
        }
        x++;
    }
    return success;
}

// This function will set the current user's blocked users array based on JSON data through a NSArray.
- (void)assignBlockedUsersArray:(NSArray *)array {
    _blockedUsersArray = [[NSMutableArray alloc] init];
    for(int x = 0; x < [array count]; x++) {
        _blockedUsersArray[x] = (BlockedUser *)[BlockedUser parse:array[x]];
    }
}

// This function will set the current user's friendships array based on JSON data through a NSArray.
- (void)assignFriendshipsArray:(NSArray *)array {
    _friendshipsArray = [[NSMutableArray alloc] init];
    for(int x = 0; x < [array count]; x++) {
        _friendshipsArray[x] = (Friendship *)[Friendship parse:array[x]];
    }
}

// This function will set the current user's recent friendships (users who have recently added him/her) array based on JSON data through a NSArray.
- (void)assignRecentFriendshipsArray:(NSArray *)array {
    _recentFriendshipsArray = [[NSMutableArray alloc] init];
    for(int x = 0; x < [array count]; x++) {
        _recentFriendshipsArray[x] = (RecentFriendship *)[RecentFriendship parse:array[x]];
    }
}

// This function will set the current user's requests array based on JSON data through a NSArray.
- (void)assignRequestsArray:(NSArray *)array {
    _requestsArray = [[NSMutableArray alloc] init];
    for(int x = 0; x < [array count]; x++) {
        _requestsArray[x] = (Request *)[Request parse:array[x]];
    }
}

// This function will set the current user's trackers array based on JSON data through a NSArray.
- (void)assignTrackersArray:(NSArray *)array {
    _trackersArray = [[NSMutableArray alloc] init];
    for(int x = 0; x < [array count]; x++) {
        _trackersArray[x] = (Tracker *)[Tracker parse:array[x]];
    }
}

// This function will send a request to share locations with the user.
- (void)askToTrack:(void(^)(BOOL success))completionBlock {
    CLLocationManager *locationManager;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    double latitude = locationManager.location.coordinate.latitude;
    double longitude = locationManager.location.coordinate.longitude;
    
    NSDictionary *request = @{@"request":@{@"requested_user_id": _user_id, @"kind": @"Tracker", @"latitude": [NSNumber numberWithDouble:latitude], @"longitude": [NSNumber numberWithDouble:longitude]}};
    [MY_APPDELEGATE.tackerAPI postRequestsCreate:request completionBlock:^(BOOL success){
        completionBlock(success);
    }];
}

// This function will destroy all records shared between two users (including friendships) and block the user.
- (void)block:(void(^)(BOOL success))completionBlock {
    [MY_APPDELEGATE.tackerAPI postBlockedUsersCreate:@{@"blocked_user":@{@"blocked_user_id": _user_id}}  completionBlock:^(BlockedUser *blockedUser){
        if(blockedUser) {
            [CURRENT_USER removeFriendshipWithUserId:_user_id];
            [CURRENT_USER addBlockedUser:blockedUser];
            CURRENT_USER.shouldRefreshRequests = (BOOL *)YES;
            CURRENT_USER.shouldRefreshTrackers = (BOOL *)YES;
            CURRENT_USER.shouldReloadBlockedUsers = (BOOL *)YES;
            completionBlock(YES);
        }
        else {
            completionBlock(NO);
        }
    }];
}

// This function will create a friendship with a user.
- (void)friend:(void(^)(BOOL success))completionBlock {
    if(_name.length > 0) {
        [MY_APPDELEGATE.tackerAPI postFriendshipsCreate:@{@"friendship": @{@"followed_user_id": _user_id, @"followed_user_name": _name}} completionBlock:^(Friendship *friendship){
            if(friendship) {
                [CURRENT_USER addFriendship:friendship];
                completionBlock(YES);
            }
            else {
                completionBlock(NO);
            }
        }];
    }
    else {
        [MY_APPDELEGATE.tackerAPI postFriendshipsCreate:@{@"friendship": @{@"followed_user_id": _user_id}} completionBlock:^(Friendship *friendship){
            if(friendship) {
                [CURRENT_USER addFriendship:friendship];
                completionBlock(YES);
            }
            else {
                completionBlock(NO);
            }
        }];
    }
}

// This function will destroy a friendship with a user.
- (void)unfriend:(void(^)(BOOL success))completionBlock {
    [MY_APPDELEGATE.tackerAPI postFriendshipsDestroy:@{@"friendship": @{@"followed_user_id": _user_id}} completionBlock:^(BOOL success){
        
        // if the friendship is destroyed, remove it from the current user's friendships array
        if(success) {
            if([CURRENT_USER removeFriendshipWithUserId:_user_id]) {
                CURRENT_USER.shouldReloadFriends = (BOOL *)YES;
                completionBlock(success);
            }
        }
    }];
}

@end
