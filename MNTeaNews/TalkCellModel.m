//
//  TalkCellModel.m
//  MNTeaNews
//
//  Created by qingyun on 16/4/15.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "TalkCellModel.h"

@implementation TalkCellModel
//@property (nonatomic,strong) NSDictionary *question;//提问
//@property (nonatomic,strong) NSString *questionId;//提问者ID
//@property (nonatomic,strong) NSString *qcontent;//提问内容
//@property (nonatomic,strong) NSString *userName;//提问者昵称
//@property (nonatomic,strong) NSString *userHeadPicUrl;//提问者头像
//
//@property (nonatomic,strong) NSDictionary *answer;//回答
//@property (nonatomic,strong) NSString *answerId;
//@property (nonatomic,strong) NSString *acontent;//回答的内容
//@property (nonatomic,strong) NSString *specialistName;//回答者昵称
//@property (nonatomic,strong) NSString *specialistHeadPicUrl;//头像地址
//
//@property (nonatomic) NSInteger suppotrCount;//点赞数
//@property (nonatomic) NSInteger replyCount;//评论数
//@property (nonatomic,strong) NSString *cTime;//评论时间
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self == [super init]) {
        self.question = dict[@"question"];
        self.answer = dict[@"answer"];
        
        self.questionId = self.question[@"questionId"];
        self.qcontent = self.question[@"content"];
        self.userName = self.question[@"userName"];
        self.userHeadPicUrl = self.question[@"userHeadPicUrl"];
        
        self.answerId = self.answer[@"answerId"];
        self.acontent = self.answer[@"content"];
        self.specialistName = self.answer[@"specialistName"];
        self.specialistHeadPicUrl = self.answer[@"specialistHeadPicUrl"];
        
        self.suppotrCount = [self.answer[@"suppotrCount"] integerValue];
        self.replyCount = [self.answer[@"replyCount"] integerValue];
        self.cTime = self.answer[@"cTime"];
    }
    return self;
}
+(instancetype)talkForDictionary:(NSDictionary *)dict
{
    return [[self alloc]initWithDictionary:dict];
}
@end
