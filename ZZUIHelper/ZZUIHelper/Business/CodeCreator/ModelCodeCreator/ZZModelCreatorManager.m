//
//  ZZModelCreatorManager.m
//  ZZUIHelper
//
//  Created by yhb on 2021/1/8.
//  Copyright © 2021 李伯坤. All rights reserved.
//

#import "ZZModelCreatorManager.h"
#import "ZZModelFileNode.h"
#import "ZZModelFileNameHandle.h"

@interface ZZModelCreatorManager ()

@property (nonatomic, strong) ZZModelFileNode *rootNode;

@property (nonatomic, strong) ZZModelCreatorConfig *config;

@end


@implementation ZZModelCreatorManager

#pragma mark - public

+ (void)createFileWithName:(NSString *)name data:(id)data {
    [self createFileWithName:name data:data config:nil path:nil];
}

+ (void)createFileWithName:(NSString *)name data:(id)data config:(ZZModelCreatorConfig *)config {
    [self createFileWithName:name data:data config:config path:nil];
}

+ (void)createFileWithName:(NSString *)name data:(id)data config:(ZZModelCreatorConfig *)config path:(nullable NSString *)path {
    [self private_createFileWithName:name data:data config:config path:path];
}

+ (void)private_createFileWithName:(NSString *)name data:(id)data config:(ZZModelCreatorConfig *)config path:(nullable NSString *)path {
    if (!name || !data) goto fail;
    
    if ([data isKindOfClass:NSString.class]) {
        if ([data containsString:@":"]) {
            data = [data dataUsingEncoding:NSUTF8StringEncoding];
        } else {
            NSString *path = [[NSBundle mainBundle] pathForResource:[data stringByDeletingPathExtension] ofType:@"json"];
            data = [NSData dataWithContentsOfFile:path];
        }
        if (!data) goto fail;
    }
    if ([data isKindOfClass:NSData.class]) {
        data = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if (!data) goto fail;
    }
    if ([data isKindOfClass:NSArray.class] && ((NSArray *)data).count > 0) {
        data = ((NSArray *)data).firstObject;
        if (!data) goto fail;
    }
    if ([data isKindOfClass:NSDictionary.class]) {
        ZZModelCreatorManager *mfile = ZZModelCreatorManager.new;
        mfile.config = config ?: [ZZModelCreatorConfig shareConfig];
        mfile.rootNode = [mfile buildTreeWithParentClassName:nil key:name value:data];
        [mfile creatWithPath:path];
    } else {
        goto fail;
    }
    
    return;
fail:
    NSAssert(0, @"json数据无效");
}

//test
- (void)dealloc {
    NSLog(@"释放：%@", self);
}

#pragma mark - build tree

- (ZZModelFileNode *)buildTreeWithParentClassName:(NSString *)parentClassName key:(id)key value:(id)value {
    if (!value) return nil;
    if (!key) key = @"";
    if (!parentClassName) parentClassName = @"";
    
    ZZModelFileNode *node = ZZModelFileNode.new;
    
    ZZMFIgnoreType ignoreType = self.config.ignoreType;
    
    if ([value isKindOfClass:NSDictionary.class]) {
        
        node.type = ZZMFNodeTypeClass;
        node.className = [self.config.nameHander ybmf_classNameWithPrefix:parentClassName suffix:self.config.fileSuffix key:key];
        [((NSDictionary *)value) enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull _key, id  _Nonnull _value, BOOL * _Nonnull stop) {
            
            NSString *n_key = [self.config.nameHander ybmf_propertyNameWithKey:_key existKeys:node.children.allKeys];
            //添加属性映射
            if (![n_key isEqualToString:[NSString stringWithFormat:@"%@", _key]]) {
                node.propertyMapper[n_key] = [NSString stringWithFormat:@"%@", _key];
            }
            
            ZZModelFileNode *child = [self buildTreeWithParentClassName:node.className key:_key value:_value];
            if (child.type == ZZMFNodeTypeNSArray) {
                ZZModelFileNode *ele = child.children[ZZMFNodeArrayElementKey];
                //添加容器元素映射
                if (ele && ele.type == ZZMFNodeTypeClass) {
                    node.containerMapper[n_key] = ele.className;
                }
            }
            node.children[n_key] = child;
        }];
        
    } else if ([value isKindOfClass:NSArray.class]) {
        
        if (!(ignoreType & ZZMFIgnoreTypeMutable) && [value isKindOfClass:NSMutableArray.class]) {
            node.type = ZZMFNodeTypeNSMutableArray;
        } else {
            node.type = ZZMFNodeTypeNSArray;
        }
        
        if (((NSArray *)value).count > 0) {
            ZZModelFileNode *child = [self buildTreeWithParentClassName:parentClassName key:key value:((NSArray *)value).firstObject];
            node.children[ZZMFNodeArrayElementKey] = child;
        }
        
    } else if ([value isKindOfClass:NSString.class]) {
        
        if (!(ignoreType & ZZMFIgnoreTypeMutable) && [value isKindOfClass:NSMutableString.class]) {
            node.type = ZZMFNodeTypeNSMutableString;
        } else {
            node.type = ZZMFNodeTypeNSString;
        }
        
    } else if ([value isKindOfClass:NSNumber.class]) {
      
        if ([value isKindOfClass:NSDecimalNumber.class]) {  //优先处理超长数字
            node.type = ZZMFNodeTypeNSString;
        } else if ((ignoreType & ZZMFIgnoreTypeBOOL) && [NSStringFromClass([value class]) isEqualToString:@"__NSCFBoolean"]) {
            node.type = ZZMFNodeTypeBOOL;
        } else if ((ignoreType & ZZMFIgnoreTypeNSInteger) && strcmp([value objCType], "q") == 0) {
            node.type =ZZMFNodeTypeNSInteger;
        } else if ((ignoreType & ZZMFIgnoreTypeDouble) && strcmp([value objCType], "d") == 0) {
            node.type = ZZMFNodeTypeDouble;
        } else if ((ignoreType & ZZMFNodeTypeNSNumber)) {
            node.type = ZZMFNodeTypeNSNumber;
        } else {
            node.type = ZZMFNodeTypeNSString;
        }
     
    } else if ([value isKindOfClass:NSNull.class]) {
        node.type = ZZMFNodeTypeNSString;
    }
    return node;
}

