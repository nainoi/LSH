//
//  PrductDetailViewController.m
//  LiangSengHeng
//
//  Created by iSomZEE on 10/12/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//
#define IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define IS_IPHONE4 ([[UIScreen mainScreen] bounds].size.height == 480)
#import "PrductDetailViewController.h"
#import "AsyncImageView.h"
#import "Connect.h"

@interface PrductDetailViewController ()

@end

@implementation PrductDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
    NSString * strImage = [self.productDataDic objectForKey:@"image_filename"];
    NSURL * urlImage = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",pathImage_web,strImage]];
    self.imgView.imageURL = urlImage;
    
    
    self.lbl_name.text = [self.productDataDic objectForKey:@"name"];
    self.lbl_price.text = [self.productDataDic objectForKey:@"product_price"];
    self.lbl_weigth.text = [self.productDataDic objectForKey:@"product_weight"];
    self.txt_detail.text = [self.productDataDic objectForKey:@"description"];
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
