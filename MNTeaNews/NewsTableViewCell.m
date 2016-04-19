//
//  NewsTableViewCell.m
//  MNTeaNews
//
//  Created by qingyun on 16/3/19.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface NewsTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageViews;
@property (weak, nonatomic) IBOutlet UILabel *titleText;
@property (weak, nonatomic) IBOutlet UILabel *contentText;
@property (nonatomic,strong) NSString *tou_id;
@property (nonatomic,strong) NSString *replyCount;
@end
@implementation NewsTableViewCell

-(void)setCellModel:(NewsCellContent *)cellModel
{
    _cellModel = cellModel;
    
    //[_imageViews sd_setImageWithURL:[NSURL URLWithString:cellModel.imgscr]];
    [_imageViews sd_setImageWithURL:[NSURL URLWithString:cellModel.imgscr] placeholderImage:[UIImage imageNamed:@"social-placeholder"]];
    _titleText.text = cellModel.title;
    _contentText.text = cellModel.digest;
    _tou_id = cellModel.tou_id;
    _replyCount = cellModel.replyCount;
}
- (void)awakeFromNib {
    [self.contentView bringSubviewToFront:_titleText];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    //self.selectedBackgroundView = [[UIView alloc]initWithFrame:self.frame];
    //self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    // Configure the view for the selected state
}

@end
