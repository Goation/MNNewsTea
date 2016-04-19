//
//  NewsCellContent.m
//  MNTeaNews
//
//  Created by qingyun on 16/3/19.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "NewsCellContent.h"
#import "NewsTitleModle.h"

@implementation NewsCellContent

-(instancetype)initWithDictionatry:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.tou_id = dict[@"id"];
        self.postid = dict[@"postid"];
        self.imgscr = dict[@"imgsrc"];
        self.title = dict[@"title"];
        self.source = dict[@"source"];
        self.digest = dict[@"digest"];
        self.replyCount = dict[@"replyCount"];
        self.ads = dict[@"ads"];
        NSString *str = @"http://c.3g.163.com/nc/article/";
        if (self.tou_id != nil) {
            self.cellURL = [str stringByAppendingFormat:@"%@/full.html",self.tou_id];
        }else
        {
            self.cellURL = [str stringByAppendingFormat:@"%@/full.html",self.postid];
        }
    }
    return self;
}
+(instancetype)newsCellDictionary:(NSDictionary *)dict
{
    return [[self alloc]initWithDictionatry:dict];
}
@end
