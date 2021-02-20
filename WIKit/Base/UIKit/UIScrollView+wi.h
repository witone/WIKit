//
//  UIScrollView+wi.h
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WIScrollViewGestureDelegate <NSObject>

@optional

- (BOOL)scrollView:(UIScrollView *)scrollView gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;
- (BOOL)scrollView:(UIScrollView *)scrollView gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

@end

@interface UIScrollView (wi)

@property (nonatomic, weak) id<WIScrollViewGestureDelegate> wi_gestureDelegate;

- (void)wi_scrollToTop;

- (void)wi_scrollToBottom;

- (void)wi_scrollToLeft;

- (void)wi_scrollToRight;

- (void)wi_scrollToTopAnimated:(BOOL)animated;

- (void)wi_scrollToBottomAnimated:(BOOL)animated;

- (void)wi_scrollToLeftAnimated:(BOOL)animated;

- (void)wi_scrollToRightAnimated:(BOOL)animated;

@end
