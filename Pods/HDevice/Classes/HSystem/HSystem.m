//
//  HSystem.m
//  Test
//
//  Created by C360_liyanjun on 15/12/14.
//  Copyright © 2015年 C360_liyanjun. All rights reserved.
//

#import "HSystem.h"
#import <UIKit/UIKit.h>

//越狱设备文件路径
#define PG_CydiaPath   @"/Applications/Cydia.app"
#define PG_APTPath     @"/private/var/lib/apt/"

//系统语言前缀
#define kLanguageEnglish @"en"
#define kLanguageThai    @"th"
#define kLanguageZhHans  @"zh-Hans" //简体中文
#define kLanguageZhHant  @"zh-Hant" //繁体中文
#define kLanguageJapan   @"ja"
#define kLanguageZhHan  @"zh-Han" //中文，iOS9出了中文（台湾），因此使用这个前缀判断其他形式中文
#define kLanguageKorean @"ko"
#define kLanguageIndian @"hi"
#define kLanguageVietnam @"vi"
#define kLanguageSpanish @"es"
#define kLanguageSpanishMexico @"es-MX"
#define kLanguagePortuguess @"pt"
#define kLanguagePortuguessBrazil @"pt-BR"
#define kLanguageRussian @"ru"

@implementation HSystem

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static HSystem *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[HSystem alloc]init];
    });
    return instance;
}

/**
 * 获取设备系统名称
 */
- (NSString *)systemName
{
    static NSString *ret = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        ret = [[UIDevice currentDevice] systemName];
        if (ret == nil) {
            ret = @"iOS";
        }
    });
    return ret;
}

- (NSString *)platform
{
    return @"iOS";
}

/**
 *  获取设备系统版本
 */
- (NSString *)systemVersion
{
    static NSString *ret = nil;
    static dispatch_once_t token;

    dispatch_once(&token, ^{
        ret = [[UIDevice currentDevice] systemVersion];
        if (ret == nil) {
            ret = @"";
        }
    });
    return ret;
}

- (BOOL)isJailbroken
{
    static BOOL isJail = NO;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSString *cydiaPath = PG_CydiaPath;
        NSString *aptPath = PG_APTPath;

        if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath])
        {
            isJail = YES;
        }

        if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath])
        {
            isJail = YES;
        }
    });
    return isJail;
}

/**
 *  当前系统语言
 */
- (NSString *)curLanguage
{
    static NSString *currentLanguage = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSArray *languageArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        if ((languageArr != nil) && ([languageArr count] > 0))
        {
            currentLanguage = [NSString stringWithString:[languageArr firstObject]];
            if (currentLanguage)
            {
                //判断中文(简体中文，繁体中文，繁体中文（香港）)
                if ([currentLanguage hasPrefix:kLanguageZhHan])
                {
                    if ([currentLanguage hasPrefix:kLanguageZhHans])
                    {
                        currentLanguage = kLanguageZhHans;
                    }
                    else if ([currentLanguage hasPrefix:kLanguageZhHant])
                    {
                        currentLanguage = kLanguageZhHant;
                    }
                    else
                    {
                        currentLanguage = kLanguageZhHant;
                    }
                }
                else if ([currentLanguage hasPrefix:kLanguageThai])
                {
                    currentLanguage = kLanguageThai;
                }
                else if ([currentLanguage hasPrefix:kLanguageEnglish])
                {
                    currentLanguage = kLanguageEnglish;
                }
                else if ([currentLanguage hasPrefix:kLanguageJapan])
                {
                    currentLanguage = kLanguageJapan;
                }
                else if ([currentLanguage hasPrefix:kLanguageKorean])
                {
                    currentLanguage = kLanguageKorean;
                }
                else if ([currentLanguage hasPrefix:kLanguageIndian])
                {
                    currentLanguage = kLanguageIndian;
                }
                else if ([currentLanguage hasPrefix:kLanguageVietnam])
                {
                    currentLanguage = kLanguageVietnam;
                }
                else if ([currentLanguage isEqualToString:kLanguageSpanish])
                {
                    //es-419, 西班牙(拉丁美)
                    //es-ES, 西班牙(墨西哥)
                    //es,	西班牙
                    currentLanguage = kLanguageSpanish;
                }
                else if ([currentLanguage hasPrefix:kLanguageSpanishMexico])
                {
                    //es-419, 西班牙(拉丁美)
                    //es-ES, 西班牙(墨西哥)
                    //es,	西班牙
                    currentLanguage = kLanguageSpanishMexico;
                }
                else if ([currentLanguage hasPrefix:kLanguagePortuguessBrazil])
                {
                    //pt, 葡萄牙文(巴西)
                    //pt-PT,葡萄牙文(葡萄牙)
                    //pt-BR (巴西葡萄牙文)
                    currentLanguage = kLanguagePortuguessBrazil;
                }
                else if ([currentLanguage hasPrefix:kLanguageRussian])
                {
                    currentLanguage = kLanguageRussian;
                }
                
            }
        }
        else
        {
            currentLanguage = @"";
        }
    });

    return currentLanguage;
}

@end
