//
//  EventAndActivityViewController.h
//  LiangSengHeng
//
//  Created by iSomZEE on 9/20/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadDataEvent.h"
#import "MBProgressHUD.h"
#import <JTCalendar/JTCalendar.h>

@interface EventAndActivityViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,LoadDataEventDelegate, JTCalendarDelegate>
{
    MBProgressHUD *HUD;
}
@property (strong, nonatomic) IBOutlet UIView *viewTable;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *newsDataArray;
@property (retain, nonatomic) NSMutableData *responseData;

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@end
