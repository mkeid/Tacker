//
//  Request.h
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface Request : NSObject

/*******************
 Properties
 *******************/

@property (nonatomic) NSString *request_id;
@property (nonatomic) NSString *name;
@property (nonatomic) User *requesting_user;
@property (nonatomic) NSString *kind;

/*******************
 Class Methods
 *******************/

+ (Request *)parse:(NSDictionary *)object;

/*******************
 Instance Methods
 *******************/

- (void)approve:(void(^)(BOOL success))completionBlock;
- (void)destroy:(void(^)(BOOL success))completionBlock;

@end
