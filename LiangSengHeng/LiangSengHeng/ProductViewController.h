//
//  ProductViewController.h
//  LiangSengHeng
//
//  Created by iSomZEE on 9/20/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadDataProduct.h"
#import "MBProgressHUD.h"
@interface ProductViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,MBProgressHUDDelegate,LoadDataProductDelegate>
{
    MBProgressHUD *HUD;
}
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIView *viewTable;
@property (strong, nonatomic) NSMutableArray *productDataArray;
@property (retain, nonatomic) NSMutableData *responseData;
@end
