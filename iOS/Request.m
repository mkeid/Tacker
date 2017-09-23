//
//  Request.m
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "Request.h"

@implementation Request

/*******************
 Class Methods
 *******************/

+ (Request *)parse:(NSDictionary *)object {
    Request *request = [[Request alloc] init];
    
    request.request_id = [NSString stringWithFormat:@"%@",[object objectForKey:@"id"]];
    request.name = [NSString stringWithFormat:@"%@",[object objectForKey:@"name"]];
    request.requesting_user = [User parse:[object objectForKey:@"requesting_user"]];
    request.kind = [NSString stringWithFormat:@"%@",[object objectForKey:@"kind"]];
    
    return request;
}

/*******************
 Instance Methods
 *******************/

- (void)approve:(void(^)(BOOL success))completionBlock {
    if([_kind isEqualToString:@"Friendship"]) {
        [MY_APPDELEGATE.tackerAPI postRequestsApprove:@{@"request":@{@"id": self.request_id}} completionBlock:^(NSDictionary *responseObject){
            if([responseObject objectForKey:@"success"]) {
                [MY_APPDELEGATE setApplicationBadgeCount];
                [MY_APPDELEGATE setRequestsBadgeCount];
                completionBlock(YES);
            }
        }];
    }
    else if([_kind isEqualToString:@"Tracker"]) {
        BOOL locationAllowed = [CLLocationManager locationServicesEnabled];
        if (locationAllowed)
        {
            CLLocationManager *locationManager;
            locationManager = [[CLLocationManager alloc] init];
            locationManager.distanceFilter = kCLDistanceFilterNone;
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
            
            double latitude = locationManager.location.coordinate.latitude;
            double longitude = locationManager.location.coordinate.longitude;
            
            [MY_APPDELEGATE.tackerAPI postRequestsApprove:@{@"request":@{@"id": self.request_id}, @"coordinates":@{@"latitude": [NSNumber numberWithDouble:latitude], @"longitude": [NSNumber numberWithDouble:longitude]}} completionBlock:^(NSDictionary *responseObject){
                if([responseObject objectForKey:@"tracker"]) {
                    [CURRENT_USER addTracker:[Tracker parse:[responseObject objectForKey:@"tracker"]]];
                    [MY_APPDELEGATE setApplicationBadgeCount];
                    completionBlock(YES);
                }
            }];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Service Disabled"
                                                            message:@"To re-enable, please go to Settings and turn on Location Service for Tacker."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}

- (void)destroy:(void(^)(BOOL success))completionBlock {
    [MY_APPDELEGATE.tackerAPI postRequestsDestroy:@{@"request":@{@"id": self.request_id}} completionBlock:^(BOOL success){
        [MY_APPDELEGATE setApplicationBadgeCount];
        [MY_APPDELEGATE setRequestsBadgeCount];
        completionBlock(success);
    }];
}

@end
