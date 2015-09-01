//
//  NewsViewController.h
//  LiangSengHeng
//
//  Created by iSomZEE on 9/20/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadDataNews.h"
#import "MBProgressHUD.h"
@interface NewsViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,LoadDataNewsDelegate>
{
    MBProgressHUD *HUD;
}
@property (strong, nonatomic) IBOutlet UIView *viewTable;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *newsDataArray;
@property (retain, nonatomic) NSMutableData *responseData;
@end
