//
//  ZZNewCrossPlatformViewController.m
//  ZZUIHelper
//
//  Created by 杨皓博 on 2021/1/8.
//  Copyright © 2021 李伯坤. All rights reserved.
//

#import "ZZNewCrossPlatformViewController.h"
#import "Masonry.h"
@interface ZZNewCrossPlatformViewController ()

@property (weak) IBOutlet NSButtonCell *rightButton;

@property (weak) IBOutlet NSButton *leftButton;

@property (nonatomic, strong) NSButton *javaButton;

@property (nonatomic, strong) NSButton *ocButton;

@property (nonatomic, assign)BOOL isSelectJava ;

@property (nonatomic, assign)BOOL isSelectKotlin ;

@property (nonatomic, assign)BOOL isSelectOC ;

@property (nonatomic, assign)BOOL isSelectSwift ;

@end

@implementation ZZNewCrossPlatformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.javaButton];
    [self.view addSubview:self.ocButton];
    [self p_addMasonry];
}

- (void)p_addMasonry {
    
}

- (IBAction)clickRightButton:(id)sender {
    
}

- (IBAction)ClickLeftButton:(id)sender {
    [self dismissViewController:self];
}

- (void)javaClickEvent:(NSButton *)sender {
//    sender.selectedTag =  YES;
}
- (void)object_CClickEvent:(NSButton *)sender {
    
}
- (NSButton *)javaButton {
    if (!_javaButton) {
        _javaButton = [NSButton radioButtonWithTitle:@"Java" target:self action:@selector(javaClickEvent:)];
        [_javaButton setFrame:CGRectMake(60, 200, 60, 30) ];
    }
    return _javaButton;
}
- (NSButton *)ocButton {
    if (!_ocButton) {
        _ocButton = [NSButton radioButtonWithTitle:@"Objective-C" target:self action:@selector(object_CClickEvent:)];
        [_ocButton setFrame:CGRectMake(320, 200, 100, 30)];
    }
    return _ocButton;
}
@end
