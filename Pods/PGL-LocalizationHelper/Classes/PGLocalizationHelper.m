//
//  PGLocalizationHelper.m
//  Camera360
//
//  Created by SUNDONGLIANG on 15/1/14.
//  Copyright (c) 2015年 Pinguo. All rights reserved.
//

#import "PGLocalizationHelper.h"

@interface PGLocalizationHelper()

@property (nonatomic) NSMutableDictionary *customBundles;

@end

@implementation PGLocalizationHelper

+ (instancetype)sharedInstance
{
    static PGLocalizationHelper *sharedHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHelper = [PGLocalizationHelper new];
        sharedHelper.customBundles = [NSMutableDictionary new];
        sharedHelper.mBundle = [sharedHelper getInnerBundle:[NSBundle mainBundle]];
    });

    return sharedHelper;
}


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                   selector:@selector(languageDidChange:)
                       name:PGLanguageDidChangeNotification
                     object:nil];
    }

    return self;
}

- (void)languageDidChange:(NSNotification *)notification {
    self.mBundle = [self getInnerBundle:[NSBundle mainBundle]];
    [self.customBundles removeAllObjects];
}

+ (NSDictionary *)getLangPrefixBundleMaps
{
    static NSDictionary *dicts;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dicts = @{
                  @"th":@"th",
                  @"ja":@"ja",
                  @"id":@"id-ID",
                  @"ko":@"ko",
                  @"es":@"es",
                  @"es-MX":@"es-MX",
                  @"vi":@"vi",
                  @"ru":@"ru",
                  @"pt":@"pt",
                  @"pt-BR":@"pt-BR",
                  @"de":@"de",
                  @"tr":@"tr",
                  @"hi":@"hi",
                  @"ar":@"ar",
                  };
    });
    return dicts;
}


-(NSBundle *)bundleWithName:(NSString *)name
{
    if (self.customBundles[name])
    {
        return self.customBundles[name];
    }

    NSURL *url = [[NSBundle mainBundle] URLForResource:name withExtension:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithURL:url];

    bundle = [self getInnerBundle:bundle];
    self.customBundles[name] = bundle;
    return bundle;
}

-(NSBundle *)getInnerBundle:(NSBundle *)bundle
{
    NSString *language = nil;
    NSArray *languageArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];

    if ((languageArr != nil) && ([languageArr count] > 0))
    {
        language =  [NSString stringWithString:[languageArr firstObject]];
    }

    NSBundle *innerBundle;

    /**
     *  @author Wall-E, 15-08-11 14:08:11
     *
     *  ios9系统中把系统语言和地区绑定在一起作为本地化标识符返回
     *  经测试，在ios9系统(beta5版本)中，繁体中文提供了“繁体中文”、“繁体中文(香港)”和“繁体中文(台湾)”.
     *  (有趣的是，选择“繁体中文”后，系统不提供“繁体中文(台湾)”选项)
     *  (并且，“繁体中文(香港)”和“繁体中文(台湾)”的标识符貌似不受地区的影响)
     *  对于“繁体中文(香港)”和“繁体中文(台湾)”，系统返回的本地化标识符分别为“zh-HK”和“zh-TW”，所以……
     */
    if ([language hasPrefix:@"zh"])
    {
        //代表是中文
        if ([language hasPrefix:@"zh-Hans"])
        {
            //代表是简体中文
            innerBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"zh-Hans" ofType:@"lproj"]];
        }
        else
        {
            //剩下就是繁体中文
            innerBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"zh-Hant" ofType:@"lproj"]];
        }
    }
    
    //有些语言支持具体的地区。
    if ([language hasPrefix:@"es"])
    {
        if ([language isEqualToString:@"es-MX"])
        {
            innerBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"es-MX" ofType:@"lproj"]];
            
        }
        else
        {
            innerBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"es" ofType:@"lproj"]];
        }
    }
    
    if ([language hasPrefix:@"pt"])
    {
        if ([language isEqualToString:@"pt-BR"])
        {
            innerBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"pt-BR" ofType:@"lproj"]];
            
        }
        else
        {
            innerBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"pt" ofType:@"lproj"]];
        }

        // 临时解决
        if (innerBundle == nil)
        {
            innerBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"pt-BR" ofType:@"lproj"]];
        }

    }
    

    if (innerBundle == nil)
    {
        NSString *bundleName;
        for (NSString *key in [self.class getLangPrefixBundleMaps])
        {
            if ([language hasPrefix:key])
            {
                bundleName = [self.class getLangPrefixBundleMaps][key];
                break;
            }
        }
        
        if (bundleName)
        {
            innerBundle = [NSBundle bundleWithPath:[bundle pathForResource:bundleName ofType:@"lproj"]];
        }
        else
        {
            innerBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"en" ofType:@"lproj"]];
        }
        
        if (innerBundle == nil)
        {
            //如果走到了泰文、日文、印尼等等等等条件块，但是工程中又没有配置相应的本地化资源时，再次强制指向英文
            innerBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"en" ofType:@"lproj"]];
        }
    }

    BOOL isDirectory = NO;
    NSString *path = [[innerBundle bundlePath] stringByAppendingPathComponent:@"Localizable.strings"];
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    if (!isExist)
    {
        NSLog(@"没有找到相应的本地化库");
        innerBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"en" ofType:@"lproj"]];
    }

    return innerBundle;
}


@end
