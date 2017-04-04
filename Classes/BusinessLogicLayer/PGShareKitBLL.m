//
//  PGShareKitBLL.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/30.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "PGShareKitBLL.h"
#import "PGSKTypes.h"
#import "PGSKService.h"
#import "PGSKServiceSelectorController.h"
#import "PGSKShareData.h"
#import "PGSKMacro.h"
#import "PGSKConfig.h"
#import "PGSKServiceDefaultSelectorView.h"
#import "PGShareKitError.h"
#import "PGSKCopyWritingFormat.h"
#import "PGSKShareDataComposerPOD+private.h"



PGSKStringConst  PGShareKitErrorDomain = @"PGShareKitErrorDomain";


static RACSignal* PGShareKitLoadConfigSignal();
static RACSignal* PGShareKitCreateShareSignal(id data,
                                              id<PGSKServiceInfo> serviceInfo,
                                              PGSKServiceSupportedDataType type);
static RACSignal* PGShareKitCreateShareSelectorSignal(NSArray<id<PGSKServiceInfo>> *services);
static RACSignal* PGShareKitCreateShareDataAndTransformIfNeedSignal(PGShareKitBLLGetSharInfo getParamBlock,
                                                                    NSObject<PGSKServiceInfo>* serviceInfo);

//void PGShareKitBLLShare(PGShareKitBLLGetSharInfo getParamBlock,
//                        PGSKSuccessBlock success,
//                        PGSKFailBlock fail)
RACSignal* PGShareKitBLLShare(PGShareKitBLLGetSharInfo getParamBlock)
{
   return [[[/* 加载配置数据 */
       [PGShareKitLoadConfigSignal()
       /* 过滤没安装的 */
        map:^id(NSArray<id<PGSKServiceInfo>> *services) {
            return [[services.rac_sequence filter:^BOOL(id value) {
                return PGShareKitServiceCanShare(value);
            }]
                    array];
    }]/* 让用户选择分享平台 */
     flattenMap:^RACStream *(NSArray<id<PGSKServiceInfo>> *services) {
         return PGShareKitCreateShareSelectorSignal(services);
    }]
      /* 获取分享的参数数据，必须时进行转换，比如twitter和微博 */
     flattenMap:^RACStream *(NSObject<PGSKServiceInfo>* serviceInfo) {
         return PGShareKitCreateShareDataAndTransformIfNeedSignal(getParamBlock, serviceInfo);
    }]
     /* 分享到社交平台 */
     flattenMap:^RACStream *(RACTuple* tuple) {
         return PGShareKitCreateShareSignal(tuple.first, tuple.second, (PGSKServiceSupportedDataType)[tuple.third integerValue]);
     }];
}

static RACSignal* PGShareKitLoadConfigSignal(){
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        /* 从配置获取分享的社交平台, 配置有可能从服务器加载，因此这里保留异步，建议从服务器加载 */
        //        PGSKServiceInfoLoadConfig(nil, ^(NSArray<id<PGSKServiceInfo>> *services) {
        //            [subscriber sendNext:services];
        //            [subscriber sendCompleted];
        //        }, ^(NSError *error) {
        //            [subscriber sendError:error];
        //        });
        [subscriber sendNext:PGSKServiceInfoLoadSNS()];
        [subscriber sendCompleted];
        return nil;
    }];
}

/**
 twitter和新浪微博需要调用PGSKCopyWritingFormat进行数据转换，转换为PGSKShareDataComposerPOD

 @param type 调用端传递过来的数据类型
 @param data 原始数据类型，PGSKShareData中的一种
 @param serviceInfo 用户选择的社交平台
 @return 返回转换后的数据类型
 */
