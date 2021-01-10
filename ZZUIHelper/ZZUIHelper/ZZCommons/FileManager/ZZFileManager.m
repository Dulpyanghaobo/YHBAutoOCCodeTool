//
//  ZZFileManager.m
//  ZZUIHelper
//
//  Created by 杨皓博 on 2021/1/10.
//  Copyright © 2021 李伯坤. All rights reserved.
//

#import "ZZFileManager.h"


@implementation ZZFileManager

+ (instancetype)shareConfig {
#if DEBUG
    static ZZFileManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = (ZZFileManager *)[ZZFileManager defaultManager];
    });
    return manager;
#else
    return nil;
#endif
}


+ (BOOL)createFile:(NSString *)filePath {
    if (filePath.length == 0) {
        return NO;
    }
    if ([[self shareConfig] fileExistsAtPath:filePath]) {
        return YES;
    }
    NSError *error;
    NSString *dirPath = [filePath stringByDeletingLastPathComponent];
    
    BOOL isSuccess = [[self shareConfig] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (error) {
        NSLog(@"creat File Failed:%@",[error localizedDescription]);
    }
    if (!isSuccess) {
        return isSuccess;
    }
    isSuccess = [[self shareConfig] createFileAtPath:filePath contents:nil attributes:nil];
    return isSuccess;
}

+(NSData*)readFileData:(NSURL *)filePath {
    
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingFromURL:filePath error:nil];
    
    NSData *fileData = [handle readDataToEndOfFile];
    [handle closeFile];
    
    return fileData;
}

@end
