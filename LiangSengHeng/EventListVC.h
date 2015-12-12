//
//  EventListVC.h
//  LiangSengHeng
//
//  Created by GLIVE on 7/17/2558 BE.
//  Copyright (c) 2558 iSomZEE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadDataEvent.h"
#import "MBProgressHUD.h"

@interface EventListVC : UIViewController<UITableViewDataSource, UITableViewDelegate, LoadDataEventDelegate, MBProgressHUDDelegate>

@property (strong, nonatomic) IBOutlet UIView *viewTable;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *noList;
@property (strong, nonatomic) NSMutableArray *newsDataArray;
@property (strong, nonatomic) NSDate *dateSelect;

@end
