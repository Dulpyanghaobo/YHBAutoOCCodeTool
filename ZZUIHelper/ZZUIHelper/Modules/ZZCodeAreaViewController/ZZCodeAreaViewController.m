//
//  ZZCodeAreaViewController.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZCodeAreaViewController.h"
#import "ZZSEEDCodeAreaViewController.h"
#import "ZZSEEDCodeAreaSplitViewController.h"
#import "ZZCellModelViewController.h"
#import "ZZPropertyAreaViewController.h"
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
    if ([ZZClassHelper sharedInstance].curClass) {
        NSString *className = [ZZClassHelper sharedInstance].curClass.className;
        
        ZZSEEDCodeAreaViewController *deareaVC = [[ZZSEEDCodeAreaViewController alloc]initWithNibName:@"ZZSEEDCodeAreaViewController" bundle:nil];
        deareaVC.className = className;
    ZZSEEDCodeAreaSplitViewController *seedAreaVC = [[ZZSEEDCodeAreaSplitViewController alloc]initWithNibName:NSStringFromClass([ZZSEEDCodeAreaSplitViewController class]) bundle:nil];
    seedAreaVC.splitViewItems = @[
        [NSSplitViewItem splitViewItemWithViewController:[[ZZPropertyAreaViewController alloc] init]],

        
        [NSSplitViewItem splitViewItemWithViewController:deareaVC],
        [NSSplitViewItem splitViewItemWithViewController:[[ZZCellModelViewController alloc] initWithNibName:@"ZZCellModelViewController" bundle:nil]]
    ];
    self.view.window.contentView = seedAreaVC.view;
    }
}

@end
