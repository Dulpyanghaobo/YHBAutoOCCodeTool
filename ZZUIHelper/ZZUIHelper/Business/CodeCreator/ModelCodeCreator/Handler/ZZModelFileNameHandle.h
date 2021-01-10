//
//  ZZModelFileNameHandle.h
//  ZZUIHelper
//
//  Created by yhb on 2021/1/8.
//  Copyright © 2021 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZModelFileNode.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ZZMFNameHandler <NSObject>

/**
 根据已知数据生成类名

 @param prefix 前缀字符串 (比如 ZZGoodsModel)
 @param suffix 后缀字符串 (默认为 Model)
 @param key json 中的 key
 @return 类名
 */
- (NSString *)ybmf_classNameWithPrefix:(nullable NSString *)prefix suffix:(nullable NSString *)suffix key:(id)key;

/**
 根据已知数据生成属性名

 @param key json 中的 key
 @param existKeys 已经存在的 keys
 @return 属性名
 */
- (NSString *)ybmf_propertyNameWithKey:(id)key existKeys:(NSArray *)existKeys;

/* 是否需要类名判重（默认为 NO） */
@property (nonatomic, assign) BOOL ybmf_shouldAvoidClassRepeat;

@end

@interface ZZModelFileNameHandle : NSObject<ZZMFNameHandler>

@end

NS_ASSUME_NONNULL_END
