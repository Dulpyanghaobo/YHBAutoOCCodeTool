//
//  ZZModelFileNode.m
//  ZZUIHelper
//
//  Created by yhb on 2021/1/8.
//  Copyright © 2021 李伯坤. All rights reserved.
//

#import "ZZModelFileNode.h"

NSString * const ZZMFNodeArrayElementKey = @"kZZMFNodeArrayElementKey";


@implementation ZZModelFileNode

- (void)setType:(ZZMFNodeType)type {
    _type = type;
    
    switch (type) {
        case ZZMFNodeTypeNSNumber:
            self.className = NSStringFromClass(NSNumber.self);
            break;
        case ZZMFNodeTypeNSString:
            self.className = NSStringFromClass(NSString.self);
            break;
        case ZZMFNodeTypeNSMutableString:
            self.className = NSStringFromClass(NSMutableString.self);
            break;
        case ZZMFNodeTypeNSArray:
            self.className = NSStringFromClass(NSArray.self);
            break;
        case ZZMFNodeTypeNSMutableArray:
            self.className = NSStringFromClass(NSMutableArray.self);
            break;
        default:
            break;
    }
}

#pragma mark - getter

- (NSMutableDictionary<NSString *, ZZModelFileNode *> *)children {
    if (!_children) {
        _children = [NSMutableDictionary dictionary];
    }
    return _children;
}

- (NSMutableDictionary *)propertyMapper {
    if (!_propertyMapper) {
        _propertyMapper = [NSMutableDictionary dictionary];
    }
    return _propertyMapper;
}

- (NSMutableDictionary *)containerMapper {
    if (!_containerMapper) {
        _containerMapper = [NSMutableDictionary dictionary];
    }
    return _containerMapper;
}

@end
