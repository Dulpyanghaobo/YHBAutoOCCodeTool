//
//  ZZMFCodeForParentHandler.m
//  ZZUIHelper
//
//  Created by 杨皓博 on 2021/1/10.
//  Copyright © 2021 李伯坤. All rights reserved.
//

#import "ZZMFCodeForParentHandler.h"

@implementation ZZMFCodeForParentHandler

#pragma mark - <YBMFCodeForParentHandler>

- (NSString *)ybmf_codeForParentWithNode:(ZZModelFileNode *)node {
    switch (node.type) {
        case ZZMFNodeTypeBOOL:
            return @"@property (nonatomic, assign) BOOL ";
        case ZZMFNodeTypeNSInteger:
            return @"@property (nonatomic, assign) NSInteger ";
        case ZZMFNodeTypeDouble:
            return @"@property (nonatomic, assign) double ";
        case ZZMFNodeTypeNSNumber:
            return @"@property (nonatomic, copy) NSNumber *";
        case ZZMFNodeTypeNSMutableString:
            return @"@property (nonatomic, strong) NSMutableString *";
        case ZZMFNodeTypeNSString:
            return @"@property (nonatomic, copy) NSString *";
        case ZZMFNodeTypeClass:
            return [NSString stringWithFormat:@"@property (nonatomic, strong) %@ *", node.className];
        case ZZMFNodeTypeNSMutableArray: {
            ZZModelFileNode *child = node.children[ZZMFNodeArrayElementKey];
            if (child && child.className && child.className.length > 0) {
                return [NSString stringWithFormat:@"@property (nonatomic, strong) NSMutableArray<%@ *> *", child.className];
            } else {
                return @"@property (nonatomic, strong) NSMutableArray *";
            }
        }
        case ZZMFNodeTypeNSArray: {
            ZZModelFileNode *child = node.children[ZZMFNodeArrayElementKey];
            if (child && child.className && child.className.length > 0) {
                return [NSString stringWithFormat:@"@property (nonatomic, copy) NSArray<%@ *> *", child.className];
            } else {
                return @"@property (nonatomic, copy) NSArray *";
            }
        }
        default:
            return @"";
    }
}

@end
