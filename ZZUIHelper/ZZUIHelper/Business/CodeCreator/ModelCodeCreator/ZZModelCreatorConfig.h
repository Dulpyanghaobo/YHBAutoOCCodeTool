//
//  ZZModelCreatorConfig.h
//  ZZUIHelper
//
//  Created by yhb on 2021/1/8.
//  Copyright © 2021 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZMFFileHHandler.h"
#import "ZZMFFileMHandler.h"
#import "ZZMFFileNoteHandler.h"
#import "ZZModelFileNameHandle.h"
#import "ZZMFCodeForParentHandler.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, ZZMFIgnoreType) {
    ZZMFIgnoreTypeNone       = 0,
    ZZMFIgnoreTypeDouble     = 1 << 0,
    ZZMFIgnoreTypeNSInteger  = 1 << 1,
    ZZMFIgnoreTypeBOOL       = 1 << 2,
    ZZMFIgnoreTypeNSNumber   = 1 << 3,
    ZZMFIgnoreTypeAllDigital = ZZMFIgnoreTypeDouble | ZZMFIgnoreTypeNSInteger | ZZMFIgnoreTypeBOOL | ZZMFIgnoreTypeNSNumber,
    ZZMFIgnoreTypeMutable    = 1 << 4   //过滤掉可变类型
};

typedef NS_ENUM(NSInteger, ZZMFFramework) {
    ZZMFFrameworkYY,     //YYModel
    ZZMFFrameworkMJ,     //MJExtension
    ZZMFFrameworkNone    //此情况 .m 文件将不做映射处理 (谨慎使用)
};

typedef NS_ENUM(NSInteger, ZZMFFilePartitionMode) {
    ZZMFFilePartitionModeApart,     //一个类一组文件
    ZZMFFilePartitionModeTogether,  //多个类合并为一组文件
};

@interface ZZModelCreatorConfig : NSObject


/**
 全局配置单例（优先级低于单独配置的 ZZModelCreatorConfig）

 @return ZZModelCreatorConfig
 */
+ (instancetype)shareConfig;

/**
 默认初始化方法

 @return YBMFConfig
 */
+ (instancetype)defaultConfig;

/** 文件名的后缀 (默认为 Model) */
@property (nonatomic, copy) NSString *fileSuffix;

/** 文件分割模式 (默认为 YBMFFilePartitionModeApart) */
@property (nonatomic, assign) ZZMFFilePartitionMode filePartitionMode;

/** 类属性忽略的类型（内部自动用更通用类型替代, 默认为 YBMFIgnoreTypeMutable） */
@property (nonatomic, assign) ZZMFIgnoreType ignoreType;

/** 工程使用的 json 转 model 框架 (默认为 YBMFFrameworkYY) */
@property (nonatomic, assign) ZZMFFramework framework;

/** 是否需要实现 NSCopying 协议 (默认为 YES) */
@property (nonatomic, assign) BOOL needCopying;

/** 是否需要实现 NSCoding 协议 (默认为 YES) */
@property (nonatomic, assign) BOOL needCoding;

/** 数据模型类的统一基类 (默认为 NSObject) */
@property (nonatomic, strong) Class baseClass;

/** 名字处理器 */
@property (nonatomic, strong) id<ZZMFNameHandler> nameHander;

/** 文件头部注解处理器 */
@property (nonatomic, strong) id<ZZMFFileNoteHandler> fileNoteHander;

/** .h文件代码处理器 */
@property (nonatomic, strong) id<ZZMFFileHHandler> fileHHandler;

/** .m文件代码处理器 */
@property (nonatomic, strong) id<ZZMFFileMHandler> fileMHandler;

/** 节点作为父节点的属性时 Code 格式处理器 */
@property (nonatomic, strong) id<ZZMFCodeForParentHandler> codeForParentHandler;


- (instancetype)init OBJC_UNAVAILABLE("use '+shareConfig:' instead");
+ (instancetype)new OBJC_UNAVAILABLE("use '+shareConfig:' instead");

@end

NS_ASSUME_NONNULL_END
