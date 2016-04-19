//
//  TalkCellModel.h
//  MNTeaNews
//
//  Created by qingyun on 16/4/15.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TalkCellModel : NSObject
@property (nonatomic,strong) NSDictionary *question;//提问
@property (nonatomic,strong) NSString *questionId;//提问者ID
@property (nonatomic,strong) NSString *qcontent;//提问内容
@property (nonatomic,strong) NSString *userName;//提问者昵称
@property (nonatomic,strong) NSString *userHeadPicUrl;//提问者头像

@property (nonatomic,strong) NSDictionary *answer;//回答
@property (nonatomic,strong) NSString *answerId;
@property (nonatomic,strong) NSString *acontent;//回答的内容
@property (nonatomic,strong) NSString *specialistName;//回答者昵称
@property (nonatomic,strong) NSString *specialistHeadPicUrl;//头像地址

@property (nonatomic) NSInteger suppotrCount;//点赞数
@property (nonatomic) NSInteger replyCount;//评论数
@property (nonatomic,strong) NSString *cTime;//评论时间

-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)talkForDictionary:(NSDictionary *)dict;
@end

