//
//  BlockedUser.h
//  Tacker
//
//  Created by Mohamed Eid on 12/16/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@class  User;
@interface BlockedUser : NSObject

/*******************
 Properties
 *******************/

@property (nonatomic) NSString *blockedUserId;
@property (nonatomic) User *user;

/*******************
 Class Methods
 *******************/

+ (BlockedUser *)parse:(NSDictionary *)object;

/*******************
 Instance Methods
 *******************/

- (void)destroy:(void(^)(BOOL success))completionBlock;

@end
