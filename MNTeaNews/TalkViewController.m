//
//  TalkViewController.m
//  MNTeaNews
//
//  Created by qingyun on 16/3/10.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "TalkViewController.h"
#import  "Header.h"
#import "TalkTableViewCell.h"
#import "TalkCellContent.h"
#import "TalkCellController.h"

#define TalkUrl  @"http://c.3g.163.com/newstopic/list/expert/0-10.html"
@interface TalkViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong) NSArray *talkArray;
@property (nonatomic,strong) MainTableView *talkTableView;
@end

@implementation TalkViewController
static NSString *identifter = @"talkCell";
#if 0
-(NSArray *)talkArray
{
    if (_talkArray == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"talk" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *muArray = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            TalkCellContent *model = [[TalkCellContent alloc]initWithDictionary:dict];
            [muArray addObject:model];
        }
        _talkArray = muArray;
    }
    return _talkArray;
}
#endif
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIImage *image = [UIImage imageNamed:@"iconfont-tianjiataolun@2x"];
        UIImage *imageS = [UIImage imageNamed:@"iconfont-tianjiataolunSelected@2x"];
        UITabBarItem *talkTabBar = [[UITabBarItem alloc]init];
        talkTabBar.title = @"话题";
        
        talkTabBar.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        talkTabBar.selectedImage = [imageS imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem = talkTabBar;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:102/255.0 green:186/255.0 blue:156/225.0 alpha:1];
    [self resquestNetworking];
    [self addTableView];
}
-(void)addTableView
{
    MainTableView *talkTableView = [[MainTableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetMaxY(self.view.frame)) style:UITableViewStylePlain];
    [self.view addSubview:talkTableView];
    self.talkTableView = talkTableView;
    
    talkTableView.dataSource = self;
    talkTableView.delegate = self;
    talkTableView.estimatedRowHeight = 300;
    talkTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //添加手势
    UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(upRecognizer:)];
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(downRecognizer:)];
    upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    upSwipe.delegate = self;
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    downSwipe.delegate = self;
    [talkTableView addGestureRecognizer:upSwipe];
    [talkTableView addGestureRecognizer:downSwipe];
    
    //注册单元格
    [talkTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TalkTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifter];
}
//当向下滑动时，tabbar不隐藏
-(void)downRecognizer:(UISwipeGestureRecognizer *)recognizer
{
    [UIView animateWithDuration:10 animations:^{
        self.tabBarController.tabBar.hidden = NO;
    }];
}
-(void)upRecognizer:(UISwipeGestureRecognizer *)recognizer
{
    [UIView animateWithDuration:10 animations:^{
          self.tabBarController.tabBar.hidden = YES;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)resquestNetworking
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger GET:TalkUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error;
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        NSDictionary *data = rootDict[@"data"];
        NSArray *array = data[@"expertList"];
        
        NSMutableArray *muArray = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            TalkCellContent *talkModel = [[TalkCellContent alloc]initWithDictionary:dict];
            [muArray addObject:talkModel];
        }
        self.talkArray = muArray;
        if (self.talkArray != nil) {
            //刷新表视图
            [self.talkTableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self alertView];
    }];
}
-(void)alertView
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络请求失败,请检查网络设置" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([otherGestureRecognizer.view isKindOfClass:[MainTableView class]]) {
        return YES;
    }
    return NO;
}
#pragma mark -UITableViewDataSource,UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.talkArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TalkTableViewCell *talkCell = [tableView dequeueReusableCellWithIdentifier:identifter forIndexPath:indexPath];
    TalkCellContent *talkModel = self.talkArray[indexPath.row];
    talkCell.talkModel = talkModel;
    
    return talkCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TalkCellController *talkView = [board instantiateViewControllerWithIdentifier:@"talk"];
    
    TalkCellContent *talkModel = self.talkArray[indexPath.row];
    talkView.webUrl = talkModel.cellURL;
    
    [self.navigationController pushViewController:talkView animated:YES];
}
#if 0
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#endif
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
