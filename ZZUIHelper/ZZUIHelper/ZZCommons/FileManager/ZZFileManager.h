//
//  ZZFileManager.h
//  ZZUIHelper
//
//  Created by 杨皓博 on 2021/1/10.
//  Copyright © 2021 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZFileManager : NSFileManager

+ (BOOL)createFile:(NSString *)filePath;

+(NSData*)readFileData:(NSURL *)filePath ;
@end

NS_ASSUME_NONNULL_END
