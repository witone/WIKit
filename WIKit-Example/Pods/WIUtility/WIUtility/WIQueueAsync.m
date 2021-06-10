//
//  WIQueueAsync.m
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import "WIQueueAsync.h"

/*dispatch_queue_t wi_dispatch_global_queue() {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("wikit.globalQueue", DISPATCH_QUEUE_CONCURRENT);
    });
    return queue;
}

dispatch_semaphore_t wi_dispatch_global_semaphore() {
    static dispatch_semaphore_t semaphore;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //创建一个初始值为30的semaphore
        semaphore = dispatch_semaphore_create(30);
    });
    return semaphore;
}

void wi_dispatch_global_queue_async(dispatch_block_t block) {
    if (block == NULL) return;
    dispatch_semaphore_t semphore = wi_dispatch_global_semaphore();
    //信号量-1
    dispatch_semaphore_wait(semphore, DISPATCH_TIME_FOREVER);
    dispatch_async(wi_dispatch_global_queue(), ^{
        block();
        //block执行完，信号量+1
        dispatch_semaphore_signal(semphore);
    });
}*/

void wi_dispatch_global_queue_async(dispatch_block_t block) {
    dispatch_async(dispatch_get_global_queue(0, 0), block);
}

void wi_dispatch_main_async_safe(dispatch_block_t block) {
    if (NSThread.isMainThread) {
        block();
    }else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

void wi_dispatch_after_main_queue(CGFloat second,dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}
