//
//  NewsHeader.m
//  MNTeaNews
//
//  Created by qingyun on 16/4/7.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "NewsHeader.h"
#import "Header.h"
#import "UIImageView+WebCache.h"

@interface NewsHeader ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *imageScroll;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *centerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel *imageTitle;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic) NSInteger currentIndex;
@end
@implementation NewsHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setImagePaths:(NSArray *)imagePaths
{
    _imagePaths = imagePaths;
    
    //设置标题图片
    [self setImageForImageView];
    _pageControl.numberOfPages = imagePaths.count;
    
    if (imagePaths.count == 1) {
        _pageControl.hidden = YES;
        _imageScroll.scrollEnabled = NO;
    }else
    {
        _pageControl.hidden = NO;
    }
}
-(void)setImageForImageView
{
    self.pageControl.currentPage = self.currentIndex;
    
    NewsTitleModle *lmodel = self.imagePaths[[self indexEnable:self.currentIndex - 1]];
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:lmodel.img]];
    
    //当前显示的图片
    NewsTitleModle *cmodel = self.imagePaths[[self indexEnable:self.currentIndex]];
    [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:cmodel.img]];
    self.imageTitle.text = cmodel.title;
    
    NewsTitleModle *rmodel = self.imagePaths[[self indexEnable:self.currentIndex + 1]];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:rmodel.img]];
    
    //设置偏移量,始终显示当前页面的image
    self.imageScroll.contentOffset = CGPointMake(ScreenW, 0);
}
//确保当前的index是可用的
-(NSInteger)indexEnable:(NSInteger)index
{
    if (index < 0) {
        return self.imagePaths.count - 1;
    }
    else if(index > self.imagePaths.count - 1)
    {
        return 0;
    }
    else
    {
        return index;
    }
}
-(void)awakeFromNib
{
    self.imageScroll.delegate = self;
#if 0
    self.leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.leftImageView.layer.masksToBounds = YES;
    
    self.centerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.centerImageView.layer.masksToBounds = YES;
    
    self.rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.rightImageView.layer.masksToBounds = YES;
#endif
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToWebView)];
    [self.centerImageView addGestureRecognizer:tap];
    
     //self.imageScroll.contentOffset = CGPointMake(ScreenW, 0);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.imageScroll) {
        if (self.imageScroll.contentOffset.x == 0) {
            self.currentIndex--;//右滑
        }
        else if(self.imageScroll.contentOffset.x == ScreenW * 2)
        {
            self.currentIndex++;//左滑
        }
    }
    //确保当前的index是可用的
    self.currentIndex = [self indexEnable:self.currentIndex];
    [self setImageForImageView];
}
-(void)goToWebView
{
    NewsTitleModle *model = self.imagePaths[self.currentIndex];
    if (self.goToWeb) {
        self.goToWeb(model.imgWebUrl);
    }
}
+(instancetype)initWithHeaderView
{
    NSArray *viewArray = [[NSBundle mainBundle]loadNibNamed:@"NewsHeader" owner:self options:nil];
    NewsHeader *headerView = viewArray.firstObject;
    
    return headerView;
}
@end
