//
//  TalkCellController.m
//  MNTeaNews
//
//  Created by qingyun on 16/4/15.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "TalkCellController.h"
#import "Header.h"
#import "TalkCellModel.h"
#import "TalkCell.h"
#import "TalkHeaderModel.h"
#import "TalkHeader.h"

@interface TalkCellController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) AFHTTPSessionManager *manger;
@property (nonatomic,strong) NSArray *hotList;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic,strong) UIView *loadViews;
@property (nonatomic,strong) TalkHeaderModel *headerModel;
@property (nonatomic,strong) NSDictionary *dict;
@property (nonatomic,strong)TalkHeader *talkHeaderView;
@property (nonatomic,strong) UIView *barView;
@property (nonatomic,strong) UILabel *navTilte;
@end

@implementation TalkCellController
static NSString *Identifier = @"talk";
-(UIActivityIndicatorView *)activityIndicatorView
{
    if (_activityIndicatorView == nil) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicatorView.frame = CGRectMake(0, 0, 0, 0);
    }
    return _activityIndicatorView;
}
-(TalkHeader *)talkHeaderView
{
    if (_talkHeaderView == nil) {
        _talkHeaderView = [TalkHeader initWithHeaderView];
    }
    return _talkHeaderView;
}
-(NSArray *)hotList
{
    if (_hotList == nil) {
        _hotList = [NSArray array];
    }
    return _hotList;
}
-(AFHTTPSessionManager *)manger
{
    if (_manger == nil) {
        _manger = [AFHTTPSessionManager manager];
    }
    return _manger;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavBar];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 230;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addActivityIndicatorView];
    self.activityIndicatorView.hidesWhenStopped = NO;
    [self.activityIndicatorView startAnimating];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TalkCell class]) bundle:nil] forCellReuseIdentifier:Identifier];
    [self networkingRequest];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -networkingRequest
-(void)networkingRequest
{
    self.manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self.manger GET:self.webUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSDictionary *data = rootDict[@"data"];
        self.dict = [[NSDictionary alloc]init];
        self.dict = data[@"expert"];
        
        self.hotList = data[@"hotList"];
        NSMutableArray *muArray = [NSMutableArray array];
        for (NSDictionary *dict in self.hotList) {
            TalkCellModel *model = [[TalkCellModel alloc]initWithDictionary:dict];
            [muArray addObject:model];
        }
        
        self.hotList = muArray;
        [self.activityIndicatorView stopAnimating];
        [self.loadViews removeFromSuperview];
        self.headerModel = [[TalkHeaderModel alloc]initWithDictionary:self.dict];
        
        self.talkHeaderView.model = self.headerModel;
        self.tableView.tableHeaderView = self.talkHeaderView;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"talk error===%@",error);
    }];
}
-(void)addActivityIndicatorView
{
    self.loadViews = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.loadViews.backgroundColor = [UIColor whiteColor];
    self.loadViews.alpha = 0.8f;
    
    self.activityIndicatorView.center = self.view.center;
    [self.view addSubview:self.loadViews];
    [self.loadViews addSubview:self.activityIndicatorView];
}

#pragma mark -UITableViewDataSource,UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hotList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TalkCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    TalkCellModel *model = self.hotList[indexPath.row];
    cell.model = model;
    
    return cell;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
#pragma mark -addNavBar
-(void)addNavBar
{
    //自定义导航栏
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
    barView.backgroundColor = [UIColor colorWithRed:113/255.0 green:168/255.0 blue:112/225.0 alpha:0];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(8, 25, 25, 25);
    [backButton setImage:[UIImage imageNamed:@"iconfont-fanhui"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popToView) forControlEvents:UIControlEventTouchUpInside];
    
    self.navTilte = [[UILabel alloc]initWithFrame:CGRectMake(50, 25, ScreenW -100, 25)];
    self.navTilte.textColor = [UIColor whiteColor];
    
    self.barView = barView;
    [barView addSubview:backButton];
    [barView addSubview:self.navTilte];
    [self.view addSubview:barView];
}
-(void)popToView
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -scrollView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //更改自定义导航栏的透明度
    CGFloat alpha = scrollView.contentOffset.y / 200;
    self.barView.backgroundColor = [UIColor colorWithRed:113/255.0 green:168/255.0 blue:112/225.0 alpha:alpha];
    if (alpha >= 1.f) {
        self.navTilte.text = self.headerModel.imgTitle;
    }else if(alpha < 1)
    {
        self.navTilte.text = @"";
    }
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
