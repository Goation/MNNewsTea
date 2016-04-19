//
//  TalkHeader.h
//  MNTeaNews
//
//  Created by qingyun on 16/4/15.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TalkHeaderModel.h"

@interface TalkHeader : UITableViewHeaderFooterView

@property (nonatomic,strong)TalkHeaderModel *model;
+(instancetype)initWithHeaderView;
@end
