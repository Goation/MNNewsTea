//
//  ReadCellContent.h
//  MNTeaNews
//
//  Created by qingyun on 16/3/31.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadCellContent : NSObject
@property (nonatomic,strong) NSString *digest;//副标题
@property (nonatomic,strong) NSString *title;//标题
@property (nonatomic,strong) NSString *ID;//标识
@property (nonatomic,strong) NSString *imageLink;//图片连接地址
@property (nonatomic,strong) NSString *source;//新闻来源
@property (nonatomic,strong) NSString *cellURL;//每行跳转页面的地址
-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)readForDictionary:(NSDictionary *)dict;
@end
