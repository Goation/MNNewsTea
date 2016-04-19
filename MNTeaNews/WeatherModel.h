//
//  WeatherModel.h
//  MNTeaNews
//
//  Created by qingyun on 16/3/25.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherHeader.h"

@interface WeatherModel : NSObject
@property (nonatomic,strong) NSDictionary *now;//现在的天气
@property (nonatomic,strong) NSDictionary *suggestion;//建议
@property (nonatomic,strong) NSDictionary *api;//天气指数
@property (nonatomic,strong) NSDictionary *daily_forecast;//未来三天天气
@property (nonatomic,strong) NSDictionary *basic;
@property (nonatomic,strong) NSString *city;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)weatherWithDictionary:(NSDictionary *)dict;
@end
