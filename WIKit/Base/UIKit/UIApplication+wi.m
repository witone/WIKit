//
//  UIApplication+wi.m
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import "UIApplication+wi.h"

@implementation UIApplication (wi)

+ (BOOL)wi_isAppExtension {
    static BOOL wi_isAppExtension = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = NSClassFromString(@"UIApplication");
        if(!cls || ![cls respondsToSelector:@selector(sharedApplication)]) wi_isAppExtension = YES;
        if ([NSBundle.mainBundle.bundlePath hasSuffix:@".appex"]) wi_isAppExtension = YES;
    });
    return wi_isAppExtension;
}

@end
