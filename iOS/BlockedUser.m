//
//  BlockedUser.m
//  Tacker
//
//  Created by Mohamed Eid on 12/16/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "BlockedUser.h"

@implementation BlockedUser

/*******************
 Class Methods
 *******************/

+ (BlockedUser *)parse:(NSDictionary *)object {
    BlockedUser *blockedUser = [[BlockedUser alloc] init];
    
    blockedUser.blockedUserId = [NSString stringWithFormat:@"%@",[object objectForKey:@"id"]];
    blockedUser.user = [User parse:[object objectForKey:@"blocked_user"]];
    
    return  blockedUser;
}

/*******************
 Instance Methods
 *******************/

- (void)destroy:(void(^)(BOOL success))completionBlock {
    NSDictionary *blockedUserDictionary = @{@"blocked_user":@{@"blocked_user_id":_user.user_id}};
    [MY_APPDELEGATE.tackerAPI postBlockedUsersDestroy:blockedUserDictionary completionBlock:^(BOOL success){
        if(success) {
            [CURRENT_USER removeBlockedUser:_blockedUserId];
        }
        completionBlock(success);
    }];
}

@end
