//
//  ZZMFFileNoteHandler.m
//  ZZUIHelper
//
//  Created by 杨皓博 on 2021/1/10.
//  Copyright © 2021 李伯坤. All rights reserved.
//

#import "ZZMFFileNoteHandler.h"

@implementation ZZMFFileNoteHandler

@synthesize ybmf_developer = _ybmf_developer;
@synthesize ybmf_organization = _ybmf_organization;
@synthesize ybmf_executableName = _ybmf_executableName;

#pragma mark - life cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ybmf_executableName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];
        self.ybmf_developer = @"indulgeIn";
        self.ybmf_organization = @"indulgeIn";    }
    return self;
}

#pragma mark - <YBMFFileNoteHandler>

- (NSString *)ybmf_fileNoteWithFileName:(NSString *)fileName fileType:(ZZMFFileNoteType)fileType {
    if (!fileName || fileName.length == 0) return @"";
    
    NSMutableString *fileNote = [NSMutableString string];
    
    NSDate *date = NSDate.date;
    NSDateFormatter *format = NSDateFormatter.new;
    [format setDateFormat:@"yyyy/MM/dd"];
    NSString *dateStr = [format stringFromDate:date];
    NSDateFormatter *format1 = NSDateFormatter.new;
    [format1 setDateFormat:@"yyyy"];
    NSString *dateYearStr = [format1 stringFromDate:date];
    
    [fileNote appendString:@"//\n"];
    [fileNote appendString:[NSString stringWithFormat:@"//  %@%@\n", fileName, fileType == ZZMFFileNoteTypeH ? @".h" : @".m"]];
    [fileNote appendString:[NSString stringWithFormat:@"//  %@\n", self.ybmf_executableName]];
    [fileNote appendString:@"//\n"];
    [fileNote appendString:[NSString stringWithFormat:@"//  Created by %@ on %@.\n", self.ybmf_developer, dateStr]];
    [fileNote appendString:[NSString stringWithFormat:@"//  Copyright © %@ %@. All rights reserved.\n", dateYearStr, self.ybmf_organization]];
    [fileNote appendString:@"//\n"];
    
    return fileNote;
}

@end
