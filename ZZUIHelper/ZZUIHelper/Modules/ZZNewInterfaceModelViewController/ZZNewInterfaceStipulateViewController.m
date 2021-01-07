//
//  ZZNewInterfaceStipulateViewController.m
//  ZZUIHelper
//
//  Created by 杨皓博 on 2021/1/8.
//  Copyright © 2021 李伯坤. All rights reserved.
//

#import "ZZNewInterfaceStipulateViewController.h"

@interface ZZNewInterfaceStipulateViewController ()
@property (unsafe_unretained) IBOutlet NSTextView *textViewData;


@end

@implementation ZZNewInterfaceStipulateViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)cancelEvent:(id)sender {
    [self dismissViewController:self];
}
- (IBAction)rightEvent:(id)sender {
    NSString *data = self.textViewData.textStorage.mutableString;
    NSLog(@"data:%@",data);
}

@end
