//
//  NewsCellContent.h
//  MNTeaNews
//
//  Created by qingyun on 16/3/19.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewsTitleModle;
@interface NewsCellContent : NSObject
@property (nonatomic,strong) NSString *tou_id;//cellid
@property (nonatomic,strong) NSString *imgscr;//图片地址
@property (nonatomic,strong) NSString *title;//celltitle
@property (nonatomic,strong) NSString *source;//新闻来源
@property (nonatomic,strong) NSString *digest;//内容
@property (nonatomic,strong) NSString *replyCount;//跟帖数
@property (nonatomic,strong) NSArray *ads;//广告图
@property (nonatomic,strong) NSString *cellURL;
@property (nonatomic,strong) NSString *postid;
-(instancetype)initWithDictionatry:(NSDictionary *)dict;
+(instancetype)newsCellDictionary:(NSDictionary *)dict;
@end
