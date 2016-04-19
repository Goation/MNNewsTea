//
//  SelectCityViewController.m
//  MNTeaNews
//
//  Created by Apple on 16/3/13.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "SelectCityViewController.h"
#import "Header.h"
#import "WeatherViewController.h"

@interface SelectCityViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *cityArray;
@property (nonatomic,strong) void(^changeValue)(NSString *,NSString *);
@property (nonatomic,strong) NSString *cityId;
@property (nonatomic,strong) NSString *cityName;
@end

@implementation SelectCityViewController
-(NSArray *)cityArray
{
    if (_cityArray == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"City" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *muArray = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            [muArray addObject:dict];
        }
        _cityArray = muArray;
    }
    return _cityArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:102/255.0 green:186/255.0 blue:156/225.0 alpha:1];
    [self setNavBar];
    [self addTableVeiw];
}

-(void)setNavBar
{
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 18)];
    titleLable.text = @"选择城市";
    titleLable.textColor = [UIColor colorWithRed:43/255.0 green:42/255.0 blue:56/255.0 alpha:1];
    titleLable.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLable;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0,25, 25);
    [backButton setImage:[UIImage imageNamed:@"iconfont-fanhuih@2x"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backSuperView) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}
-(void)backSuperView
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)addTableVeiw
{
    MainTableView *tableVeiw = [[MainTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
    tableVeiw.delegate = self;
    tableVeiw.dataSource = self;
    
    [self.view addSubview:tableVeiw];
}
#pragma mark -UITableViewDataSource,UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cityArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary *dict = self.cityArray[indexPath.row];
    cell.textLabel.text = dict.allKeys[0];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.cityArray[indexPath.row];
    self.cityName = dict.allKeys[0];
    self.cityId = dict[self.cityName];
    [self showAlert];
}
#pragma mark -AlertController
//弹窗提示
-(void)showAlert
{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否选择当前城市" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //确定城市后选择城市
        [self selectCity];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:self.cityId forKey:@"cityId"];
        [defaults setValue:self.cityName forKey:@"cityName"];
        [defaults synchronize];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil];
    
    [alertView addAction:okAction];
    [alertView addAction:cancelAction];
    
    [self presentViewController:alertView animated:YES completion:nil];
}
-(void)selectCity
{
    //把当前选择的城市id,name传到WeatherViewController中
    WeatherViewController *weatherView = self.navigationController.viewControllers[1];
    weatherView.cityId = self.cityId;
    weatherView.cityName = self.cityName;
    [weatherView loadCityInfo];
    
    [self.navigationController popToViewController:weatherView animated:YES];
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
