//
//  ZZUIResponder+ClassHelper.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/3/8.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIResponder+ClassHelper.h"
#import "ZZUITableView.h"
#import "ZZUICollectionView.h"
#import "ZZNSMutableArray.h"
#import "ZZUICollectionViewFlowLayout.h"


@implementation ZZUIResponder (ClassHelper)

- (void)addPublicProperty:(ZZNSObject *)property withName:(NSString *)name andRemarks:(NSString *)remarks
{
    property.propertyName = name;
    property.remarks = remarks;
    if (([[property class] isSubclassOfClass:[ZZUITableView class]] || [[property class] isSubclassOfClass:[ZZUICollectionView class]]) && [[ZZClassHelper sharedInstance] canNamed:@"data"]) {
        ZZNSMutableArray *data = [[ZZNSMutableArray alloc] init];
        [self addPublicProperty:data withName:@"data" andRemarks:[property.propertyName stringByAppendingString:@"数据源"]];
    }
    [self.interfaceProperties addObject:property];
}

- (BOOL)removePublicProperty:(ZZNSObject *)property
{
    if ([self.interfaceProperties containsObject:property]) {
        [self.interfaceProperties removeObject:property];
        return YES;
    }
    return NO;
}

/// 添加私有属性
- (void)addPrivateProperty:(ZZNSObject *)property withName:(NSString *)name andRemarks:(NSString *)remarks
{
    property.propertyName = name;
    property.remarks = remarks;
    if (([[property class] isSubclassOfClass:[ZZUITableView class]] || [[property class] isSubclassOfClass:[ZZUICollectionView class]]) && [[ZZClassHelper sharedInstance] canNamed:@"data"]) {
        ZZNSMutableArray *data = [[ZZNSMutableArray alloc] init];
        [self addPrivateProperty:data withName:@"data" andRemarks:[property.propertyName stringByAppendingString:@"数据源"]];
    }
    if ([[property class] isSubclassOfClass:[ZZUICollectionView class]] && [[ZZClassHelper sharedInstance] canNamed:@"collectionViewFlowLayout"]) {
        ZZUICollectionViewFlowLayout *layout = [[ZZUICollectionViewFlowLayout alloc] init];
        [self addPrivateProperty:layout withName:@"collectionViewFlowLayout" andRemarks:[property.propertyName stringByAppendingString:@"CollectionViewLayout"]];
    }
    [self.extensionProperties addObject:property];
}

- (BOOL)removePrivateProperty:(ZZNSObject *)property
{
    if ([self.extensionProperties containsObject:property]) {
        [self.extensionProperties removeObject:property];
        return YES;
    }
    return NO;
}

- (BOOL)removePrivatePropertyAtIndex:(NSInteger)index
{
    if (index < self.extensionProperties.count) {
        [self.extensionProperties removeObjectAtIndex:index];
        return YES;
    }
    return NO;
}

- (BOOL)movePrivatePropertyAtIndex:(NSInteger)index toIndex:(NSInteger)toIndex
{
    if (index >= self.extensionProperties.count || toIndex > self.extensionProperties.count) {
        return NO;
    }
    id data = self.extensionProperties[index];
    if (index > toIndex) {
        [self.extensionProperties removeObjectAtIndex:index];
        [self.extensionProperties insertObject:data atIndex:toIndex];
    }
    else if (index < toIndex) {
        [self.extensionProperties insertObject:data atIndex:toIndex];
        [self.extensionProperties removeObjectAtIndex:index];
    }
    
    return YES;
}

@end
