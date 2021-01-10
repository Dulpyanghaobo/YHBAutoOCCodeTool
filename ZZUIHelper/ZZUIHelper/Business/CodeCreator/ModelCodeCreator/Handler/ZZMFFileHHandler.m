//
//  ZZMFFileHHandler.m
//  ZZUIHelper
//
//  Created by 杨皓博 on 2021/1/10.
//  Copyright © 2021 李伯坤. All rights reserved.
//

#import "ZZMFFileHHandler.h"
#import "NSObject+ZZModelCreatorConfig.h"


@interface ZZMFFileHHandler ()

@property (nonatomic, strong) NSDictionary *frameworkMapper;

@end

@implementation ZZMFFileHHandler

@synthesize ybmf_skipLine = _ybmf_skipLine;


#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.ybmf_skipLine = NO;
    }
    return self;
}

#pragma mark - <YBMFFileHHandler>

- (NSString *)ybmf_importInfoWithNode:(ZZModelFileNode *)node withoutProperty:(BOOL)withoutProperty {
    NSMutableString *importInfo = [NSMutableString string];
    
    //基类的依赖
    Class baseClass = self.modelCreatorConfig.baseClass;
    NSBundle *baseClassBundle = [NSBundle bundleForClass:baseClass];
    if (baseClassBundle == [NSBundle mainBundle]) { //自定义类
        [importInfo appendString:[NSString stringWithFormat:@"#import \"%@.h\"\n", NSStringFromClass(baseClass)]];
    } else { //系统类
        NSString *lastPathComponent = baseClassBundle.bundlePath.lastPathComponent;
        NSString *framework = self.frameworkMapper[lastPathComponent];
        if (!framework) framework = @"Foundation/Foundation.h";
        [importInfo appendString:[NSString stringWithFormat:@"#import <%@>\n", framework]];
    }
    
    if (withoutProperty) return importInfo;
    
    //属性的依赖 (该工具特殊性，除开自定义类，属性都在 Foundation/Foundation.h)
    [node.children enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, ZZModelFileNode * _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *customClassName;
        if (obj.type == ZZMFNodeTypeNSArray) {
            ZZModelFileNode *child = obj.children[ZZMFNodeArrayElementKey];
            if (child && child.type == ZZMFNodeTypeClass) {
                customClassName = child.className;
            }
        } else if (obj.type == ZZMFNodeTypeClass) {
            customClassName = obj.className;
        }
        if (customClassName && customClassName.length > 0) {
            [importInfo appendString:[NSString stringWithFormat:@"#import \"%@.h\"\n", customClassName]];
        }
    }];
    
    return importInfo;
}

- (NSString *)ybmf_codeInfoWithNode:(ZZModelFileNode *)node {
    NSMutableString *codeInfo = [NSMutableString string];
    
    [codeInfo appendString:[NSString stringWithFormat:@"@interface %@ : %@", node.className, NSStringFromClass(self.modelCreatorConfig.baseClass)]];
    
    NSMutableString *protocolStr = [NSMutableString string];
    if (self.modelCreatorConfig.needCopying) {
        if (protocolStr.length == 0) {
            [protocolStr appendString:@" <NSCopying"];
        } else {
            [protocolStr appendString:@", NSCopying"];
        }
    }
    if (self.modelCreatorConfig.needCoding) {
        if (protocolStr.length == 0) {
            [protocolStr appendString:@" <NSCoding"];
        } else {
            [protocolStr appendString:@", NSCoding"];
        }
    }
    if (protocolStr.length > 0) {
        [protocolStr appendString:@">\n"];
        [codeInfo appendString:protocolStr];
    } else {
        [codeInfo appendString:@"\n"];
    }
    
    if (self.ybmf_skipLine) [codeInfo appendString:@"\n"];
    [node.children enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, ZZModelFileNode * _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *codeForParent = [self.modelCreatorConfig.codeForParentHandler ybmf_codeForParentWithNode:obj];
        
        [codeInfo appendString:[NSString stringWithFormat:@"%@%@;", codeForParent, key]];
        [codeInfo appendString:@"\n"];
        if (self.ybmf_skipLine) [codeInfo appendString:@"\n"];
    }];
    
    [codeInfo appendString:@"@end\n"];
    return codeInfo;
}

#pragma mark - getter

- (NSDictionary *)frameworkMapper {
    if (!_frameworkMapper) {
        _frameworkMapper
        = @{@"lib":@"Foundation/Foundation.h",
            @"CoreFoundation.framework":@"Foundation/Foundation.h",
            @"UIKitCore.framework":@"UIKit/UIKit.h",
            @"QuartzCore.framework":@"QuartzCore/QuartzCore.h",
            @"Photos.framework":@"Photos/Photos.h",
            @"MapKit.framework":@"MapKit/MapKit.h",
            @"AddressBookUI.framework":@"AddressBookUI/AddressBookUI.h",
            @"Accounts.framework":@"Accounts/Accounts.h",
            @"ARKit.framework":@"ARKit/ARKit.h",
            @"AssetsLibrary.framework":@"AssetsLibrary/AssetsLibrary.h",
            @"AVFoundation.framework":@"AVFoundation/AVFoundation.h"};
    }
    return _frameworkMapper;
}


@end
