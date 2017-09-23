//
//  RecentFriendship.m
//  Tacker
//
//  Created by Mohamed Eid on 12/16/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "RecentFriendship.h"

@implementation RecentFriendship

/*******************
 Class Methods
 *******************/

+ (RecentFriendship *)parse:(NSDictionary *)object {
    RecentFriendship *recentFriendship = [[RecentFriendship alloc] init];
    
    recentFriendship.friendship_id = [NSString stringWithFormat:@"%@",[object objectForKey:@"id"]];
    recentFriendship.friendingUser = [User parse:[object objectForKey:@"friending_user"]];
    recentFriendship.name = [NSString stringWithFormat:@"%@",[object objectForKey:@"name"]];
    
    return recentFriendship;
}

/*******************
 Instance Methods
 *******************/

- (void)destroy:(void(^)(BOOL success))completionBlock {
    [MY_APPDELEGATE.tackerAPI postFriendshipsDestroy:@{@"friendship": @{@"followed_user_id": self.friendingUser.user_id}} completionBlock:^(BOOL success){}];
}

- (void)create:(void(^)(BOOL success))completionBlock {
    [MY_APPDELEGATE.tackerAPI postFriendshipsCreate:@{@"friendship": @{@"followed_user_id": self.friendingUser.user_id}} completionBlock:^(Friendship *friendship){}];
}
@end
