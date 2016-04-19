//
//  NewsTitleModle.m
//  MNTeaNews
//
//  Created by qingyun on 16/3/18.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "NewsTitleModle.h"

@implementation NewsTitleModle
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.title = dict[@"title"];
        self.img = dict[@"imgsrc"];
        self.imgWebUrl = dict[@"url"];
        self.requestUrl = dict[@"requestUrl"];
    }
    return self;
}
+(instancetype)titleWithDictionary:(NSDictionary *)dict
{
    return [[self alloc]initWithDictionary:dict];
}
@end
