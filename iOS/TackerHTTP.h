//
//  TackerHTTP.h
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface TackerHTTP : NSObject

+ (void)getRequest:(NSString *)path parameters:(NSDictionary *)parameters completionBlock:(void(^)(NSArray *array))completionBlock;

+ (void)postRequest:(NSString *)path parameters:(NSDictionary *)paramaeters completionBlock:(void(^)(BOOL success))completionBlock;

+ (void)postResponseRequest:(NSString *)path parameters:(NSDictionary *)paramaeters completionBlock:(void(^)(NSDictionary *response))completionBlock;

@end
