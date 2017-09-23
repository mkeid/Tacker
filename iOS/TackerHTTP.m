//
//  TackerHTTP.m
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "TackerHTTP.h"

@implementation TackerHTTP

+ (void)getRequest:(NSString *)path parameters:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *array))completionBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = responseObject;
        
        // if the response JSON contains no errors, return the response object
        completionBlock((NSArray *)responseObject);
        
        
        NSLog(@"JSON: %@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // if the response JSON contains errors, return nil
        completionBlock(nil);
    }];
}

+ (void)postRequest:(NSString *)path parameters:(NSDictionary *)parameters completionBlock:(void(^)(BOOL success))completionBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = responseObject;
        
        // if the response JSON contains no errors, return the response object
        if([responseObject objectForKey:@"errors"]) {
            completionBlock(NO);
        }
        else {
            completionBlock(YES);
        }
        
        NSLog(@"JSON: %@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // if the response JSON contains errors, return nil
        //completionBlock(NO);
        NSLog(@"JSON: %@", operation.responseObject);
    }];
}

+ (void)postResponseRequest:(NSString *)path parameters:(NSDictionary *)parameters completionBlock:(void(^)(NSDictionary *response))completionBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = responseObject;
        
        completionBlock(responseObject);
        
        if([responseObject objectForKey:@"alerts"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:(NSString *)[responseObject objectForKey:@"alerts"]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        NSLog(@"JSON: %@", operation.responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // if the response JSON contains errors, return nil
        completionBlock(nil);
        NSLog(@"JSON: %@", operation.responseObject);
    }];
}

@end
