//
//  Tracker.h
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface Tracker : NSObject

/*******************
 Properties
 *******************/

@property (nonatomic) NSString *tracker_id;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;
@property (nonatomic) NSString *name;
@property (nonatomic) BOOL seen;
@property (nonatomic) User *tracked_user;
@property (nonatomic) NSString *updatedAt;

/*******************
 Class Methods
 *******************/

+ (Tracker *)parse:(NSDictionary *)object;

/*******************
 Instance Methods
 *******************/

- (void)destroy:(void(^)(BOOL success))completionBlock;
- (void)see;

@end
