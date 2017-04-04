//
//  ViewController.m
//  PGShareKit
//
//  Created by linjinxing on 16/12/29.
//  Copyright © 2016年 linjinxing. All rights reserved.
//

#import "ViewController.h"
#import "PGShareKitBLL.h"
#import "PGSKShareData.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)shareAction:(id)sender{
    [PGShareKitBLLShare(^(PGSKServiceSupportedDataType suportedType,
                         PGSKGetSharedDataSuccessBlock success,
                         PGSKFailBlock fail) {
        NSLog(@"suportedType:%@", @(suportedType));

        if (success) success(PGSKServiceSupportedDataTypeImage,
                             [PGSKShareDataImagePOD PODWithTitle:@"text"
                                                            desc:@"description aa"
                                                           image:[UIImage imageNamed:@"covor"]
                                                   thubnailImage:[UIImage imageNamed:@"covor"]]);
    }) subscribeNext:^(id data) {
        NSLog(@"data:%@", data);
    } error:^(NSError *error) {
        NSLog(@"error:%@", error);
    } completed:^{
        NSLog(@"completed");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
