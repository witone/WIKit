//
//  NSObject+wi.m
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import "NSObject+wi.h"
#import <objc/objc.h>
#import <objc/runtime.h>

@implementation NSObject (wi)

+ (BOOL)wi_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return NO;
    
    class_addMethod(self, originalSel, class_getMethodImplementation(self, originalSel), method_getTypeEncoding(originalMethod));
    class_addMethod(self, newSel, class_getMethodImplementation(self, newSel), method_getTypeEncoding(newMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, originalSel), class_getInstanceMethod(self, newSel));
    return YES;
}

+ (BOOL)wi_swizzleClassMethod:(SEL)originalSel with:(SEL)newSel {
    Class class = object_getClass(self);
    Method originalMethod = class_getInstanceMethod(class, originalSel);
    Method newMethod = class_getInstanceMethod(class, newSel);
    if (!originalMethod || !newMethod) return NO;
    method_exchangeImplementations(originalMethod, newMethod);
    return YES;
}

+ (void)wi_recordException:(NSException *)exception {
    Class class = NSClassFromString(@"WILogUtils");
    SEL selector = NSSelectorFromString(@"exceptionLog:");
    if (class && [class respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [class performSelector:selector withObject:exception];
#pragma clang diagnostic pop
    }else {
        NSLog(@"%@", exception.description);
    }
}

@end
