//
//  TackerAPI.m
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "TackerAPI.h"
#import "TackerHTTP.h"
#import "AddFriendsViewController.h"
#import "FriendsViewController.h"
#import "RequestsViewController.h"
#import "SignUpViewController.h"
#import "TrackersViewController.h"
#import "User.h"

@implementation TackerAPI

/********************
 Instance methods.
 *******************/

// Blocked Users
- (void)postBlockedUsersCreate:(NSDictionary *)blocked_user completionBlock:(void(^)(BlockedUser *blockedUser))completionBlock{
    [TackerHTTP postResponseRequest:[NSString stringWithFormat:@"%@/blocked_users/create.json", API_URL] parameters:blocked_user completionBlock:^(NSDictionary *response){
        completionBlock([BlockedUser parse:[response objectForKey:@"blocked_user"]]);
    }];
}
- (void)postBlockedUsersDestroy:(NSDictionary *)blocked_user completionBlock:(void(^)(BOOL success))completionBlock {
    [TackerHTTP postRequest:[NSString stringWithFormat:@"%@/blocked_users/destroy.json", API_URL] parameters:blocked_user completionBlock:^(BOOL success){
        completionBlock(success);
    }];
}

// Friendships
- (void)postFriendshipsAskToCreate:(NSDictionary *)friendship completionBlock:(void(^)(BOOL success))completionBlock; {
    [TackerHTTP postRequest:[NSString stringWithFormat:@"%@/friendships/ask_to_create.json", API_URL] parameters:friendship completionBlock:^(BOOL success){
        completionBlock(success);
    }];
}
- (void)postFriendshipsCreate:(NSDictionary *)friendship completionBlock:(void(^)(Friendship *friendship))completionBlock; {
    [TackerHTTP postResponseRequest:[NSString stringWithFormat:@"%@/friendships/create.json", API_URL] parameters:friendship completionBlock:^(NSDictionary *response){
        completionBlock([Friendship parse:[response objectForKey:@"friendship"]]);
    }];
}
- (void)postFriendshipsDestroy:(NSDictionary *)friendship completionBlock:(void(^)(BOOL success))completionBlock {
    [TackerHTTP postRequest:[NSString stringWithFormat:@"%@/friendships/destroy.json", API_URL] parameters:friendship completionBlock:^(BOOL success){
        completionBlock(success);
    }];
}
- (void)postFriendshipsUpdate:(NSDictionary *)friendship completionBlock:(void(^)(Friendship *friendship))completionBlock {
    [TackerHTTP postResponseRequest:[NSString stringWithFormat:@"%@/friendships/update.json", API_URL] parameters:friendship completionBlock:^(NSDictionary *response){
        completionBlock([Friendship parse:[response objectForKey:@"friendship"]]);
    }];
}

// Me
- (void)getMeBlockedUsers:(void(^)(NSArray *array))completionBlock {
    [TackerHTTP getRequest:[NSString stringWithFormat:@"%@/me/blocked_users.json", API_URL] parameters:nil completionBlock:^(NSArray *array){
        completionBlock(array);
    }];
}
- (void)getMeFriendships:(void(^)(NSArray *array))completionBlock {
    [TackerHTTP getRequest:[NSString stringWithFormat:@"%@/me/friendships.json", API_URL] parameters:nil completionBlock:^(NSArray *array){
        completionBlock(array);
    }];
}
- (void)getMeRequests:(void(^)(NSArray *array))completionBlock {
    [TackerHTTP getRequest:[NSString stringWithFormat:@"%@/me/requests.json", API_URL] parameters:nil completionBlock:^(NSArray *array){
        completionBlock(array);
    }];
}
- (void)getMeRecentFriendships:(void(^)(NSArray *array))completionBlock {
    [TackerHTTP getRequest:[NSString stringWithFormat:@"%@/me/recent_friendships.json", API_URL] parameters:nil completionBlock:^(NSArray *array){
        completionBlock(array);
    }];
}
- (void)getMeTrackers:(void(^)(NSArray *array))completionBlock {
    [TackerHTTP getRequest:[NSString stringWithFormat:@"%@/me/trackers.json", API_URL] parameters:nil completionBlock:^(NSArray *array){
        completionBlock(array);
    }];
}
- (void)postMeUpdateAccount:(NSDictionary *)user completionBlock:(void(^)(NSDictionary *dictionary))completionBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:@"%@/me/update_account.json", API_URL] parameters:user success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completionBlock((NSDictionary *)responseObject);
        
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
- (void)postMeUpdateName:(NSDictionary *)user completionBlock:(void(^)(NSDictionary *dictionary))completionBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:@"%@/me/update_name.json", API_URL] parameters:user success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completionBlock((NSDictionary *)responseObject);
        
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
- (void)postMeUpdatePassword:(NSDictionary *)passwords completionBlock:(void(^)(BOOL success))completionBlock {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:@"%@/me/update_password.json", API_URL] parameters:passwords success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = responseObject;
        
        if([(NSDictionary *)responseObject objectForKey:@"errors"]) {
            completionBlock(NO);
        }
        else {
            completionBlock(YES);
        }
        
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)postMeUpdatePushDevice:(NSData *)deviceToken; {
    NSDictionary *parameters = @{@"token": [NSString stringWithFormat:@"%@",deviceToken]};
    [TackerHTTP postRequest:[NSString stringWithFormat:@"%@/me/update_push_device.json", API_URL]  parameters:parameters completionBlock:^(BOOL success){}];
}

