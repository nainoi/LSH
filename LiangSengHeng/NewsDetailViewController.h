//
//  NewsDetailViewController.h
//  LiangSengHeng
//
//  Created by iSomZEE on 10/12/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"

@interface NewsDetailViewController : UIViewController
@property (strong, nonatomic) NSDictionary *newsDataDic;

- (IBAction)btn_back:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UITextView *txt_detail;
@property (strong, nonatomic) IBOutlet UIView *view_txt;

@property (strong, nonatomic) News *newsItem;

@end
