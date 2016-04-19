//
//  ReadViewController.m
//  MNTeaNews
//
//  Created by qingyun on 16/3/10.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "ReadViewController.h"
#import "Header.h"
#import "ReadTableViewCell.h"
#import "OtherWeb.h"

#define RequestUrl  @"http://c.3g.163.com/recommend/getSubDocPic?from=yuedu&size=20&passport=&devId=5v66QtbVw9pF74Bzerg42w%3D%3D&lat=zmSkTNOnBWAcdSP1KPvWxw%3D%3D&lon=YVSodL4di%2FG85shoG1XhcA%3D%3D&version=6.1&net=wifi&ts=1460624718&sign=4pGDPJBjgBE3IHHDboMxkBF5mR0YI6W%2FMRpNRkMTWkV48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=netease_gw"
@interface ReadViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *requestArray;
@property (nonatomic,strong) ReadCellContent *readModel;
@property (nonatomic,strong) MainTableView *readTableView;
@end
static NSString *identifier = @"read";
@implementation ReadViewController
-(NSMutableArray *)requestArray
{
    if (_requestArray == nil) {
        _requestArray = [NSMutableArray array];
    }
    return _requestArray;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIImage *image = [UIImage imageNamed:@"iconfont-guanzhu@2x"];
        UIImage *imageS = [UIImage imageNamed:@"iconfont-guanzhuSelected@2x"];
        UITabBarItem *readTabBar = [[UITabBarItem alloc]initWithTitle:@"阅读" image:image tag:102];
        
        self.tabBarItem = readTabBar;
        readTabBar.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        readTabBar.selectedImage = [imageS imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0 green:84/255.0 blue:107/225.0 alpha:1];
    [self addTableView];
    [self requestNetworking];
}
-(void)addTableView
{
    MainTableView *readTableView = [[MainTableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    readTableView.delegate = self;
    readTableView.dataSource = self;
    readTableView.rowHeight = 160;
    self.readTableView = readTableView;
    readTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:readTableView];
    
    [readTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ReadTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];
}
-(void)requestNetworking
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    [manger GET:RequestUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = responseObject;
        NSArray *array = dict[@"推荐"];
        
        NSMutableArray *muArray = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            ReadCellContent *cellModel = [[ReadCellContent alloc]initWithDictionary:dict];
            [muArray addObject:cellModel];
        }
        [self.requestArray addObjectsFromArray:muArray];
        [self.readTableView reloadData];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark -UITableViewDataSource,UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.requestArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    ReadCellContent *model = self.requestArray[indexPath.row];
    cell.model = model;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OtherWeb *readWeb = [board instantiateViewControllerWithIdentifier:@"other"];
    
    ReadCellContent *model = self.requestArray[indexPath.row];
    readWeb.cellID = model.ID;
    readWeb.cellURL = model.cellURL;
    
    [self.navigationController pushViewController:readWeb animated:YES];
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
