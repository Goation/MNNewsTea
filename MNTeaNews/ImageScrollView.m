//
//  ImageScrollView.m
//  MNTeaNews
//
//  Created by qingyun on 16/3/16.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "ImageScrollView.h"

@interface ImageScrollView ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic) NSInteger count;
@end
@implementation ImageScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.pagingEnabled = YES;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}
//添加图片
-(void)setImage:(UIImage *)image
{
    
    _image = image;
    //self.count++;
    //NSLog(@"count:%ld",self.count);
}
//滑动停止时
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
