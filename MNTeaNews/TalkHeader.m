//
//  TalkHeader.m
//  MNTeaNews
//
//  Created by qingyun on 16/4/15.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "TalkHeader.h"
#import "UIImageView+WebCache.h"
@interface TalkHeader ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UIView *lableView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userContent;
@property (weak, nonatomic) IBOutlet UILabel *imgTitle;

@end
@implementation TalkHeader
-(void)setModel:(TalkHeaderModel *)model
{
    _model = model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.picurl]];
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:model.headpicurl]];
    self.userName.text = model.name;
    self.userContent.text = model.descriptions;
    self.imgTitle.text = model.imgTitle;
    
    self.userImageView.layer.cornerRadius = 25;
    self.userImageView.layer.masksToBounds = YES;
    
    self.bottomView.layer.borderWidth = 0.8;
    self.bottomView.layer.borderColor = [[UIColor grayColor]CGColor];
    self.bottomView.layer.cornerRadius = 3;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)initWithHeaderView
{
     NSArray *viewArray = [[NSBundle mainBundle]loadNibNamed:@"TalkHeader" owner:self options:nil];
    TalkHeader *talkView = viewArray.firstObject;
    
    return talkView;
}
@end
