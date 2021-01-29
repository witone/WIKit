//
//  NSObject+wi.h
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DeallocBlock)(void);

@interface NSObject (wi)

@property (nonatomic, copy) DeallocBlock wi_block;

+ (BOOL)wi_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;

+ (BOOL)wi_swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;

+ (void)wi_recordException:(NSException *)exception;

@end
