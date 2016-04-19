//
//  NewsWeb.m
//  MNTeaNews
//
//  Created by qingyun on 16/4/12.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "NewsWeb.h"
#import "Header.h"
#import "NewsArticleModel.h"

@interface NewsWeb ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,strong) AFHTTPSessionManager *manger;
@property (nonatomic,strong) NSDictionary *dict;
@property (nonatomic,strong) UIView *loadViews;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation NewsWeb
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
-(NSDictionary *)dict
{
    if (_dict == nil) {
        _dict = [[NSDictionary alloc]init];
    }
    return _dict;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView.delegate = self;
    [self addActivityIndicatorView];
    [self netWorking];
}
-(void)requset
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manger GET:self.webURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.data = responseObject;
        
        if (self.webURL != nil) {
            NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            NSString *str = [[NSString alloc]initWithData:self.data encoding:enc];
            [self.webView loadHTMLString:str baseURL:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"cell error ==%@",error);
    }];

}
-(void)netWorking
{
    self.manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self.manger GET:self.webURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *rootdict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (self.cellID !=nil) {
            self.dict = rootdict[self.cellID];
        }else
        {
            self.dict = rootdict[self.postid];
        }
        NewsArticleModel *model = [[NewsArticleModel alloc]initWithDictionary:self.dict];
        [self.webView loadHTMLString:model.body baseURL:[NSURL URLWithString:model.shareLink]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"cell error ==%@",error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
#pragma mark -UIWebViewDelegate
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"web error===%@",error);
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicatorView stopAnimating];
    [self.loadViews removeFromSuperview];
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    self.activityIndicatorView.hidesWhenStopped = NO;
    [self.activityIndicatorView startAnimating];
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
