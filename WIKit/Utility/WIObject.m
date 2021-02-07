//
//  WIObject.m
//  WIKit
//
//  Created by BestWeather on 2021/2/7.
//

#import "WIObject.h"

@implementation WIObject

- (instancetype)initWithBlock:(DeallocBlock)block {
    if (self = [super init]) {
        self.block = block;
    }
    return self;
}

- (void)dealloc {
    self.block ? self.block() : nil;
}

@end
