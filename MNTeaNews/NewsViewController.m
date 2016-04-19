//
//  NewsViewController.m
//  MNTeaNews
//
//  Created by qingyun on 16/3/10.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "NewsViewController.h"
#import "Header.h"
#import "MainTableView.h"
#import "NewsTableViewCell.h"
#import "NewsCellContent.h"
#import "NewsHeader.h"

@interface NewsViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) UIScrollView *constScrollView;
@property (nonatomic,strong) NewsTitleModle *modle;
@property (nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,strong) UIView *underButtonView;
@property (nonatomic,strong) NSMutableArray *contentCells;
@property (nonatomic,strong) UIScrollView *titleScrollView;
@property (nonatomic,strong) UIView *titleUnderView;
@property (nonatomic,strong) MainTableView *mainTableView;
@property (nonatomic,strong) NewsHeader *headerView;
@property (nonatomic,strong) NSArray *requestImageArray;
@property (nonatomic,strong) NSArray *requestCellArray;
@property (nonatomic,strong) NSMutableArray *tableArray;
@property (nonatomic,strong) NSDictionary *ads;
@property (nonatomic,strong) AFHTTPSessionManager *manger;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic,strong) UIView *loadViews;
@end
@implementation NewsViewController

static NSString  *cellIdentifier = @"mainCell";
-(UIActivityIndicatorView *)activityIndicatorView
{
    if (_activityIndicatorView == nil) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicatorView.frame = CGRectMake(0, 0, 0, 0);
    }
    return _activityIndicatorView;
}
-(AFHTTPSessionManager *)manger
{
    if (_manger == nil) {
        _manger = [AFHTTPSessionManager manager];
    }
    return _manger;
}
-(NewsHeader *)headerView
{
    if (_headerView == nil) {
        _headerView = [NewsHeader initWithHeaderView];
    }
    return _headerView;
}
- (NSMutableArray *)contentCells {
    if (!_contentCells) {
        NSMutableArray *muArray = [NSMutableArray array];
        for (int i = 1; i < self.requestCellArray.count; i++) {
            NSDictionary *dict = self.requestCellArray[i];
            NewsCellContent *model = [[NewsCellContent alloc]initWithDictionatry:dict];
            [muArray addObject:model];
        }
        _contentCells = muArray;
    }
    return _contentCells;
}
-(NSMutableArray *)tableArray
{
    if (_tableArray == nil) {
        _tableArray = [NSMutableArray array];
    }
    return _tableArray;
}
-(NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
            NSMutableArray *muArray = [NSMutableArray array];
        if (self.requestImageArray == nil) {
            NewsTitleModle *model = [[NewsTitleModle alloc]initWithDictionary:self.ads];
            [muArray addObject:model];
            return muArray;
        }
        
            for (NSDictionary *dict in self.requestImageArray) {
            NewsTitleModle *model = [[NewsTitleModle alloc]initWithDictionary:dict];
            [muArray addObject:model];
        }
        _imageArray = muArray;
    }
    return _imageArray;
}
-(NSArray *)titleArray
{
    if (_titleArray == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"title" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];

        NSMutableArray *muArray = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            NewsTitleModle *modle = [[NewsTitleModle alloc]initWithDictionary:dict];
            [muArray addObject:modle];
        }
        _titleArray = muArray;
    }
    return _titleArray;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIImage *image = [UIImage imageNamed:@"iconfont-xinwen@2x"];
        UIImage *imageS = [UIImage imageNamed:@"iconfont-xinwenSelected@2x"];
        UITabBarItem *newsTabBar = [[UITabBarItem alloc]initWithTitle:@"新闻" image:image tag:101];
        self.tabBarItem = newsTabBar;
        newsTabBar.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        newsTabBar.selectedImage = [imageS imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addScrollAndTableView];
}

