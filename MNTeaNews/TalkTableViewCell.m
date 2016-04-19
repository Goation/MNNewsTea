//
//  TalkTableViewCell.m
//  MNTeaNews
//
//  Created by qingyun on 16/3/21.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "TalkTableViewCell.h"
#import "TalkCellContent.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface TalkTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *contentsView;//内容视图
@property (weak, nonatomic) IBOutlet UIButton *classification;//分类
@property (weak, nonatomic) IBOutlet UILabel *nameTitle;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;//头像
@property (weak, nonatomic) IBOutlet UILabel *nickName;//昵称
@property (weak, nonatomic) IBOutlet UILabel *contentLable;//内容
@property (weak, nonatomic) IBOutlet UILabel *followLable;//关注
@property (weak, nonatomic) IBOutlet UILabel *queryLable;//提问
@property (weak, nonatomic) IBOutlet UIView *underView;
@property (weak, nonatomic) IBOutlet UIButton *addFollow;
@property (nonatomic,strong) NSString *expertID;
@property (nonatomic)BOOL isFollow;
@end
@implementation TalkTableViewCell
-(void)setTalkModel:(TalkCellContent *)talkModel
{
    _talkModel = talkModel;
    
    [_contentsView sd_setImageWithURL:[NSURL URLWithString:talkModel.contentImageLink]];
    [_avatarImage sd_setImageWithURL:[NSURL URLWithString:talkModel.avatarImageLink]];
    
    [_classification setTitle:[NSString stringWithFormat:@"%@ |",talkModel.classification] forState:UIControlStateNormal];
    _nameTitle.text = [NSString stringWithFormat:@"/%@",talkModel.title];
    _nickName.text = talkModel.nickname;
    _contentLable.text = talkModel.contentText;
    _followLable.text = [NSString stringWithFormat:@"%@关注",talkModel.followText];
    _queryLable.text = [NSString stringWithFormat:@"%@提问",talkModel.queryText];
    _expertID = talkModel.expertID;
    
    [self setView];
    [self addFollowButtonStatus:_isFollow];
}
- (void)awakeFromNib {
    // Initialization code
}
-(void)setView
{
    //设置underView边框
    _underView.layer.borderWidth = 0.8;
    _underView.layer.borderColor = [[UIColor grayColor]CGColor];
    _underView.layer.cornerRadius = 5;
    //设置阴影
    //_underView.layer.shadowOffset = CGSizeMake(0, 10);
    //_underView.layer.shadowOpacity = 0.2;
    //addFollow
    _addFollow.layer.cornerRadius = 15;
    _addFollow.backgroundColor = [UIColor colorWithRed:203/255.0 green:67/255.0 blue:64/255.0 alpha:1];
    //[self addFollowButtonStatus:_isFollow];
    
    _contentsView.layer.shadowOpacity = 0.3;
    _contentsView.layer.shadowOffset = CGSizeMake(10, 6);
    
    _avatarImage.layer.cornerRadius = 25;
    _avatarImage.layer.masksToBounds = YES;

}
-(void)addFollowButtonStatus:(BOOL)isFollow
{
    if (isFollow) {
        self.addFollow.hidden = YES;
    }else
    {
        self.addFollow.hidden = NO;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    //取消选中cell的背景
    self.selectedBackgroundView = [[UIView alloc]initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    // Configure the view for the selected state
}

@end
