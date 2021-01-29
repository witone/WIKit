//
//  WIKitMacro.h
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef WIKitMacro_h
#define WIKitMacro_h

#define WIWEAK_SELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define WISTRONG_SELF(strongSelf,weakSelf)  __strong __typeof(weakSelf)strongSelf = weakSelf;

//弧度转角度
#define WI_RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
//角度转弧度
#define WI_DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

#endif /* WIKitMacro_h */
