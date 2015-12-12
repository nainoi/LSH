//
//  PrductDetailViewController.h
//  LiangSengHeng
//
//  Created by iSomZEE on 10/12/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface PrductDetailViewController : UIViewController
@property (strong, nonatomic) NSDictionary *productDataDic;
- (IBAction)btn_back:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *lbl_name;
@property (strong, nonatomic) IBOutlet UILabel *lbl_price;
@property (strong, nonatomic) IBOutlet UILabel *lbl_weigth;

@property (strong, nonatomic) IBOutlet UITextView *txt_detail;
@property (strong, nonatomic) IBOutlet UIView *view_txt;

@property (strong, nonatomic) Product *product;

@end
