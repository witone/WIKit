//
//  NSNotification+wi.m
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import "NSNotification+wi.h"

@implementation NSNotification (wi)

+(void)sendNotification:(NSString *)name object:(nullable id)obj userInfo:(NSDictionary *)userInfo {
    [NSNotification sendNotification:YES name:name object:obj userInfo:userInfo];
}

+(void)sendNotification:(BOOL)sendNotification name:(NSString *)name object:(nullable id)obj userInfo:(NSDictionary *)userInfo {
    if (sendNotification) {
        NSNotification *notification = [NSNotification notificationWithName:name object:obj userInfo:userInfo];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
}

@end
