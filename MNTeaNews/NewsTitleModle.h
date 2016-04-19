//
//  NewsTitleModle.h
//  MNTeaNews
//
//  Created by qingyun on 16/3/18.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsTitleModle : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *imgWebUrl;
@property (nonatomic,strong) NSString *requestUrl;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)titleWithDictionary:(NSDictionary *)dict;
@end
