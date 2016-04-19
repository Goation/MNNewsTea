//
//  OtherWeb.m
//  MNTeaNews
//
//  Created by qingyun on 16/4/14.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "OtherWeb.h"
#import "Header.h"
#import "NewsArticleModel.h"

@interface OtherWeb ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,strong) AFHTTPSessionManager *manger;
@property (nonatomic,strong) UIView *loadViews;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation OtherWeb
-(UIActivityIndicatorView *)activityIndicatorView
{
    if (_activityIndicatorView == nil) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicatorView.frame = CGRectMake(0, 0, 32, 32);
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    
    [self addActivityIndicatorView];
    [self requestNetwork];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//网络请求
-(void)requestNetwork
{
    self.manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self.manger GET:self.cellURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *rootdict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *dict = rootdict[self.cellID];
        
        if (self.cellURL != nil) {
            NewsArticleModel *model = [[NewsArticleModel alloc]initWithDictionary:dict];
            [self.webView loadHTMLString:model.body baseURL:[NSURL URLWithString:model.shareLink]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"request error=== %@",error);
    }];
}
//添加风火轮
-(void)addActivityIndicatorView
{
    self.loadViews = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.loadViews.backgroundColor = [UIColor whiteColor];
    self.loadViews.alpha = 0.8f;
    
    self.activityIndicatorView.center = self.view.center;
    [self.view addSubview:self.loadViews];
    [self.loadViews addSubview:self.activityIndicatorView];
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    self.activityIndicatorView.hidesWhenStopped = NO;
    [self.activityIndicatorView startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicatorView stopAnimating];
    [self.loadViews removeFromSuperview];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Web error===%@",error);
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
