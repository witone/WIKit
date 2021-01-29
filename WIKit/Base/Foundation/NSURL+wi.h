//
//  NSURL+wi.h
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (wi)

+ (nullable NSURL *)wi_URLWithString:(nonnull NSString *)string;

+ (NSDictionary *)paramsInURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
