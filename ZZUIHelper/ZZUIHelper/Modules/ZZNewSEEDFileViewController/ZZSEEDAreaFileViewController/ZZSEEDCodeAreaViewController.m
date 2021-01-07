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
    [self.cellModelHItem setLabel:[NSString stringWithFormat:@"%@CellModel.h",self.className]];
    [self.cellModelMItem setLabel:[NSString stringWithFormat:@"%@CellModel.m",self.className]];
    [self.sectionItemHItem setLabel:[NSString stringWithFormat:@"%@SectionItem.h",self.className]];
    [self.sectionItemMItem setLabel:[NSString stringWithFormat:@"%@SectionItem.m",self.className]];
    [self.cellHItem setLabel:[NSString stringWithFormat:@"%@Cell.h",self.className]];
    [self.cellMItem setLabel:[NSString stringWithFormat:@"%@Cell.m",self.className]];

}
- (void)viewDidLoad {
    [super viewDidLoad];
}


@end
