//
//  TalkHeaderModel.m
//  MNTeaNews
//
//  Created by qingyun on 16/4/15.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "TalkHeaderModel.h"

@implementation TalkHeaderModel
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self == [super init]) {
        self.imgTitle = dict[@"alias"];
        self.picurl = dict[@"picurl"];
        self.name = dict[@"name"];
        self.descriptions = dict[@"description"];
        self.headpicurl = dict[@"headpicurl"];
        self.concernCount = dict[@"concernCount"];
        self.stitle = dict[@"stitle"];
    }
    return self;
}
+(instancetype)talkHeaderForDictionary:(NSDictionary *)dict
{
    return [[self alloc]initWithDictionary:dict];
}
@end
