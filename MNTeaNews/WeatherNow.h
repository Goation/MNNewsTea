//
//  WeatherNow.h
//  MNTeaNews
//
//  Created by qingyun on 16/3/25.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherNow : NSObject
@property (nonatomic,strong)NSDictionary *cond;
@property (nonatomic,strong)NSString *txt;//天气状况
@property (nonatomic,strong)NSDictionary *wind;
@property (nonatomic,strong)NSString *dir;//风向
@property (nonatomic,strong)NSString *spd;//风速(kmph)
@property (nonatomic,strong)NSString *sc;//风力
@property (nonatomic,strong)NSString *tmp;//温度

-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)nowForDictionary:(NSDictionary *)dict;
@end