// Requests
- (void)postRequestsApprove:(NSDictionary *)request completionBlock:(void(^)(NSDictionary *responseObject))completionBlock {
    [TackerHTTP postResponseRequest:[NSString stringWithFormat:@"%@/requests/approve.json", API_URL] parameters:request completionBlock:^(NSDictionary *response){
        completionBlock(response);
    }];
}

- (void)postRequestsCreate:(NSDictionary *)request completionBlock:(void(^)(BOOL success))completionBlock {
    [TackerHTTP postRequest:[NSString stringWithFormat:@"%@/requests/create.json", API_URL] parameters:request completionBlock:^(BOOL success){
        completionBlock(success);
    }];
}

- (void)postRequestsDestroy:(NSDictionary *)request completionBlock:(void(^)(BOOL success))completionBlock {
    [TackerHTTP postRequest:[NSString stringWithFormat:@"%@/requests/destroy.json", API_URL] parameters:request completionBlock:^(BOOL success){
        completionBlock(success);
    }];
}

// Trackers
- (void)postTrackersDestroy:(NSDictionary *)trackerDictionary completionBlock:(void(^)(BOOL success))completionBlock {
    [TackerHTTP postRequest:[NSString stringWithFormat:@"%@/trackers/destroy.json", API_URL]  parameters:trackerDictionary completionBlock:^(BOOL success){completionBlock(success);}];
}
- (void)postTrackersSee:(NSDictionary *)trackerDictionary completionBlock:(void (^)(Tracker *))completionBlock {
    [TackerHTTP postResponseRequest:[NSString stringWithFormat:@"%@/trackers/see.json", API_URL] parameters:trackerDictionary completionBlock:^(NSDictionary *response){
        if([response objectForKey:@"tracker"])completionBlock([Tracker parse:[response objectForKey:@"tracker"]]);
    }];
}

// Users
- (void)getUsersFindFromContacts:(NSDictionary *)phoneNumbers completionBlock:(void(^)(NSDictionary *dictionary))completionBlock {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@/users/find_from_contacts.json", API_URL] parameters:phoneNumbers success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completionBlock((NSDictionary *)responseObject);
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionBlock(nil);
        NSLog(@"Error: %@", error);
    }];
}
- (void)postUsersCreate:(NSDictionary *)user completionBlock:(void(^)(User *user))completionBlock {
    
    [TackerHTTP postResponseRequest:[NSString stringWithFormat:@"%@/users/create.json", API_URL] parameters:user completionBlock:^(NSDictionary *response){
        NSLog([NSString stringWithFormat:@"%@",response]);
        if([response objectForKey:@"errors"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                            message:[NSString stringWithFormat:@"%@",[response objectForKey:@"errors"]]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            [alert show];
            
            UINavigationController *navigationController = (UINavigationController *)MY_APPDELEGATE.window.rootViewController;
            SignUpViewController *signUpViewController = (SignUpViewController *)navigationController.visibleViewController;
            [signUpViewController.hud hide:YES];
        }
        User *user = [User createUserFromDict:[response objectForKey:@"me"]];
        completionBlock(user);
    }];
}

@end
