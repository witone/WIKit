//
//  UIDevice+wi.m
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import "UIDevice+wi.h"

@implementation UIDevice (wi)

+ (NSString *)wi_idfv {
    return UIDevice.currentDevice.identifierForVendor.UUIDString ? : @"";
}

+ (BOOL)wi_isPhone {
    static BOOL wi_isPhone;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *deviceName = UIDevice.currentDevice.model;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && deviceName && [deviceName containsString:@"iPhone"]) {
            wi_isPhone = YES;
        }
    });
    return wi_isPhone;
}

+ (NSString *)wi_systemVersion {
    static NSString *wi_systemVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wi_systemVersion = UIDevice.currentDevice.systemVersion;
    });
    return wi_systemVersion;
}

+ (NSString *)wi_appBundleName {
    return [NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleName"];
}

+ (NSString *)wi_appBundleID {
    return [NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

+ (NSString *)wi_appVersion {
    return [NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString *)wi_appBuildVersion {
    return [NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleVersion"];
}

@end