-(void)addScrollAndTableView
{
    //titleView的scrollView
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, ScreenW, 64)];
    scrollView.contentSize = CGSizeMake(self.titleArray.count * ButtonW, 0);
    [self.view addSubview:scrollView];
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    self.titleScrollView = scrollView;
    
    //titleScrollView的背景view
    UIView *underView = [[UIView alloc]initWithFrame:CGRectMake(0, -60, self.titleArray.count * ButtonW, UnderViewH)];
    [self.titleScrollView addSubview:underView];
    self.titleUnderView = underView;
    
    //滑动的underView
    CGFloat underButtonViewH = 2;
    CGFloat underBurronViewW = 60;
    UIView *underButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, UnderViewH - underButtonViewH, underBurronViewW , underButtonViewH)];
    underButtonView.backgroundColor = [UIColor redColor];
    underButtonView.center = CGPointMake(ButtonW / 2, underButtonView.center.y);
    [underView addSubview:underButtonView];
    
    self.underButtonView = underButtonView;
    
    //中部的scrollVie,tableView
    CGFloat scrollViewX = 0;
    CGFloat scrollViewY = CGRectGetHeight(scrollView.frame);
    CGFloat scrollViewW = ScreenW;
    CGFloat scrollViewH = ScreenH - scrollViewY - 64;
    
    UIScrollView *constScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(scrollViewX, 64 + UnderViewH, scrollViewW, scrollViewH)];
    constScrollView.showsHorizontalScrollIndicator = NO;
    constScrollView.pagingEnabled = YES;
    constScrollView.delegate = self;
    [self.view addSubview:constScrollView];
    self.constScrollView = constScrollView;
    constScrollView.contentSize = CGSizeMake( ScreenW * self.titleArray.count, 0);
    
    //添加button
    [self addButton:underView];
    
    //这里确保程序启动后，显示的第一个tableView有内容
    self.mainTableView = self.tableArray[0];
    self.mainTableView.tableHeaderView = self.headerView;
    NewsTitleModle *firstModel = self.titleArray.firstObject;
    [self networkingRequst:firstModel.requestUrl];
}

-(void)addButton:(UIView *)underView
{
    //添加button
    for (int i = 0; i < self.titleArray.count; i ++) {
        CGFloat buttonX = ButtonW * i;
        CGFloat buttonY = 0;
        
        NewsTitleModle *modle = self.titleArray[i];
    
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, buttonY, ButtonW, UnderViewH);
        [button setTitle:modle.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = 100 + i;
        
        [underView addSubview:button];
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchDown];
        
        //添加一个表数组
        MainTableView *mainTable = [self setTableView:self.constScrollView withTag:i];
        [self.tableArray addObject:mainTable];
        [self refreshData:mainTable];
    }
}

