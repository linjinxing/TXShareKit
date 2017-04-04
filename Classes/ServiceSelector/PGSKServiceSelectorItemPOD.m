//
//  PGSKServiceSelectorItem.m
//  PGShareKit
//
//  Created by 林金星 on 17/4/4.
//  Copyright © 2017年 linjinxing. All rights reserved.
//

#import "PGSKServiceSelectorItemPOD.h"

@interface PGSKServiceSelectorItemPOD()
@property(nonatomic, strong) NSString* ID;
@property(nonatomic, strong) NSString* name;
@property(nonatomic, strong) NSString* sloganImageName;
@end

@implementation PGSKServiceSelectorItemPOD
+ (instancetype)itemWithID:(NSString*)ID name:(NSString*)name image:(NSString*)imageName{
    PGSKServiceSelectorItemPOD* pod = [[PGSKServiceSelectorItemPOD alloc] init];
    pod.ID = ID;
    pod.name = name;
    pod.sloganImageName = imageName;
    return pod;
}
@end


