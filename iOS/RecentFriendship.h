//
//  RecentFriendship.h
//  Tacker
//
//  Created by Mohamed Eid on 12/16/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface RecentFriendship : NSObject

/*******************
 Properties
 *******************/

@property (nonatomic) NSString * friendship_id;
@property (nonatomic) User *friendingUser;
@property (nonatomic) NSString * name;

/*******************
 Class Methods
 *******************/

+ (RecentFriendship *)parse:(NSDictionary *)object;

/*******************
 Instance Methods
 *******************/

- (void)destroy:(void(^)(BOOL success))completionBlock;
- (void)create:(void(^)(BOOL success))completionBlock;

@end
