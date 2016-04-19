//
//  ReadTableViewCell.m
//  MNTeaNews
//
//  Created by qingyun on 16/3/22.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "ReadTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface ReadTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *contentImage;
@property (weak, nonatomic) IBOutlet UILabel *contentText;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UIView *underView;

@end
@implementation ReadTableViewCell
-(void)setModel:(ReadCellContent *)model
{
    _model = model;
    
    //设置边框，阴影
    _underView.layer.borderWidth = 0.5;
    _underView.layer.borderColor = [[UIColor grayColor]CGColor];
    _underView.layer.cornerRadius = 2;
    _underView.layer.shadowOffset = CGSizeMake(0, 2);
    _underView.layer.shadowRadius = 3;
    _underView.layer.shadowOpacity = 0.3;

    [_contentImage sd_setImageWithURL:[NSURL URLWithString:model.imageLink]];
    _contentText.text = model.title;
    _nickname.text = model.source;
    
}
- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)deleteCell:(UIButton *)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectedBackgroundView = [[UIView alloc]initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    // Configure the view for the selected state
}

@end
