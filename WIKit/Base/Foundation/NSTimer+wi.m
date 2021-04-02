//
//  NSTimer+wi.m
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import "NSTimer+wi.h"
#import "WIWeakProxy.h"

@implementation NSTimer (wi)

+ (void)_wi_ExecBlock:(NSTimer *)timer {
    if ([timer userInfo]) {
        void (^block)(NSTimer *timer) = (void (^)(NSTimer *timer))[timer userInfo];
        block(timer);
    }
}

+ (NSTimer *)wi_scheduledTimerWithTimeInterval:(NSTimeInterval)ti block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats {
    return [NSTimer scheduledTimerWithTimeInterval:ti target:self selector:@selector(_wi_ExecBlock:) userInfo:[block copy] repeats:repeats];
}

+ (NSTimer *)wi_timerWithTimeInterval:(NSTimeInterval)ti block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats {
    return [NSTimer timerWithTimeInterval:ti target:self selector:@selector(_wi_ExecBlock:) userInfo:[block copy] repeats:repeats];
}

+ (NSTimer *)wi_scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)repeats {
    return [NSTimer scheduledTimerWithTimeInterval:ti target:[WIWeakProxy proxyWithTarget:aTarget] selector:aSelector userInfo:userInfo repeats:repeats];
}

+ (NSTimer *)wi_timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)repeats {
    return [NSTimer timerWithTimeInterval:ti target:[WIWeakProxy proxyWithTarget:aTarget] selector:aSelector userInfo:userInfo repeats:repeats];
}

+ (void)wi_timerStop:(NSTimer *)timer {
    if (timer && timer.isValid) [timer invalidate];
    if (timer) timer = nil;
}

- (void)wi_timerStart {
    [[NSRunLoop mainRunLoop] addTimer:self forMode:NSRunLoopCommonModes];
}

- (void)wi_timerPause {
    //if (!self.isValid) return;
    [self setFireDate:[NSDate distantFuture]];
}

- (void)wi_timerResume {
    //if (!self.isValid) return;
    [self setFireDate:[NSDate date]];
}

@end
