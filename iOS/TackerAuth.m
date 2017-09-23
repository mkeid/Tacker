//
//  TackerAuth.m
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "TackerAuth.h"
#import "AppDelegate.h"
#import "TackerHTTP.h"

@implementation TackerAuth

/********************
 Class methods.
 *******************/

+ (void)signIn:(NSDictionary *)credentials completionBlock:(void(^)(NSDictionary *userDictionary))completionBlock {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:@"%@/auth/signin.json", API_URL] parameters:credentials success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if([responseObject objectForKey:@"errors"]) {
            [MY_APPDELEGATE resetKeychain];
            completionBlock(NO);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid credentials."
                                                            message:@"Your signin / password combination is incorrect."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else {
            [MY_APPDELEGATE resetKeychain];
            completionBlock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionBlock(NO);
        NSLog(@"Error: %@", error);
        [MY_APPDELEGATE resetKeychain];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Server error."
                                                        message:@"Something went wrong. Try again in a bit"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

+ (void)signOut:(void(^)(BOOL success))completionBlock {
    [TackerHTTP postRequest:[NSString stringWithFormat:@"%@/signout",API_URL] parameters:nil completionBlock:^(BOOL success){
        [MY_APPDELEGATE resetKeychain];
        CURRENT_USER = nil;
        completionBlock(success);
    }];
}

/********************
 Instance methods.
 *******************/

@end
