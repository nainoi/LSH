//
//  ProductSubViewController.h
//  LiangSengHeng
//
//  Created by iSomZEE on 10/21/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadDataProduct.h"
#import "MBProgressHUD.h"

@class Product;

@interface ProductSubViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,MBProgressHUDDelegate,LoadDataProductDelegate>
{
    MBProgressHUD *HUD;
}
@property (strong, nonatomic) NSDictionary *productDataDic;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIView *viewTable;
@property (strong, nonatomic) NSArray *productDataArray;
@property (retain, nonatomic) NSMutableData *responseData;
@property (retain, nonatomic) NSString * str_cat_id;
@property (retain, nonatomic) NSString * str_cat_name;
@property (retain, nonatomic) NSString * str_product_data;
@property (strong, nonatomic) IBOutlet UIImageView *imageProduct;
@property (strong, nonatomic) IBOutlet UILabel *lblProduct;
@property (strong, nonatomic) IBOutlet UILabel *lblRatio;
@property (strong, nonatomic) IBOutlet UILabel *lblSize;
@property (strong, nonatomic) IBOutlet UILabel *lblWeight;
@property (strong, nonatomic) IBOutlet UITextView *detailTV;
@property (strong, nonatomic) Product *product;

- (IBAction)btn_back:(id)sender;

@end
