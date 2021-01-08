//
//  NSObject+ZZModelCreatorConfig.m
//  ZZUIHelper
//
//  Created by yhb on 2021/1/8.
//  Copyright © 2021 李伯坤. All rights reserved.
//

#import "NSObject+ZZModelCreatorConfig.h"
#import <objc/runtime.h>

static const void *configKey = &configKey;

@implementation NSObject (ZZModelCreatorConfig)

- (void)setModelCreatorConfig:(ZZModelCreatorConfig *)modelCreatorConfig {
    objc_setAssociatedObject(self, configKey, modelCreatorConfig, OBJC_ASSOCIATION_ASSIGN);
}

- (ZZModelCreatorConfig *)modelCreatorConfig {
    return objc_getAssociatedObject(self, configKey);
}

@end
