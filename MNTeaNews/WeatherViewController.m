//
//  WeatherViewController.m
//  MNTeaNews
//
//  Created by qingyun on 16/3/11.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "WeatherViewController.h"
#import "SelectCityViewController.h"
#import "Masonry.h"
#import "Header.h"

#define GetURL  @"https://api.heweather.com/x3/weather?cityid=CN101180101&key=cf96e3782c694911bbac47ae1feb8892"
@interface WeatherViewController ()
@property (strong, nonatomic) IBOutlet UIView *bgImageView;
@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet UIButton *api;
@property (weak, nonatomic) IBOutlet UILabel *sc;
@property (weak, nonatomic) IBOutlet UILabel *tmp;
@property (weak, nonatomic) IBOutlet UILabel *txt;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (nonatomic,strong)AFHTTPSessionManager *sessionManger;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (nonatomic,strong)NSArray *weatherArray;
@end

@implementation WeatherViewController
//考虑为什么要重写初始化方法
//-(instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super initWithCoder:aDecoder]) {
//    }
//    return self;
//}
//重写该方法，是为了进行网路监控
-(AFHTTPSessionManager *)sessionManger
{
    if (_sessionManger == nil) {
        _sessionManger = [AFHTTPSessionManager manager];
        
        //进行网络监控
        _sessionManger.reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        
        [_sessionManger.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        }];
    }
    //启动监控
    [_sessionManger.reachabilityManager startMonitoring];
    
    return _sessionManger;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cityId = [[NSUserDefaults standardUserDefaults]stringForKey:@"cityId"];
    if (!self.cityId) {
        //应用程序第一次运行时，默认城市是郑州
        [self addWeatherVeiw:@"101180101"];
    }else{
        [self addWeatherVeiw:self.cityId];
        self.city.text = [[NSUserDefaults standardUserDefaults]stringForKey:@"cityName"];
    }
}
- (IBAction)backButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//选择city
- (IBAction)selectButton:(UIButton *)sender {
    SelectCityViewController *selectView = [[SelectCityViewController alloc]init];
    [self.navigationController pushViewController:selectView animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationController.navigationBar.hidden = YES;
    [self preferredStatusBarStyle];
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.hidden = NO;
}
//修改状态栏颜色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)addWeatherVeiw:(NSString *)cityId
{
    //响应系列化，序列化成json格式
    self.sessionManger.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *requestURL = [NSString stringWithFormat:@"https://api.heweather.com/x3/weather?cityid=CN%@&&key=cf96e3782c694911bbac47ae1feb8892",cityId];
    //进行GET数据请求
    //parameters设置请求参数
    [self.sessionManger GET:requestURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //请求进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功所做的操作
        NSDictionary *dict = responseObject;
        NSArray *rootArray = [dict objectForKey:@"HeWeather data service 3.0"];
        NSDictionary *rootDic = [rootArray objectAtIndex:0];

        WeatherModel *weather = [[WeatherModel alloc]initWithDictionary:rootDic];
        WeatherNow *now = [[WeatherNow alloc]initWithDictionary:weather.now];
        
        NSString *sc = [NSString stringWithFormat:@"风力:%@",now.sc];
        //更新UI,回到主线程上更新
        dispatch_async(dispatch_get_main_queue(), ^{
            self.txt.text = now.txt;
            self.tmp.text = now.tmp;
            self.sc.text = sc;
            //self.suggestion.text = suggest.cbrf;
            self.city.text = weather.city;
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败所做的反应
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
-(void)loadCityInfo
{
    self.city.text = self.cityName;
    [self addWeatherVeiw:self.cityId];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
