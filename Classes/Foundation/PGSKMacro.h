//
//  PGSKMacro.h
//  PGShareKit
//
//  Created by linjinxing on 17/2/7.
//  Copyright © 2017年 linjinxing. All rights reserved.
//

#ifndef PGSKMacro_h
#define PGSKMacro_h

#define PGSKAssertNil(object) NSCAssert(nil != object, @" " #object " 不能为空");

#define PGSKAssertClass(object, Class) NSCAssert([object isKindOfClass:[NSString class]], @"%@ 必须是%@类", @#object, NSStringFromClass([Class class]));

#define PGSKAssertNilAndClass(object, Class) do{\
            PGSKAssertNil(object) \
            NSCAssert([object isKindOfClass:[Class class]], @"%@ 必须是%@类，但它却是%@类", @#object, NSStringFromClass([Class class]), NSStringFromClass([object class])); \
        }while(0);

#define PGSKAssertNilAndConformsToProtocol(object, Protocol) do{\
            PGSKAssertNil(object) \
            NSCAssert([object conformsToProtocol:@protocol(Protocol)], @"%@ 必须遵守%@协议", @#object, NSStringFromProtocol(@protocol(Protocol))); \
        }while(0);


#endif /* PGSKMacro_h */
