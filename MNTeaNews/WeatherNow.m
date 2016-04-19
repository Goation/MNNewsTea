//
//  WeatherNow.m
//  MNTeaNews
//
//  Created by qingyun on 16/3/25.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "WeatherNow.h"

@implementation WeatherNow
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.tmp = dict[@"tmp"];
        self.cond = dict[@"cond"];
        self.txt = self.cond[@"txt"];
        self.wind = dict[@"wind"];
        self.dir = self.wind[@"dir"];
        self.sc = self.wind[@"sc"];
        self.spd = self.wind[@"spd"];
    }
    return self;
}
+(instancetype)nowForDictionary:(NSDictionary *)dict
{
    return [[self alloc]initWithDictionary:dict];
}
@end
