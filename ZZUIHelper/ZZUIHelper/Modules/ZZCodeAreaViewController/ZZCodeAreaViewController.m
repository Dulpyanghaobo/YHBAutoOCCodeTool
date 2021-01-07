//
//  ZZCodeAreaViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZCodeAreaViewController.h"
#import "ZZSEEDCodeAreaViewController.h"


@interface ZZCodeAreaViewController ()
@end

@implementation ZZCodeAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:NOTI_NEW_PROJECT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadSEEDData) name:NOTI_NEW_SEEDPROJECT object:nil];

    [self setSelectedTabViewItemIndex:1];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)reloadData
{
    if ([ZZClassHelper sharedInstance].curClass) {
        NSString *className = [ZZClassHelper sharedInstance].curClass.className;
        [self.tabViewItems[0] setLabel:[NSString stringWithFormat:@"%@.h", className]];
        [self.tabViewItems[1] setLabel:[NSString stringWithFormat:@"%@.m", className]];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setSelectedTabViewItemIndex:1];
    });
}
- (void)reloadSEEDData {
    ZZSEEDCodeAreaViewController *seedAreaVC = [[ZZSEEDCodeAreaViewController alloc]init];
    self.view.window.contentView = seedAreaVC.view;
}

@end