#pragma mark - create file

- (void)creatWithPath:(NSString *)path  {
    if (!path) {
        //找到桌面路径
        NSString *bundle = [[NSBundle mainBundle] resourcePath];
        if (!bundle) NSAssert(0, @"自动获取桌面路径失败，请尝试添加文件路径");
        path = [[bundle substringToIndex:[bundle rangeOfString:@"Library"].location] stringByAppendingFormat:@"Desktop"];
        if (!path) NSAssert(0, @"自动获取桌面路径失败，请尝试添加文件路径");
    }
    
    //创建一个工具工作空间
    NSString *rootDirectoryPath = [self creatDirectoryWithPath:path.copy directoryName:@"YBModelFile-Workspace" cover:YES];
    
    //创建存放当前 json 模型文件的文件夹
    NSString *fileDirectoryPath = [self creatDirectoryWithPath:rootDirectoryPath.copy directoryName:self.rootNode.className cover:NO];
    [self creatFilesWithDirectoryPath:fileDirectoryPath];

    NSAlert *alert = [NSAlert alertWithMessageText:@"已生成" defaultButton:@"确定" alternateButton:nil otherButton:nil informativeTextWithFormat:@"%@", [NSString stringWithFormat:@"\n✨✨ YBModelFile ✨✨\n生成文件目录：\n%@",fileDirectoryPath]];
        [alert runModal];
}

- (NSString *)creatDirectoryWithPath:(NSString *)path directoryName:(NSString *)directoryName cover:(BOOL)cover {
    NSString *directoryPath = [path stringByAppendingPathComponent:directoryName];
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:directoryPath];
    if (exist && cover) return directoryPath;
    NSUInteger suffix = 0;
    while (exist) {
        directoryPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%lu", directoryName, (unsigned long)++suffix]];
        exist = [[NSFileManager defaultManager] fileExistsAtPath:directoryPath];
    }
    NSError *error;
    BOOL creatDirSuccess = [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (!creatDirSuccess) NSAssert(0, error.description);
    return directoryPath;
}

