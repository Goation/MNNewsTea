//
//  ReadCellContent.m
//  MNTeaNews
//
//  Created by qingyun on 16/3/31.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "ReadCellContent.h"

@implementation ReadCellContent
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.digest = dict[@"digest"];
        self.title = dict[@"title"];
        self.ID = dict[@"id"];
        self.imageLink = dict[@"imgsrc"];
        self.source = dict[@"source"];
        
        NSString *str = @"http://c.3g.163.com/nc/article/";
        self.cellURL = [str stringByAppendingFormat:@"%@/full.html",self.ID];
    }
    return self;
}
+(instancetype)readForDictionary:(NSDictionary *)dict
{
    return [[self alloc]initWithDictionary:dict];
}
@end
