//
//  Friendship.h
//  Tacker
//
//  Created by Mohamed Eid on 11/27/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@class User;
@interface Friendship : NSObject

/*******************
 Properties
 *******************/

@property (nonatomic) NSString * friendship_id;
@property (nonatomic) User *friendedUser;
@property (nonatomic) BOOL *is_approved;
@property (nonatomic) NSString *name;

/*******************
 Class Methods
 *******************/

+ (Friendship *)parse:(NSDictionary *)object;

/*******************
 Instance Methods
 *******************/

- (void)destroy:(void(^)(BOOL success))completionBlock;
- (void)update:(void(^)(BOOL success))completionBlock;

@end
