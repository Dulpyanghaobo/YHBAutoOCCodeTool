//
//  ZZSettingItemsAddViewController.h
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/9.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ZZSettingItemsAddViewController : NSViewController

@property (nonatomic, copy) void (^okButtonClickAction)(NSArray *data);

@end
