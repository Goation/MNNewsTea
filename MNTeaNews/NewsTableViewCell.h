//
//  NewsTableViewCell.h
//  MNTeaNews
//
//  Created by qingyun on 16/3/19.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsCellContent.h"

@interface NewsTableViewCell : UITableViewCell
@property (nonatomic,strong) NewsCellContent *cellModel;
@end
