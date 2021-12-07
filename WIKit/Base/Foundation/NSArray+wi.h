//
//  NSArray+wi.h
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (wi)

//针对按key排好序的数组查重
-(NSArray *)wi_removeDupWithKey:(NSString *)key ascending:(BOOL)ascending;

-(NSArray *)wi_sortWithKey:(NSString *)key ascending:(BOOL)ascending;

@end
