//
//  WIObject.h
//  WIKit
//
//  Created by BestWeather on 2021/2/7.
//

#import <Foundation/Foundation.h>

typedef void (^DeallocBlock)(void);

@interface WIObject : NSObject

@property (nonatomic, copy) DeallocBlock block;

- (instancetype)initWithBlock:(DeallocBlock)block;

@end
