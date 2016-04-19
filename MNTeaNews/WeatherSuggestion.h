//
//  WeatherSuggestion.h
//  MNTeaNews
//
//  Created by qingyun on 16/3/26.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherSuggestion : NSObject
@property (nonatomic,strong) NSDictionary *comf;//体感舒适建议
@property (nonatomic,strong) NSString *cbrf;
@property (nonatomic,strong) NSString *ctxt;
@property (nonatomic,strong) NSDictionary *cw;//洗车建议
@property (nonatomic,strong) NSString *cwbrf;
@property (nonatomic,strong) NSString *cwtxt;
@property (nonatomic,strong) NSDictionary *drsg;//穿衣建议
@property (nonatomic,strong) NSString *dbrf;
@property (nonatomic,strong) NSString *dtxt;
@property (nonatomic,strong) NSDictionary *flu;//病发建议
@property (nonatomic,strong) NSString *fbrf;
@property (nonatomic,strong) NSString *ftxt;
@property (nonatomic,strong) NSDictionary *sport;//运动建议
@property (nonatomic,strong) NSString *sbrf;
@property (nonatomic,strong) NSString *stxt;
@property (nonatomic,strong) NSDictionary *trav;//旅游建议
@property (nonatomic,strong) NSString *tbrf;
@property (nonatomic,strong) NSString *ttxt;
@property (nonatomic,strong) NSDictionary *uv;//紫外线建议
@property (nonatomic,strong) NSString *ubrf;
@property (nonatomic,strong) NSString *utxt;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)suggestionWithDictionary:(NSDictionary *)dict;
@end
