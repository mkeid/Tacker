//
//  Tracker.m
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "Tracker.h"

@implementation Tracker

/*******************
 Class Methods
 *******************/

+ (Tracker *)parse:(NSDictionary *)object {
    Tracker *tracker = [[Tracker alloc] init];
    
    tracker.tracker_id = [NSString stringWithFormat:@"%@", [object objectForKey:@"id"]];
    tracker.latitude = [[object objectForKey:@"latitude"] floatValue];
    tracker.longitude = [[object objectForKey:@"longitude"] floatValue];
    tracker.name = [NSString stringWithFormat:@"%@", [object objectForKey:@"name"]];
    tracker.seen = [[object objectForKey:@"seen"] boolValue];
    tracker.tracked_user = [User parse:[object objectForKey:@"tracked_user"]];
    tracker.updatedAt = [NSString stringWithFormat:@"%@", [object objectForKey:@"updated_at"]];
    
    return tracker;
}

/*******************
 Instance Methods
 *******************/

- (void)destroy:(void(^)(BOOL success))completionBlock {
    NSDictionary *tracker = @{@"tracker":@{@"id": _tracker_id}};
    [MY_APPDELEGATE.tackerAPI postTrackersDestroy:tracker completionBlock:^(BOOL success){
        if(success) {
            [CURRENT_USER removeTracker:_tracker_id];
            CURRENT_USER.shouldReloadTrackers = (BOOL *)YES;
            [MY_APPDELEGATE setTrackersBadgeCount];
        }
        completionBlock(success);
    }];
}
- (void)see {
    if(!_seen) {
        NSDictionary *tracker = @{@"tracker":@{@"id": _tracker_id}};
        [MY_APPDELEGATE.tackerAPI postTrackersSee:tracker completionBlock:^(Tracker *tracker){
            if(tracker) {
                _seen = YES;
                CURRENT_USER.shouldReloadTrackers = (BOOL *)YES;
                [MY_APPDELEGATE setTrackersBadgeCount];
                [MY_APPDELEGATE setApplicationBadgeCount];
            }
        }];
    }
}

@end
