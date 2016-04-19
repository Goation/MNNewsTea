//
//  TalkCellContent.h
//  MNTeaNews
//
//  Created by qingyun on 16/3/22.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TalkCellContent : NSObject
@property (nonatomic,strong) NSString *contentImageLink;//内容视图
@property (nonatomic,strong) NSString *avatarImageLink;//专家头像
@property (nonatomic,strong) NSString *nickname;//专家昵称
@property (nonatomic,strong) NSString *contentText;//专家简介
@property (nonatomic,strong) NSString *followText;//关注
@property (nonatomic,strong) NSString *queryText;//提问
@property (nonatomic,strong) NSString *title;//副标题
@property (nonatomic,strong) NSString *classification;//类别
@property (nonatomic) BOOL isFollow;//是否关注
@property (nonatomic,strong) NSString *expertID;//专家id
@property (nonatomic,strong) NSString *cellURL;
-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)talkWithDictionary:(NSDictionary *)dict;
@end
