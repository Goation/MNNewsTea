//
//  WeatherSuggestion.m
//  MNTeaNews
//
//  Created by qingyun on 16/3/26.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "WeatherSuggestion.h"

@implementation WeatherSuggestion

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.comf = dict[@"comf"];
        self.cbrf = self.comf[@"brf"];
        self.ctxt = self.comf[@"txt"];
        
        self.cw = dict[@"cw"];
        self.cwbrf = self.cw[@"brf"];
        self.cwtxt = self.cw[@"txt"];
        
        self.drsg = dict[@"drsg"];
        self.dbrf = self.drsg[@"brf"];
        self.dtxt = self.drsg[@"txt"];
        
        self.flu = dict[@"flu"];
        self.fbrf = self.flu[@"brf"];
        self.ftxt = self.flu[@"txt"];
        
        self.sport = dict[@"sport"];
        self.sbrf = self.sport[@"brf"];
        self.stxt = self.sport[@"txt"];
        
        self.trav = dict[@"trav"];
        self.tbrf = self.trav[@"brf"];
        self.ttxt = self.trav[@"txt"];
        
        self.uv = dict[@"uv"];
        self.ubrf = self.uv[@"brf"];
        self.utxt = self.uv[@"txt"];
    }
    return self;
}
+(instancetype)suggestionWithDictionary:(NSDictionary *)dict
{
    return [[self alloc]initWithDictionary:dict];
}
@end