- (NSString *)creatFileWithPath:(NSString *)path fileName:(NSString *)fileName fileCode:(NSString *)fileCode {
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSError *error;
    BOOL creatFileSuccess = [fileCode writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (!creatFileSuccess) {
        NSLog(@"\n✨✨ ZZModelFile ✨✨\n生成文件失败：\n%@", error.description);
        return nil;
    } else {
        return filePath;
    }
}

- (void)creatFilesWithDirectoryPath:(NSString *)path {
    switch (self.config.filePartitionMode) {
        case ZZMFFilePartitionModeApart:
            [self dfs_creatFilesWithDirectoryPath:path node:self.rootNode];
            break;
        case ZZMFFilePartitionModeTogether: {
            
            NSMutableString *allInfoInFileH = [NSMutableString string];
            NSMutableString *allInfoInFileM = [NSMutableString string];
            
            NSMutableString *codeInFileH = [NSMutableString string];
            NSMutableString *codeInFileM = [NSMutableString string];
            [self dfs_mergeWithCodeInFileH:codeInFileH codeInFileM:codeInFileM node:self.rootNode];
            
            [allInfoInFileH appendString:[self.config.fileNoteHander ybmf_fileNoteWithFileName:self.rootNode.className fileType:ZZMFFileNoteTypeH]];
            [allInfoInFileH appendString:@"\n"];
            [allInfoInFileH appendString:[self.config.fileHHandler ybmf_importInfoWithNode:self.rootNode withoutProperty:YES]];
            [allInfoInFileH appendString:@"\n"];
            [allInfoInFileH appendString:@"NS_ASSUME_NONNULL_BEGIN\n\n\n"];
            [allInfoInFileH appendString:codeInFileH];
            [allInfoInFileH appendString:@"NS_ASSUME_NONNULL_END\n"];
            
            [allInfoInFileM appendString:[self.config.fileNoteHander ybmf_fileNoteWithFileName:self.rootNode.className fileType:ZZMFFileNoteTypeM]];
            [allInfoInFileM appendString:@"\n"];
            [allInfoInFileM appendString:[self.config.fileMHandler ybmf_importInfoWithNode:self.rootNode]];
            [allInfoInFileM appendString:@"\n\n"];
            [allInfoInFileM appendString:codeInFileM];
            
            [self creatFileWithPath:path fileName:[NSString stringWithFormat:@"%@.h", self.rootNode.className] fileCode:allInfoInFileH];
            [self creatFileWithPath:path fileName:[NSString stringWithFormat:@"%@.m", self.rootNode.className] fileCode:allInfoInFileM];
        }
        default:
            break;
    }
}

- (void)dfs_creatFilesWithDirectoryPath:(NSString *)path node:(ZZModelFileNode *)node {
    [node.children enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, ZZModelFileNode * _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj.type == ZZMFNodeTypeClass) {
            [self dfs_creatFilesWithDirectoryPath:path node:obj];
        } else if (obj.type == ZZMFNodeTypeNSArray || obj.type == ZZMFNodeTypeNSMutableArray) {
            ZZModelFileNode *child = obj.children[ZZMFNodeArrayElementKey];
            if (child && child.type == ZZMFNodeTypeClass) {
                [self dfs_creatFilesWithDirectoryPath:path node:child];
            }
        }
    }];
    [self creatFileWithPath:path fileName:[NSString stringWithFormat:@"%@.h", node.className] fileCode:[self allInfoFileH:node]];
    [self creatFileWithPath:path fileName:[NSString stringWithFormat:@"%@.m", node.className] fileCode:[self allInfoFileM:node]];
}

- (void)dfs_mergeWithCodeInFileH:(NSMutableString *)codeInFileH codeInFileM:(NSMutableString *)codeInFileM node:(ZZModelFileNode *)node {
    [node.children enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, ZZModelFileNode * _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj.type == ZZMFNodeTypeClass) {
            [self dfs_mergeWithCodeInFileH:codeInFileH codeInFileM:codeInFileM node:obj];
        } else if (obj.type == ZZMFNodeTypeNSArray || obj.type == ZZMFNodeTypeNSMutableArray) {
            ZZModelFileNode *child = obj.children[ZZMFNodeArrayElementKey];
            if (child && child.type == ZZMFNodeTypeClass) {
                [self dfs_mergeWithCodeInFileH:codeInFileH codeInFileM:codeInFileM node:child];
            }
        }
    }];
    [codeInFileH appendString:[self.config.fileHHandler ybmf_codeInfoWithNode:node]];
    [codeInFileH appendString:@"\n\n"];
    [codeInFileM appendString:[self.config.fileMHandler ybmf_codeInfoWithNode:node]];
    [codeInFileM appendString:@"\n\n"];
}

#pragma mark - tool

- (NSString *)allInfoFileH:(ZZModelFileNode *)node {
    NSString *noteInFileH = [self.config.fileNoteHander ybmf_fileNoteWithFileName:node.className fileType:ZZMFFileNoteTypeH];
    NSString *importInfoInFileH = [self.config.fileHHandler ybmf_importInfoWithNode:node withoutProperty:NO];
    NSString *codeInfoInFileH = [self.config.fileHHandler ybmf_codeInfoWithNode:node];
    NSString *allInfoFileH = [NSString stringWithFormat:
                              @"%@\n%@\n"
                              "NS_ASSUME_NONNULL_BEGIN\n\n"
                              "%@"
                              "\nNS_ASSUME_NONNULL_END\n", noteInFileH, importInfoInFileH, codeInfoInFileH];
    return allInfoFileH;
}

- (NSString *)allInfoFileM:(ZZModelFileNode *)node {
    NSString *noteInFileM = [self.config.fileNoteHander ybmf_fileNoteWithFileName:node.className fileType:ZZMFFileNoteTypeM];
    NSString *importInfoInFileM = [self.config.fileMHandler ybmf_importInfoWithNode:node];
    NSString *codeInfoInFileM = [self.config.fileMHandler ybmf_codeInfoWithNode:node];
    NSString *allInfoFileM = [NSString stringWithFormat:@"%@\n%@\n%@", noteInFileM, importInfoInFileM, codeInfoInFileM];
    return allInfoFileM;
}

@end
