//
//  NSNotification+wi.h
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNotification (wi)

+(void)sendNotification:(NSString *)name object:(nullable id)obj userInfo:(NSDictionary *)userInfo;
+(void)sendNotification:(BOOL)sendNotification name:(NSString *)name object:(nullable id)obj userInfo:(NSDictionary *)userInfo;

@end

NS_ASSUME_NONNULL_END
