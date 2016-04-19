//
//  NewsArticleModel.h
//  MNTeaNews
//
//  Created by qingyun on 16/4/13.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsArticleModel : NSObject
@property (nonatomic,strong) NSString *body;//文章内容
@property (nonatomic,strong) NSString *source;//文章来源
@property (nonatomic,strong) NSString *title;//文章的cell标题
@property (nonatomic,strong) NSString *shareLink;//网易的新闻网址
@property (nonatomic,strong) NSString *source_url;//新闻来源网址

-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)articleForDictionary:(NSDictionary *)dict;
@end
