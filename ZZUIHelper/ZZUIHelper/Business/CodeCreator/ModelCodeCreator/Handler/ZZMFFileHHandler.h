//
//  ZZMFFileHHandler.h
//  ZZUIHelper
//
//  Created by 杨皓博 on 2021/1/10.
//  Copyright © 2021 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZModelFileNode.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZZMFFileHHandler <NSObject>

/** 属性之间是否空行 */
@property (nonatomic, assign) BOOL ybmf_skipLine;

- (NSString *)ybmf_importInfoWithNode:(ZZModelFileNode *)node withoutProperty:(BOOL)withoutProperty;

- (NSString *)ybmf_codeInfoWithNode:(ZZModelFileNode *)node;

@end

@interface ZZMFFileHHandler : NSObject<ZZMFFileHHandler>

@end

NS_ASSUME_NONNULL_END
