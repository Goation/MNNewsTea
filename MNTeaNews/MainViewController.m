//
//  MainViewController.m
//  MNTeaNews
//
//  Created by qingyun on 16/3/10.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "MainViewController.h"
#import "Header.h"
#import "WeatherViewController.h"
#import "IsMeViewController.h"

@interface MainViewController ()<UITabBarControllerDelegate,UIScrollViewDelegate>

@end

@implementation MainViewController

-(void)setTabBar
{
    //关于每个视图的tabBarItem的风格设置，实在每个视图初始化方法中自定义的
    NewsViewController *newsView = [[NewsViewController alloc]init];
    ReadViewController *readView = [[ReadViewController alloc]init];
    TalkViewController *talkView = [[TalkViewController alloc]init];
    
    self.viewControllers = @[newsView,talkView,readView];
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.tintColor = [UIColor colorWithRed:207/255.0 green:79/255.0 blue:53/225.0 alpha:1];;
    self.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBar];
    [self addBarItem];
}
-(void)addBarItem
{
    //设置关于我的导航leftButtonItem
    UIButton *isMeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [isMeButton setImage:[UIImage imageNamed:@"tea"] forState:UIControlStateNormal];
    //[isMeButton addTarget:self action:@selector(isMeBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    isMeButton.frame = CGRectMake(0, 0, 25, 25);
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:isMeButton];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    //rightButton
    UIButton *weateherButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [weateherButton setImage:[UIImage imageNamed:@"tianqi"] forState:UIControlStateNormal];
    [weateherButton addTarget:self action:@selector(weatherButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    weateherButton.frame = CGRectMake(CGRectGetMaxX(self.view.frame) - 10, 0, 30, 30);
    
   UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:weateherButton];
    self.navigationItem.rightBarButtonItem = rightButton;

    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 18)];
    titleLable.text = @"一杯茶新闻";
    titleLable.textColor = [UIColor colorWithRed:43/255.0 green:42/255.0 blue:56/255.0 alpha:1];
    titleLable.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLable;
    
}
//推出weather视图
-(void)weatherButtonClick:(UIButton *)sender
{
    //从storyboard中加载视图
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WeatherViewController *weatherView = [board instantiateViewControllerWithIdentifier:@"weather"];
    [self.navigationController pushViewController:weatherView animated:YES ];
}
//推出isMe视图
-(void)isMeBarButtonClick:(UIButton *)sender
{
    IsMeViewController *isMeView = [[IsMeViewController alloc]init];
    [self presentViewController:isMeView animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    //设置当由其控制器返回主界面时导航栏不隐藏
    self.navigationController.navigationBar.hidden = NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
