//
//  NewsHeader.h
//  MNTeaNews
//
//  Created by qingyun on 16/4/7.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsHeader : UITableViewHeaderFooterView
@property (nonatomic,strong) NSArray *imagePaths;//图片的地址
@property (nonatomic,strong) void(^goToWeb)(NSString *imageUrl);

+(instancetype)initWithHeaderView;
-(void)setImageForImageView;
@end
