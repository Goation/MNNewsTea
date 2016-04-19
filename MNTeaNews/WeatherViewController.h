//
//  WeatherViewController.h
//  MNTeaNews
//
//  Created by qingyun on 16/3/11.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherViewController : UIViewController
@property (nonatomic,strong) NSString *cityId;
@property (nonatomic,strong) NSString *cityName;
-(void)loadCityInfo;
@end
