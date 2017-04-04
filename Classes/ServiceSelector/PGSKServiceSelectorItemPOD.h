//
//  PGSKServiceSelectorItem.h
//  PGShareKit
//
//  Created by 林金星 on 17/4/4.
//  Copyright © 2017年 linjinxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGSKServiceSelectorItemPOD : NSObject
@property(nonatomic, readonly, strong) NSString* ID;
@property(nonatomic, readonly, strong) NSString* name;
@property(nonatomic, readonly, strong) NSString* sloganImageName;
+ (instancetype)itemWithID:(NSString*)ID name:(NSString*)name image:(NSString*)imageName;
@end


