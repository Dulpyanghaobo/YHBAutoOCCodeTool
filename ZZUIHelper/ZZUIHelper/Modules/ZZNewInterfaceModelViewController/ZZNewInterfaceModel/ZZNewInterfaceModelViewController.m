//
//  ZZNewInterfaceModelViewController.m
//  ZZUIHelper
//
//  Created by 杨皓博 on 2021/1/8.
//  Copyright © 2021 李伯坤. All rights reserved.
//

#import "ZZNewInterfaceModelViewController.h"
#import "ZZNewJsonTransformModelViewController.h"

@interface ZZNewInterfaceModelViewController ()

@end

@implementation ZZNewInterfaceModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}
- (IBAction)createModel:(id)sender {
    ZZNewJsonTransformModelViewController *VC = [ZZNewJsonTransformModelViewController new];
    [self presentViewControllerAsSheet:VC];
    [self dismissViewController:self];
}
- (IBAction)createInterface:(id)sender {
}

@end
