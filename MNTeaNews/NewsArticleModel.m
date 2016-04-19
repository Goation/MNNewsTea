//
//  NewsArticleModel.m
//  MNTeaNews
//
//  Created by qingyun on 16/4/13.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "NewsArticleModel.h"

@implementation NewsArticleModel
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self == [super init]) {
        self.body = dict[@"body"];
        self.source = dict[@"source"];
        self.source_url = dict[@"source_url"];
        self.title = dict[@"title"];
        self.shareLink = dict[@"shareLink"];
    }
    return self;
}
+(instancetype)articleForDictionary:(NSDictionary *)dict
{
    return [[self alloc]initWithDictionary:dict];
}
@end
