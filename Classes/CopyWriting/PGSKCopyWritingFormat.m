//
//  CopyWritingFormat.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGSKCopyWritingFormat.h"
#import "PGSKConfig.h"
#import "PGSKMacro.h"

#define Title "${title}"
#define Description "${desc}"
#define URL "${url}"
#define ReplaceIfNeed(str) (str ? str : @"")

//void PGSKConfigLoadCopyWritingInfo(NSDictionary* param,
//                                   PGSKConfigLoadCopyWritingSuccess success,
//                                   PGSKFailBlock fail){
//    
//}

static NSString* PGSKCopyWritingTemplate(NSString* serviceID, NSString* title, NSString* desc, NSString* aURL){
    NSDictionary* temps = PGSKConfigLoad()[PGSKConfigDictionaryKeyCopyWritingTemplate];
    PGSKAssertNilAndClass(temps, NSDictionary)
    NSString* strTemplate = temps[serviceID];
    PGSKAssertNilAndClass(strTemplate, NSString)
    // 准备对象
    PGSKStringConst templTitle = @Title;
    PGSKStringConst templDesc = @Description;
    PGSKStringConst templURL = @URL;
    
    __block NSString* strReplace = strTemplate;
    [@[templTitle, templDesc, templURL] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        strReplace = [strReplace stringByReplacingOccurrencesOfString:obj
                                                           withString:@{templTitle: ReplaceIfNeed(title),
                                                                        templDesc: ReplaceIfNeed(desc),
                                                                        templURL: ReplaceIfNeed(aURL)
                                                                        }[obj]
                      ];
    }];
    return strReplace;
//    NSString * searchStr = strTemplate;
//    NSString * regExpStr = @"[0-9A-Z].";
//    // 创建 NSRegularExpression 对象,匹配 正则表达式
//    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:regExpStr
//                                                                       options:NSRegularExpressionCaseInsensitive
//                                                                         error:nil];
//    NSString *resultStr = searchStr;
//    // 替换匹配的字符串为 searchStr
//    resultStr = [regExp stringByReplacingMatchesInString:searchStr
//                                                 options:NSMatchingReportProgress
//                                                   range:NSMakeRange(0, searchStr.length)
//                                            withTemplate:replacement];
//    NSLog(@"\\nsearchStr = %@\\nresultStr = %@",searchStr,resultStr);
//    return nil;
}

NSString* PGSKCopyWritingFormat(NSString* serviceID, NSString* title, NSString* desc, NSURL* webpageURL){
    return PGSKCopyWritingTemplate(serviceID, title, desc, webpageURL.absoluteString);
}



