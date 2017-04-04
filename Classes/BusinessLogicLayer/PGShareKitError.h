//
//  PGShareKit.h
//  PGShareKit
//
//  Created by linjinxing on 17/1/21.
//  Copyright © 2017年 linjinxing. All rights reserved.
//

#ifndef PGShareKit_h
#define PGShareKit_h

FOUNDATION_EXPORT PGSKStringConst  PGShareKitErrorDomain;

typedef NS_OPTIONS(NSUInteger, PGSKErrorCode) {
    PGSKErrorCodeOK,
    PGSKErrorCodeError,
    PGSKErrorCodeUserCancel,
    PGSKErrorCodeUnsupportDataType,
    PGSKErrorCodeAuthDeny,
    PGSKErrorCodeDataError,
    PGSKErrorCodeUnknown
};

static inline NSError* PGShareKitReturnCancelError(){
    return [NSError errorWithDomain:PGShareKitErrorDomain
                               code:PGSKErrorCodeUserCancel
                           userInfo:@{NSLocalizedDescriptionKey:@"用户取消分享"}];
}



#endif /* PGShareKit_h */
