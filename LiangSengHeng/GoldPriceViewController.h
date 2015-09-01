//
//  GoldPriceViewController.h
//  LiangSengHeng
//
//  Created by iSomZEE on 9/20/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadDataGoldPrice.h"
#import "LoadDataProduct_965.h"
#import "LoadDataProduct_organize.h"
#import "MBProgressHUD.h"


@interface GoldPriceViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,LoadDataGoldPriceDelegate,LoadDataProduct_965Delegate,LoadDataProduct_organizeDelegate>
{
    MBProgressHUD *HUD;
}
@property (strong, nonatomic) IBOutlet UILabel *dateNow_1;
@property (strong, nonatomic) IBOutlet UILabel *lbl_buy_1;
@property (strong, nonatomic) IBOutlet UILabel *lbl_sale_1;
@property (strong, nonatomic) IBOutlet UILabel *dateNow_2;
@property (strong, nonatomic) IBOutlet UILabel *lbl_buy_2;
@property (strong, nonatomic) IBOutlet UILabel *lbl_sale_2;


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *goldDataArray;
@property (strong, nonatomic) NSArray *goldDataArray_965;
@property (strong, nonatomic) NSArray *goldDataArray_organize;
@property (strong, nonatomic) IBOutlet UIView *viewTable;
@property (retain, nonatomic) NSMutableData *responseData;
@end
