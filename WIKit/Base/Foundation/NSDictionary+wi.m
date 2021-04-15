//
//  NSDictionary+wi.m
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import "NSDictionary+wi.h"
#import "NSObject+wi.h"

@implementation NSDictionary (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#ifndef DEBUG
        [NSDictionary wi_swizzleClassMethod:@selector(dictionaryWithObjects:forKeys:count:) with:@selector(safe_dictionaryWithObjects:forKeys:count:)];
#endif
    });
}

/// 避免这种crash：@{@"key1": nilObj, @"key2": @"obj2"};
+ (instancetype)safe_dictionaryWithObjects:(const id [])objects forKeys:(const id <NSCopying> [])keys count:(NSUInteger)cnt {
    id nObjects[cnt];
    id nKeys[cnt];
    int i=0, j=0;
    for (; i<cnt && j<cnt; i++) {
        if (objects[i] && keys[i]) {
            nObjects[j] = objects[i];
            nKeys[j] = keys[i];
            j++;
        }
    }
    return [self safe_dictionaryWithObjects:nObjects forKeys:nKeys count:j];
}

@end

@implementation NSMutableDictionary (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#ifndef DEBUG
        Class dictCls = NSClassFromString(@"__NSDictionaryM");
        [dictCls wi_swizzleClassMethod:@selector(setObject:forKey:) with:@selector(safe_setObject:forKey:)];
        [dictCls wi_swizzleClassMethod:@selector(removeObjectForKey:) with:@selector(safe_removeObjectForKey:)];
#endif
    });
}
/// 避免这种crash：[myDict setObject:nilObj forKey:@"your_key"];
- (void)safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!anObject||!aKey) return;
    [self safe_setObject:anObject forKey:aKey];
}

-(void)safe_removeObjectForKey:(id)aKey {
    if (!aKey) {
        NSLog(@"The Key of removeObjectForKey can not be nil");
    }else{
        [self safe_removeObjectForKey:aKey];
    }
}

@end

@implementation NSDictionary (wi)

-(NSString *)wi_jsonString {
    NSString *jsonString;
    NSUInteger count = self.count;
    if (count > 0) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
        jsonString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end
