//
//  PGLocalizationDefines.h
//  PGL-18nHelperDemo
//
//  Created by jtang on 15/11/5.
//  Copyright © 2015年 PG. All rights reserved.
//

#ifndef PGLocalizationDefines_h
#define PGLocalizationDefines_h


#import "PGLocalizationHelper.h"


#define PText(key, ignore_param) \
NSLocalizedStringFromTableInBundle(key, nil, [PGLocalizationHelper sharedInstance].mBundle, nil)
// 文案
#define NSLocalizedStringFixed(key, ignore_param) \
NSLocalizedStringFromTableInBundle(key, nil, [PGLocalizationHelper sharedInstance].mBundle, nil)

#define NSLocalizedStringCustom(key, bundle) \
NSLocalizedStringFromTableInBundle(key, nil, bundle, nil)

#define NSLocalizedStringFixedFromError(key, ignore_param) \
NSLocalizedStringFromTableInBundle(key, @"Error", [PGLocalizationHelper sharedInstance].mBundle, nil)

#endif /* PGLocalizationDefines_h */
