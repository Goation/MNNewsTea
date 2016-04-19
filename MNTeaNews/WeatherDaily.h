//
//  WeatherDaily.h
//  MNTeaNews
//
//  Created by qingyun on 16/3/28.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherDaily : NSObject
@property (nonatomic,strong) NSDictionary *astro;
@property (nonatomic,strong) NSDictionary *cond;
@property (nonatomic,strong) NSDictionary *tmp;
@end
