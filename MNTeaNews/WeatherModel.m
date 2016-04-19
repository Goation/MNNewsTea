//
//  WeatherModel.m
//  MNTeaNews
//
//  Created by qingyun on 16/3/25.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.now = dict[@"now"];
        self.daily_forecast = dict[@"daily_forecast"];
        self.api = dict[@"api"];
        self.suggestion = dict[@"suggestion"];
        self.basic = dict[@"basic"];
        self.city = self.basic[@"city"];
    }
    return self;
}
+(instancetype)weatherWithDictionary:(NSDictionary *)dict
{
    return [[self alloc]initWithDictionary:dict];
}
@end
