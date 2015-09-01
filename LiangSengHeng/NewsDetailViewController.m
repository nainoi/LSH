//
//  NewsDetailViewController.m
//  LiangSengHeng
//
//  Created by iSomZEE on 10/12/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//
#define IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define IS_IPHONE4 ([[UIScreen mainScreen] bounds].size.height == 480)
#import "NewsDetailViewController.h"
#import "Connect.h"
#import "AsyncImageView.h"
@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (IS_IPHONE4) {
        self.view_txt.frame = CGRectMake(self.view_txt.frame.origin.x,
                                          self.view_txt.frame.origin.y,
                                          self.view_txt.frame.size.width,
                                          self.view_txt.frame.size.height - 35);
    }else{
        self.view_txt.frame = CGRectMake(self.view_txt.frame.origin.x,
                                         self.view_txt.frame.origin.y,
                                         self.view_txt.frame.size.width,
                                         self.view_txt.frame.size.height + 50);
    }
}
- (void)viewDidLoad
{
    @try {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        NSURL * urlImage = [NSURL URLWithString:_newsItem.imageUrl];
        self.imgView.imageURL = urlImage;
        self.txt_detail.text = _newsItem.newsDetail;
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btn_back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
