//
//  Friendship.m
//  Tacker
//
//  Created by Mohamed Eid on 11/27/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "Friendship.h"

@implementation Friendship

/*******************
 Class Methods
 *******************/

+ (Friendship *)parse:(NSDictionary *)object {
    if(!object)return nil;
    
    Friendship *friendship = [[Friendship alloc] init];
    
    friendship.friendship_id = [NSString stringWithFormat:@"%@", [object objectForKey:@"id"]];
    friendship.friendedUser = [User parse:[object objectForKey:@"friended_user"]];
    friendship.name = [NSString stringWithFormat:@"%@", [object objectForKey:@"name"]];
    
    return  friendship;
}

/*******************
 Instance Methods
 *******************/

- (void)destroy:(void(^)(BOOL success))completionBlock {
    [MY_APPDELEGATE.tackerAPI postFriendshipsDestroy:@{@"friendship":@{@"id":_friendship_id}} completionBlock:^(BOOL success){
        
        // if the friendship is destroyed, remove it from the current user's friendships array
        if(success) {
            if([CURRENT_USER removeFriendship:_friendship_id]) {
                CURRENT_USER.shouldReloadFriends = (BOOL *)YES;
                completionBlock(success);
            }
        }
    }];}

- (void)update:(void(^)(BOOL success))completionBlock {
    [MY_APPDELEGATE.tackerAPI postFriendshipsUpdate:@{@"friendship":@{@"id":_friendship_id, @"followed_user_name": self.name}} completionBlock:^(Friendship *friendship){
        if(friendship) {
            [CURRENT_USER removeFriendship:_friendship_id];
            [CURRENT_USER addFriendship:friendship];
            CURRENT_USER.shouldRefreshRequests = (BOOL *)YES;
            CURRENT_USER.shouldRefreshTrackers = (BOOL *)YES;
            completionBlock(YES);
        }
        else {
            completionBlock(NO);
        }
    }];;
}

@end