static RACTuple* PGShareKitTransformShareDataIfNeed(PGSKServiceSupportedDataType type,
                                                    id data,
                                                    NSObject<PGSKServiceInfo>* serviceInfo)
{
    PGSKAssertNilAndConformsToProtocol(data, PGSKShareDataBase);
    id newData = data;
    PGSKServiceSupportedDataType newType = type;
    if ([@[kPKSGServiceIDTwitter, kPKSGServiceIDWeiBo] containsObject:serviceInfo.ID]) {
        NSURL* url = nil;
        if (PGSKServiceSupportedDataTypeWebPage & type) {
            PGSKAssertNilAndConformsToProtocol(data, PGSKShareDataWebPage);
            url = ((id<PGSKShareDataWebPage>)data).url;
        }
        UIImage* thumbnail = nil;
        if ([data respondsToSelector:@selector(thumbnail)]) {
            thumbnail = [data thumbnail];
        }
        id<PGSKShareDataBase> base = (id<PGSKShareDataBase>)data;
        newData = [PGSKShareDataComposerPOD shareDataPODWithContent:PGSKCopyWritingFormat(serviceInfo.ID, base.title, base.desc, url)
                                                                url:url
                                                      thubnailImage:thumbnail];
        newType = PGSKServiceSupportedDataTypeComposer;
    }
    return RACTuplePack(newData,
                        serviceInfo,
                        @(newType));
}
/**
 从调用客户端获取参数，有可能这时候需要上传视频等其它异步操作，因此采用getParamBlock异步方式

 @param getParamBlock 调用端实现这个block，回传数据给pgsharekit
 @param serviceInfo <#serviceInfo description#>
 @return <#return value description#>
 */
static RACSignal* PGShareKitCreateShareDataAndTransformIfNeedSignal(PGShareKitBLLGetSharInfo getParamBlock,
                                            NSObject<PGSKServiceInfo>* serviceInfo){
    assert(getParamBlock);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        getParamBlock(serviceInfo.supportedShareTypes,
                      ^(PGSKServiceSupportedDataType type, id data){
                          [subscriber sendNext:PGShareKitTransformShareDataIfNeed(type, data, serviceInfo)];
                          [subscriber sendCompleted];
                      },
                      ^(NSError* error){
                          [subscriber sendError:error];
                      }
                      );
        return nil;
    }];
}

static RACSignal* PGShareKitCreateShareSelectorSignal(NSArray<id<PGSKServiceInfo>> *services){
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        static PGSKServiceSelectorController* con = nil;
        con = [PGSKServiceSelectorController controllerWithselectorView:[PGSKServiceDefaultSelectorView new]
                                                                service:services];
        [con showWithSelectBlock:^(id<PGSKServiceInfo> service) {
            [subscriber sendNext:service];
            [subscriber sendCompleted];
            con = nil;
        } cancelBlock:^(id sender) {
            [subscriber sendError:PGShareKitReturnCancelError()];
            con = nil;
        }];
        return nil;
    }];
}

static RACSignal* PGShareKitCreateShareSignal(id data, id<PGSKServiceInfo> serviceInfo, PGSKServiceSupportedDataType type){
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSObject<PGSKService>* service = PGShareKitCreateServiceFactory(serviceInfo);
        assert([service conformsToProtocol:@protocol(PGSKService)]);
        service.success = ^(id response){
            [subscriber sendNext:response];
            [subscriber sendCompleted];
        };
        service.fail = ^(NSError* error){
            [subscriber sendError:error];
        };
        service.cancel = ^(id sender){
            [subscriber sendError:PGShareKitReturnCancelError()];
        };
        SEL selector = PGShareKitGetServiceSelector(type);
        ((void (*)(id, SEL, id))[service methodForSelector:selector])(service, selector, data);
        return nil;
    }];
    
    //    assert(dict[kPKSGServiceIDDataDictKeyDataType]);
    //                 NSassert(dict[PKSGServiceDataDictKeyDataType], @"PKSGServiceDataDictKeyDataType必须要传");
    //    PGSKServiceSupportedDataType type = [dict[kPKSGServiceIDDataDictKeyDataType] unsignedIntegerValue];
    
    //    id data = PGShareKitCreateData(type, dict);
    //    [data setValuesForKeysWithDictionary:dict];
    //    if (PGSKServiceSupportedDataTypeImage == type){
    //        assert([data conformsToProtocol:@protocol(PGSKShareDataImage)]);
    //    }
    //    if (PGSKServiceSupportedDataTypeVideo == type){
    //        assert([data conformsToProtocol:@protocol(PGSKShareDataVideo)]);
    //    }
    //    if (PGSKServiceSupportedDataTypeWebPage == type){
    //        assert([data conformsToProtocol:@protocol(PGSKShareDataWebPage)]);
    //    }
}





