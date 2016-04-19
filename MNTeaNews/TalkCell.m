//
//  TalkCell.m
//  MNTeaNews
//
//  Created by qingyun on 16/4/15.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "TalkCell.h"
#import "UIImageView+WebCache.h"

@interface TalkCell()
@property (weak, nonatomic) IBOutlet UIView *contentViews;
@property (weak, nonatomic) IBOutlet UIImageView *userHead;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userContent;
@property (weak, nonatomic) IBOutlet UIImageView *specialistHead;
@property (weak, nonatomic) IBOutlet UILabel *specialistName;
@property (weak, nonatomic) IBOutlet UILabel *specialistContent;
@property (weak, nonatomic) IBOutlet UIView *underView;

@end
@implementation TalkCell
-(void)setModel:(TalkCellModel *)model
{
    _model = model;
    
    [self.userHead sd_setImageWithURL:[NSURL URLWithString:self.model.userHeadPicUrl]];
    [self.specialistHead sd_setImageWithURL:[NSURL URLWithString:self.model.specialistHeadPicUrl]];
    
    self.underView.layer.borderWidth = 0.8;
    self.underView.layer.borderColor = [[UIColor grayColor]CGColor];
    self.underView.layer.cornerRadius = 3;
    
    self.userHead.layer.cornerRadius = 25;
    self.userHead.layer.masksToBounds = YES;
    self.specialistHead.layer.cornerRadius = 25;
    self.specialistHead.layer.masksToBounds = YES;
    
    self.userName.text = self.model.userName;
    self.userContent.text = self.model.qcontent;
    
    self.specialistName.text = self.model.specialistName;
    self.specialistContent.text = self.model.acontent;
}
- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectedBackgroundView = [[UIView alloc]initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
}

@end
