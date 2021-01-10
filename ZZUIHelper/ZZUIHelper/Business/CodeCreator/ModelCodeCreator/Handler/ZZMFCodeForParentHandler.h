//
//  ZZMFCodeForParentHandler.h
//  ZZUIHelper
//
//  Created by 杨皓博 on 2021/1/10.
//  Copyright © 2021 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZModelFileNode.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZZMFCodeForParentHandler <NSObject>

- (NSString *)ybmf_codeForParentWithNode:(ZZModelFileNode *)node;

@end

@interface ZZMFCodeForParentHandler : NSObject<ZZMFCodeForParentHandler>

@end

NS_ASSUME_NONNULL_END
