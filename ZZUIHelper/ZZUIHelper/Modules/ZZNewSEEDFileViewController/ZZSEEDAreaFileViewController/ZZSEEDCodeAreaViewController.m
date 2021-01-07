//
//  ZZSEEDCodeAreaViewController.m
//  ZZUIHelper
//
//  Created by 杨皓博 on 2021/1/8.
//  Copyright © 2021 李伯坤. All rights reserved.
//

#import "ZZSEEDCodeAreaViewController.h"
#import "ZZElementAreaViewController.h"

@interface ZZSEEDCodeAreaViewController ()
@property (weak) IBOutlet NSTabViewItem *cellModelHItem;
@property (weak) IBOutlet NSTabViewItem *cellModelMItem;
@property (weak) IBOutlet NSTabViewItem *sectionItemHItem;
@property (weak) IBOutlet NSTabViewItem *sectionItemMItem;

@property (weak) IBOutlet NSTabViewItem *cellHItem;
@property (weak) IBOutlet NSTabViewItem *cellMItem;

@end

@implementation ZZSEEDCodeAreaViewController
- (void)loadView {
    [super loadView];
    [self.cellModelHItem setLabel:@"cellModel.h"];
    [self.cellModelMItem setLabel:@"cellModel.m"];
    [self.sectionItemHItem setLabel:@"sectionItem.h"];
    [self.sectionItemMItem setLabel:@"sectionItem.m"];
    [self.cellHItem setLabel:@"cell.h"];
    [self.cellMItem setLabel:@"cell.m"];

}
- (void)viewDidLoad {
    [super viewDidLoad];
}


@end
