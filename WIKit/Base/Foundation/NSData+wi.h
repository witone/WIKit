//
//  NSData+wi.h
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (wi)

- (nullable NSData *)wi_gzipInflate;

- (nullable NSData *)wi_gzipDeflate;

- (nullable NSData *)wi_zlibInflate;

- (nullable NSData *)wi_zlibDeflate;

@end

NS_ASSUME_NONNULL_END
