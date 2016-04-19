//
//  TalkCellContent.m
//  MNTeaNews
//
//  Created by qingyun on 16/3/22.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "TalkCellContent.h"

@implementation TalkCellContent
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.contentImageLink = dict[@"picurl"];
        self.avatarImageLink = dict[@"headpicurl"];
        self.nickname = dict[@"name"];
        self.contentText = dict[@"description"];
        self.followText = [dict[@"concernCount"] stringValue];
        self.queryText = [dict[@"questionCount"] stringValue];
        self.title = dict[@"title"];
        self.classification = dict[@"classification"];
        self.expertID = dict[@"expertId"];
        self.isFollow = NO;
        
        NSString *str = @"http://c.3g.163.com/newstopic/qa/";
        self.cellURL = [str stringByAppendingFormat:@"%@.html",self.expertID];
    }
    return self;
}
+(instancetype)talkWithDictionary:(NSDictionary *)dict
{
    return  [[self alloc]initWithDictionary:dict];
}
@end
