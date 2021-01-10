//
//  ZZModelFileNode.h
//  ZZUIHelper
//
//  Created by yhb on 2021/1/8.
//  Copyright © 2021 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 根结点*/
NS_ASSUME_NONNULL_BEGIN
extern NSString * const ZZMFNodeArrayElementKey;

typedef NS_ENUM(NSInteger, ZZMFNodeType) {
    ZZMFNodeTypeUnknown,
    ZZMFNodeTypeNSString,
    ZZMFNodeTypeNSMutableString,
    ZZMFNodeTypeBOOL,
    ZZMFNodeTypeDouble,
    ZZMFNodeTypeNSInteger,
    ZZMFNodeTypeNSNumber,
    ZZMFNodeTypeNSArray,
    ZZMFNodeTypeNSMutableArray,
    ZZMFNodeTypeClass
};
@interface ZZModelFileNode : NSObject

/** 节点类型*/
@property (nonatomic, assign) ZZMFNodeType type;


/** 子节点 */
@property (nonatomic, strong) NSMutableDictionary<NSString *, ZZModelFileNode *> *children;

/** 节点类名 */
@property (nonatomic, copy) NSString *className;

#pragma - 以下内容仅在 type == YBMFNodeTypeClass 时有用

/** 属性映射 (属性名:字典中取值用的key) */
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSString *> *propertyMapper;

/** 容器元素映射 (数组属性名:Class字符串) */
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSString *> *containerMapper;

@end

NS_ASSUME_NONNULL_END
