//
//  HDeviceHeader.h
//  HDevice
//
//  Created by C360_liyanjun on 16/3/29.
//  Copyright © 2016年 C360_liyanjun. All rights reserved.
//

#ifndef HDeviceHeader_h
#define HDeviceHeader_h

#if __has_include("HDevice.h")
#import "HDevice.h"
#endif

#if __has_include("HDevice+Camera.h")
#import "HDevice.h"
#import "HDevice+Camera.h"
#endif

#if __has_include("HDevice+Location.h")
#import "HDevice.h"
#import "HDevice+Location.h"
#endif

#if __has_include("HDevice+Network.h")
#import "HDevice.h"
#import "HDevice+Network.h"
#endif

#if __has_include("HDevice+Sound.h")
#import "HDevice.h"
#import "HDevice+Sound.h"
#endif

#if __has_include("HDevice+Motion.h")

#import "HDevice.h"
#import "HDevice+Motion.h"
#endif

#if __has_include("HAppInfo.h")
#import "HAppInfo.h"
#endif

#if __has_include("HSystem.h")
#import "HSystem.h"
#endif

#endif /* HDeviceHeader_h */
