//
//  TalkHeaderModel.h
//  MNTeaNews
//
//  Created by qingyun on 16/4/15.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TalkHeaderModel : NSObject
@property (nonatomic,strong) NSString *imgTitle;//图片标题
@property (nonatomic,strong) NSString *picurl;//图片地址
@property (nonatomic,strong) NSString *name;//话题制造者名字
@property (nonatomic,strong) NSString *descriptions;//制造者简介
@property (nonatomic,strong) NSString *headpicurl;//头像
@property (nonatomic,strong) NSString *concernCount;//关注数
@property (nonatomic,strong) NSString *stitle;//导航栏上的tiitle
-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)talkHeaderForDictionary:(NSDictionary *)dict;
@end
