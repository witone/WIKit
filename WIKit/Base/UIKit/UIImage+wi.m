//
//  UIImage+wi.m
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import "UIImage+wi.h"

@implementation UIImage (wi)

+ (UIImage *)wi_imageWithColor:(UIColor *)color {
    return [UIImage wi_imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)wi_imageWithColor:(UIColor *)color size:(CGSize)size {
    return [UIImage wi_imageWithColor:color size:size isRound:NO];
}

+ (UIImage *)wi_imageWithColor:(UIColor *)color size:(CGSize)size isRound:(BOOL)isRound {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (isRound) {
        CGFloat x = size.width/2;
        CGFloat y = size.height/2;
        [color set];
        CGContextAddArc(context, x, y, MIN(x, y), 0, M_PI * 2, 0);
        CGContextFillPath(context);
    }else {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (nullable UIImage *)wi_scaleToSize:(CGSize)size {
    CGFloat width = CGImageGetWidth(self.CGImage)/self.scale;
    CGFloat height = CGImageGetHeight(self.CGImage)/self.scale;

    CGFloat verticalRadio = size.height/height;
    CGFloat horizontalRadio = size.width/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1) {
        radio = MAX(verticalRadio, horizontalRadio);
    }else {
        radio = MAX(verticalRadio, horizontalRadio);
    }
    
    width = width * radio;
    height = height * radio;
    
    CGFloat xPos = (size.width - width)/2;
    CGFloat yPos = (size.height - height)/2;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

-(UIImage *)wi_fixOrientation {
    if (self.imageOrientation == UIImageOrientationUp) return self;

    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }

    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }

    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }

    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
