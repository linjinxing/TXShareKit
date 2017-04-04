//
//  PGLocalizationHelper.h
//  Camera360
//
//  Created by SUNDONGLIANG on 15/1/14.
//  Copyright (c) 2015年 Pinguo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PGLanguageDidChangeNotification @"PGLanguageDidChangeNotification"

/**
 *  localization helper
 */
@interface PGLocalizationHelper : NSObject

@property (nonatomic, strong) NSBundle *mBundle;

/**
*  singleton instance
*
*  @return PGLocalizationHelper
*/
+ (PGLocalizationHelper *)sharedInstance;


/** 获取自定义 key 的语言 Bundle */
-(NSBundle *)bundleWithName:(NSString *)name;

@end
