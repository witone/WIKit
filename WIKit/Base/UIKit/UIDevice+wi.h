//
//  UIDevice+wi.h
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (wi)

@property(class, nonatomic, readonly) NSString *wi_idfv;
@property(class, nonatomic, readonly) BOOL wi_isPhone;
@property(class, nonatomic, readonly) NSString *wi_systemVersion;
@property(class, nonatomic, readonly) NSString *wi_appBundleName;
@property(class, nonatomic, readonly) NSString *wi_appBundleID;
@property(class, nonatomic, readonly) NSString *wi_appVersion;
@property(class, nonatomic, readonly) NSString *wi_appBuildVersion;

@end

NS_ASSUME_NONNULL_END
