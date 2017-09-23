//
//  TackerAuth.h
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SSKeychain/SSKeychain.h>
#import "User.h"

@class User;
@interface TackerAuth : NSObject

/********************
 Properties.
 *******************/
@property (strong, nonatomic) NSArray *sessionCookies;
@property (strong, nonatomic) User *currentUser;

/********************
 Class methods.
 *******************/
+ (void)signIn:(NSDictionary *)credentials completionBlock:(void(^)(NSDictionary *userDictionary))completionBlock;
+ (void)signOut:(void(^)(BOOL success))completionBlock;

/********************
 Instance methods.
 *******************/

@end
