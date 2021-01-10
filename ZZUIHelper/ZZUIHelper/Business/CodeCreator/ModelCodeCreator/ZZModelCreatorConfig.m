//
//  ZZModelCreatorConfig.m
//  ZZUIHelper
//
//  Created by yhb on 2021/1/8.
//  Copyright © 2021 李伯坤. All rights reserved.
//

#import "ZZModelCreatorConfig.h"
#import "NSObject+ZZModelCreatorConfig.h"


@implementation ZZModelCreatorConfig


//test
- (void)dealloc {
    NSLog(@"释放：%@", self);
}

+ (instancetype)shareConfig {
#if DEBUG
    static ZZModelCreatorConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[ZZModelCreatorConfig alloc] initDefaults];
    });
    return config;
#else
    return nil;
#endif
}

+ (instancetype)defaultConfig {
    ZZModelCreatorConfig *config = [[ZZModelCreatorConfig alloc] initDefaults];
    return config;
}

- (instancetype)initDefaults {
    self = [super init];
    if (self) {
        _fileSuffix = @"Model";
        _filePartitionMode = ZZMFFilePartitionModeApart;
        _ignoreType = ZZMFIgnoreTypeAllDigital | ZZMFIgnoreTypeMutable;
        _baseClass = NSObject.self;
        _framework = ZZMFFrameworkYY;
        _needCopying = YES;
        _needCoding = YES;
        _nameHander = [ZZModelFileNameHandle new];
        _fileNoteHander = [ZZMFFileNoteHandler new];
        
        ZZMFFileHHandler *fileH = [ZZMFFileHHandler new];
        fileH.modelCreatorConfig = self;
        _fileHHandler = fileH;
        
        ZZMFFileMHandler *fileM = [ZZMFFileMHandler new];
        fileM.modelCreatorConfig = self;
        _fileMHandler = fileM;
        
        _codeForParentHandler = [ZZMFCodeForParentHandler new];
    }
    return self;
}

@end
