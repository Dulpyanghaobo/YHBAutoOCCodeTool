//
//  ZZControlItem.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZControlItem.h"

@interface ZZControlItem ()

@property (weak) IBOutlet NSView *bgView;
@property (weak) IBOutlet NSTextField *titleLabel;
@property (weak) IBOutlet NSImageView *controlImageView;

@property (weak) IBOutlet NSBox *horizontalLine;
@property (weak) IBOutlet NSBox *verticalLine;

@end

@implementation ZZControlItem

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.bgView setWantsLayer:YES];
    [self.bgView.layer setBackgroundColor:[NSColor colorWithRed:204.0/255.0 green:222.0/255.0 blue:238.0/255.0 alpha:0.7].CGColor];
    [self.bgView.layer setBorderWidth:1];
    [self.bgView.layer setBorderColor:[NSColor grayColor].CGColor];

    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(NSEdgeInsetsMake(2, 2, 2, 2));
    }];
    
    [self.controlImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.view).multipliedBy(0.5);
        make.center.mas_equalTo(0);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_lessThanOrEqualTo(self.view);
    }];
    [self.titleLabel setHidden:YES];
    
    [self.horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(0);
    }];
    [self.verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.right.mas_equalTo(0);
    }];
    
    [self.bgView setHidden:!self.selected];
}

- (void)setButtonTitle:(NSString *)buttonTitle
{
    _buttonTitle = buttonTitle;
    self.titleLabel.stringValue = buttonTitle;
    NSImage *image = [NSImage imageNamed:buttonTitle];
    if (image) {
        [self.controlImageView setImage:image];
        [self.controlImageView setHidden:NO];
        [self.titleLabel setHidden:YES];
    }
    else {
        [self.titleLabel setHidden:NO];
        [self.controlImageView setHidden:YES];
    }
    
    [self.bgView setHidden:!self.selected];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self.bgView setHidden:!selected];
}

@end
