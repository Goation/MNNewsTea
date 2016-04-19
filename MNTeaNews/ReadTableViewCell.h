//
//  ReadTableViewCell.h
//  MNTeaNews
//
//  Created by qingyun on 16/3/22.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadCellContent.h"

@interface ReadTableViewCell : UITableViewCell
@property (nonatomic,strong) ReadCellContent *model;
@end
