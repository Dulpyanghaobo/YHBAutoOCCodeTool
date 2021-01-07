//
//  ZZNSObject.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZNSObject.h"

@implementation ZZNSObject
@synthesize properties = _properties;
@synthesize delegates = _delegates;

#pragma mark - # 类名
- (id)init
{
    if (self = [super init]) {
        NSString *className = NSStringFromClass([self class]);
        if ([className hasPrefix:@"ZZ"]) {
            className = [className substringFromIndex:2];
        }
        self.superClassName = className;
    }
    return self;
}

- (NSString *)className
{
    if (_className.length == 0) {
        return self.superClassName;
    }
    return _className;
}

- (void)setPropertyName:(NSString *)propertyName
{
    self.propertyNameProperty.value = propertyName;
}
- (NSString *)propertyName
{
    return self.propertyNameProperty.value;
}
- (ZZProperty *)propertyNameProperty
{
    if (!_propertyNameProperty) {
        _propertyNameProperty = [[ZZProperty alloc] initWithPropertyName:@"name" type:ZZPropertyTypeString defaultValue:nil];
    }
    return _propertyNameProperty;
}

- (void)setRemarks:(NSString *)remarks
{
    self.remarksProperty.value = remarks;
}
- (NSString *)remarks
{
    return self.remarksProperty.value;
}
- (ZZProperty *)remarksProperty
{
    if (!_remarksProperty) {
        _remarksProperty = [[ZZProperty alloc] initWithPropertyName:@"remarks" type:ZZPropertyTypeString defaultValue:nil];
    }
    return _remarksProperty;
}

#pragma mark - # 属性代码
- (NSString *)propertyCode
{
    NSString *propertyCode = @"";
    if (self.remarks.length > 0) {
        propertyCode = [propertyCode stringByAppendingFormat:@"/// %@\n", self.remarks];
    }
    propertyCode = [propertyCode stringByAppendingFormat:@"@property (nonatomic, strong) %@ *%@;\n", self.className, self.propertyName];
    return propertyCode;
}

- (NSArray *)delegates
{
    if (!_delegates) {
        _delegates = @[];
    }
    return _delegates;
}

#pragma mark - # Getter
- (NSMutableArray *)properties
{
    if (!_properties) {
        _properties = [[NSMutableArray alloc] init];
    }
    return _properties;
}

- (NSString *)allocInitMethodName
{
    return [NSString stringWithFormat:@"[[%@ alloc] init]", self.className];
}

@end
