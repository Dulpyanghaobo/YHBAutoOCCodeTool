//
//  ZZUITextField.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUITextField.h"
#import "ZZUITextFieldDelegate.h"

@implementation ZZUITextField
@synthesize properties = _properties;
@synthesize delegates = _delegates;
@synthesize events = _events;

- (NSArray *)delegates
{
    if (!_delegates) {
        ZZUITextFieldDelegate *delegate = [[ZZUITextFieldDelegate alloc] init];
        _delegates = @[delegate];
    }
    return _delegates;
}

- (NSMutableArray *)properties
{
    if (!_properties) {
        _properties = [super properties];
        
        // 文字
        ZZProperty *text = [[ZZProperty alloc] initWithPropertyName:@"text" type:ZZPropertyTypeString defaultValue:@""];
        ZZProperty *placeholder = [[ZZProperty alloc] initWithPropertyName:@"placeholder" type:ZZPropertyTypeString defaultValue:@""];
        
        // 字体格式
        ZZProperty *font = [[ZZProperty alloc] initWithPropertyName:@"font" type:ZZPropertyTypeFont defaultValue:nil];
        ZZProperty *textColor = [[ZZProperty alloc] initWithPropertyName:@"textColor" type:ZZPropertyTypeColor defaultValue:@"blackColor"];
        ZZProperty *textAlignment = [[ZZProperty alloc] initWithPropertyName:@"textAlignment" selectionData:[ZZUIHelperConfig sharedInstance].textAlignment andDefaultSelectIndex:0];
        
        ZZProperty *borderStyle = [[ZZProperty alloc] initWithPropertyName:@"borderStyle" selectionData:[ZZUIHelperConfig sharedInstance].borderStyle andDefaultSelectIndex:0];
        
        ZZProperty *clearButtonMode = [[ZZProperty alloc] initWithPropertyName:@"clearButtonMode" selectionData:[ZZUIHelperConfig sharedInstance].clearButtonModel andDefaultSelectIndex:0];
        ZZProperty *clearsOnBeginEditing = [[ZZProperty alloc] initWithPropertyName:@"clearsOnBeginEditing" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        
        // 键盘
        ZZProperty *keyboardType = [[ZZProperty alloc] initWithPropertyName:@"keyboardType" selectionData:[ZZUIHelperConfig sharedInstance].keyboardType andDefaultSelectIndex:0];
        ZZProperty *returnKeyType = [[ZZProperty alloc] initWithPropertyName:@"returnKeyType" selectionData:[ZZUIHelperConfig sharedInstance].returnKeyType andDefaultSelectIndex:0];
        ZZProperty *keyboardAppearance = [[ZZProperty alloc] initWithPropertyName:@"keyboardAppearance" selectionData:[ZZUIHelperConfig sharedInstance].keyboardAppearance andDefaultSelectIndex:0];


        ZZProperty *enablesReturnKeyAutomatically = [[ZZProperty alloc] initWithPropertyName:@"enablesReturnKeyAutomatically" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        ZZProperty *secureTextEntry = [[ZZProperty alloc] initWithPropertyName:@"secureTextEntry" type:ZZPropertyTypeBOOL defaultValue:@(NO)];
        
        // 代理
        ZZProperty *delegate = [[ZZProperty alloc] initWithPropertyName:@"delegate" type:ZZPropertyTypeObject defaultValue:@"self" selecetd:YES];
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UITextField" properties:@[text, placeholder, ZZ_PROPERTY_LINE, font, textColor, textAlignment, ZZ_PROPERTY_LINE, borderStyle, ZZ_PROPERTY_LINE, clearButtonMode, clearsOnBeginEditing, ZZ_PROPERTY_LINE, keyboardType, returnKeyType, keyboardAppearance, enablesReturnKeyAutomatically, secureTextEntry] privateProperties:@[delegate]];
        [_properties addObject:group];
    }
    return _properties;
}

- (NSArray *)events
{
    if (!_events) {
        ZZEvent *begin = [[ZZEvent alloc] initWithEventType:@"UIControlEventEditingDidBegin" selected:NO];
        ZZEvent *changed = [[ZZEvent alloc] initWithEventType:@"UIControlEventEditingChanged" selected:NO];
        ZZEvent *end = [[ZZEvent alloc] initWithEventType:@"UIControlEventEditingDidEnd" selected:NO];
        ZZEvent *exit = [[ZZEvent alloc] initWithEventType:@"UIControlEventEditingDidOnExit" selected:NO];
        _events = @[begin, changed, end, exit];
    }
    return _events;
}


@end
