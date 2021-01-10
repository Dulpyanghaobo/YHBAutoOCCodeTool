//
//  ZZMFFileNoteHandler.h
//  ZZUIHelper
//
//  Created by 杨皓博 on 2021/1/10.
//  Copyright © 2021 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZZMFFileNoteType) {
    ZZMFFileNoteTypeH,  //.h文件
    ZZMFFileNoteTypeM   //.m文件
};

@protocol ZZMFFileNoteHandler <NSObject>

/** 开发者 */
@property (nonatomic, copy) NSString *ybmf_developer;

/** 组织 */
@property (nonatomic, copy) NSString *ybmf_organization;

/** 工程名 (若该工具在当前工程运行，无需处理该值) */
@property (nonatomic, copy) NSString *ybmf_executableName;

/**
 获取文件头部注解

 @param fileName 文件名
 @param fileType 文件类型
 @return 注解
 */
- (NSString *)ybmf_fileNoteWithFileName:(NSString *)fileName fileType:(ZZMFFileNoteType)fileType;

@end

@interface ZZMFFileNoteHandler : NSObject<ZZMFFileNoteHandler>

@end

NS_ASSUME_NONNULL_END
