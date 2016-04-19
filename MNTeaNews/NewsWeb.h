//
//  NewsWeb.h
//  MNTeaNews
//
//  Created by qingyun on 16/4/12.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsWeb : UIViewController
@property (nonatomic,strong) NSString *webURL;
@property (nonatomic,strong) NSString *article;
@property (nonatomic,strong) NSData *data;
@property (nonatomic,strong) NSString *cellID;
@property (nonatomic,strong) NSString *postid;
@end
