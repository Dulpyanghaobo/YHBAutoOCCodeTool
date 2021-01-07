//
//  ZZSEEDNewFileViewController.m
//  ZZUIHelper
//
//  Created by yhb on 2021/1/7.
//  Copyright © 2021 李伯坤. All rights reserved.
//

#import "ZZSEEDNewFileViewController.h"

@interface ZZSEEDNewFileViewController ()
@property (strong) IBOutlet NSTextFieldCell *classNameTextField;

@end

@implementation ZZSEEDNewFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)cancelGenerateButton:(id)sender {
    [self dismissViewController:self];
}
- (IBAction)GenerateButton:(id)sender {
    NSString *className = self.classNameTextField.stringValue;
    NSString *superClassName = @"UICollectionViewCell";
    NSLog(@"className :%@",className);
    if (className.length > 0) {
        NSString *zzClassName = [@"ZZ" stringByAppendingString:superClassName];
        ZZUIResponder *object = [[NSClassFromString(zzClassName) alloc] init];
        [object setClassName:className];
        [object setSuperClassName:superClassName];
        [ZZClassHelper sharedInstance].curClass = object;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_NEW_PROJECT object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_NEW_SEEDPROJECT object:nil];
        
        [self dismissViewController:self];
    }
}

@end
