//
//  ZZNewJsonTransformModelViewController.m
//  ZZUIHelper
//
//  Created by 杨皓博 on 2021/1/10.
//  Copyright © 2021 李伯坤. All rights reserved.
//

#import "ZZNewJsonTransformModelViewController.h"
#import "ZZFileManager.h"
#import "ZZModelCreatorManager.h"
@interface ZZNewJsonTransformModelViewController ()

@end

@implementation ZZNewJsonTransformModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}
- (IBAction)uploadJson:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanCreateDirectories:YES];
    [panel setCanChooseFiles:YES];
    [panel setCanChooseDirectories:YES];
//    NSInteger result = [panel runModal];
//    if (result == NSFileHandlingPanelCancelButton) {
//        NSLog(@"%@",panel.URLs);
//    }
//    if (result == NSFileHandlingPanelOKButton) {
//    }
    __block NSArray *chooseFiles;
    [panel beginSheetModalForWindow:[NSApp mainWindow] completionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            chooseFiles = [panel URLs];
            NSLog(@"Click OK Choose files : %@",chooseFiles);
            NSData *fileData = [ZZFileManager readFileData:[chooseFiles firstObject]];
//            if ([fileData isKindOfClass:NSData.class]) {
//                fileData = [NSJSONSerialization JSONObjectWithData:fileData options:0 error:nil];
//            }
            [ZZModelCreatorManager createFileWithName:@"demo2" data:fileData];
        } else if (result == NSModalResponseCancel) {
            NSLog(@"Click cancels");
        }
    }];
}
- (IBAction)createModel:(id)sender {
}
- (void)exportFilesToPath:(NSString *)path
{
    ZZUIResponder *curClass = [ZZClassHelper sharedInstance].curClass;
    //.h
    NSString *fileName = [[ZZClassHelper sharedInstance].curClass.className stringByAppendingString:@".h"];
    NSString *hPath = [path stringByAppendingPathComponent:fileName];
    NSString *hCode = [[ZZCreatorManager sharedInstance] hFileForViewClass:curClass];
    if (![self p_writeCode:hCode toFileAtPath:hPath]) {
        
        return;
    }
    
    //.m
    fileName = [[ZZClassHelper sharedInstance].curClass.className stringByAppendingString:@".m"];
    NSString *mPath = [path stringByAppendingPathComponent:fileName];
    NSString *mCode = [[ZZCreatorManager sharedInstance] mFileForViewClass:curClass];
    if (![self p_writeCode:mCode toFileAtPath:mPath]) {
        
        return;
    }
    
    [[NSWorkspace sharedWorkspace] openFile:path];
}

- (BOOL)p_writeCode:(NSString *)code toFileAtPath:(NSString *)filePath
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            NSLog(@"删除已存在的%@文件失败", [filePath lastPathComponent]);
            return NO;
        }
    }
    
    BOOL ok = [[NSFileManager defaultManager] createFileAtPath:filePath contents:[code dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    if (!ok) {
        NSLog(@"%@文件写入失败", [filePath lastPathComponent]);
    }
    return ok;
}
@end
