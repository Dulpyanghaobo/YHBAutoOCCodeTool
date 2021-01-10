//
//  ZZModelCreatorManager.h
//  ZZUIHelper
//
//  Created by yhb on 2021/1/8.
//  Copyright © 2021 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZModelCreatorConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZModelCreatorManager : NSObject

+ (void)createFileWithName:(NSString *)name data:(id)data;

+ (void)createFileWithName:(NSString *)name data:(id)data config:(ZZModelCreatorConfig *)config;

/**
 生成 Model 文件

 @param name 主 Model 文件名
 @param data 数据源 (字典/数组/json数据/json字符串/json文件名)
 @param config 配置 (默认为 [YBMFConfig shareConfig])
 @param path 文件生成路径 (默认为桌面 YBModelFile-Workspace 文件夹)
 */
+ (void)createFileWithName:(NSString *)name data:(id)data config:(nullable ZZModelCreatorConfig *)config path:(nullable NSString *)path ;


@end

NS_ASSUME_NONNULL_END