//标题的点击事件
-(void)titleButtonClick:(UIButton *)sender{
    //用于改变constScrollView的内容偏移量
    NSInteger numbers = sender.tag - 100;
    [UIView animateWithDuration:.5 animations:^{
        self.constScrollView.contentOffset = CGPointMake(ScreenW * numbers, 0);
    }];
    
    //改变underButtonView的center
    CGFloat buttonCenterX = sender.center.x;
    [UIView animateWithDuration:.5 animations:^{
        self.underButtonView.center = CGPointMake(buttonCenterX, self.underButtonView.center.y);
    }];
    
    //获取当前tableView进行网络请求，刷新表
    [self getTableVeiw:numbers];
}
#pragma mark -refreshControl
//下拉刷新
-(void)refreshData:(MainTableView *)tableView
{
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    refresh.tintColor = [UIColor orangeColor];
    
    [refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    //确定是要在哪个tableVeiw上进行下拉刷新
    [tableView addSubview:refresh];
}
-(void)refresh:(UIRefreshControl *)sender
{
    [sender beginRefreshing];
    self.mainTableView.isRequestNetwork = NO;
    [self getTableVeiw:self.mainTableView.tag];
    [sender endRefreshing];
}
#pragma mark -TableView
//设置constScrollView中的MainTableView
-(void)getTableVeiw:(NSInteger)numbers
{
    self.mainTableView = self.tableArray[numbers];
    NewsTitleModle *model = self.titleArray[numbers];
    
    //这里先判断是否已进行过网络请求，已经行过的，只能通过下拉刷新再次进行网络请求
    if (!self.mainTableView.isRequestNetwork) {
        //显示加载(蒙版)
        [self addActivityIndicatorView];
        self.activityIndicatorView.hidesWhenStopped = NO;
        [self.activityIndicatorView startAnimating];
        [self networkingRequst:model.requestUrl];
    }
}
-(MainTableView *)setTableView:(UIScrollView *)superView withTag:(NSInteger)tag{
    MainTableView *mainTableView = [[MainTableView alloc]initWithFrame:CGRectMake(ScreenW * tag, 0, ScreenW,superView.frame.size.height) style:UITableViewStylePlain];
    [superView addSubview:mainTableView];
    
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    mainTableView.rowHeight = 100;
    [mainTableView setTag:tag];
    //注册单元格
    [mainTableView registerNib:[UINib nibWithNibName:NSStringFromClass([NewsTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    return mainTableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contentCells.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsTableViewCell *newsCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    NewsCellContent *model = self.contentCells[indexPath.row];
    
    newsCell.cellModel = model;
    return newsCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCellContent *model = self.contentCells[indexPath.row];
    NSString *url = model.cellURL;
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewsWeb *newsWeb = [board instantiateViewControllerWithIdentifier:@"news"];
    newsWeb.webURL = url;
    newsWeb.cellID = model.tou_id;
    newsWeb.postid = model.postid;
    
     [self.navigationController pushViewController:newsWeb animated:YES];
}
#pragma -mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat count = scrollView.contentOffset.x / ScreenW;
    if (scrollView == self.constScrollView) {
        //当开始滑动时改变underButtonView的center.x
        [UIView animateWithDuration:.2 animations:^{
            self.underButtonView.center = CGPointMake(ButtonW / 2 + ButtonW * count, self.underButtonView.center.y);
        }];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //当滚动结束时,刷新当前滚动到的表,并进行网路请求
    if (scrollView == self.constScrollView) {
        CGPoint point = scrollView.contentOffset;
        NSInteger tag = point.x / ScreenW;
        [self getTableVeiw:tag];
        //顶部titleScrollView的内容偏移量
        if (tag >= 8) {
            [UIView animateWithDuration:.4 animations:^{
                self.titleScrollView.contentOffset = CGPointMake(74 * 8, self.titleScrollView.contentOffset.y);
            }];
        }else{
            [UIView animateWithDuration:.4 animations:^{
                self.titleScrollView.contentOffset = CGPointMake(74 * tag, self.titleScrollView.contentOffset.y);
            }];
        }
    }
}
#pragma mark -networking
-(void)networkingRequst:(NSString *)requestURL
{
    self.manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self.manger GET:requestURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSArray *array  = rootDict.allValues;
        
        //获取内容
        self.requestCellArray = array[0];
        //获取header的图片
        NSDictionary *ads = self.requestCellArray[0];
        //进行model转化
        self.ads = ads;
        self.requestImageArray = ads[@"ads"];
        
        //设置titleImage
        self.headerView.imagePaths = self.imageArray;
        //设置contentCell
        self.contentCells = nil;
        //每次网络请求时都需要对数据进行model转化
        self.imageArray = nil;
        
        self.mainTableView.tableHeaderView = self.headerView;
        self.mainTableView.isRequestNetwork = YES;
        //在这里需要对self.headerView置空，目的是每次网络请求时都需要对数据进行model转化
        self.headerView  = nil;
        
        [self.activityIndicatorView stopAnimating];
        [self.loadViews removeFromSuperview];
        [self.mainTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self alertView];
    }];
}
#pragma mark -加载
//网路加载失败，弹窗提示
-(void)alertView
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络请求失败,请检查网络设置" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.activityIndicatorView stopAnimating];
        [self.loadViews removeFromSuperview];
    }];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
//加载中
-(void)addActivityIndicatorView
{
    self.loadViews = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.loadViews.backgroundColor = [UIColor whiteColor];
    self.loadViews.alpha = 0.8f;
    
    self.activityIndicatorView.center = self.view.center;
    [self.view addSubview:self.loadViews];
    [self.loadViews addSubview:self.activityIndicatorView];
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
