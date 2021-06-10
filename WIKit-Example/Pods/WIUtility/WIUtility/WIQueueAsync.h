//
//  WIQueueAsync.h
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIGeometry.h>

#ifndef WI_LOCK
#define WI_LOCK(lock) dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
#endif

#ifndef WI_UNLOCK
#define WI_UNLOCK(lock) dispatch_semaphore_signal(lock);
#endif

/**
 创建一个GCD异步线程
 用于：替换dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{});
 并设定semaphore的值为30
 */
//UIKIT_EXTERN void wi_dispatch_global_queue_async(dispatch_block_t block);

UIKIT_EXTERN void wi_dispatch_global_queue_async(dispatch_block_t block);

UIKIT_EXTERN void wi_dispatch_main_async_safe(dispatch_block_t block);

UIKIT_EXTERN void wi_dispatch_after_main_queue(CGFloat second,dispatch_block_t block);
