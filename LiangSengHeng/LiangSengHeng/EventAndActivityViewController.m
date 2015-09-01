//
//  EventAndActivityViewController.m
//  LiangSengHeng
//
//  Created by iSomZEE on 9/20/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//
#define IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define IS_IPHONE4 ([[UIScreen mainScreen] bounds].size.height == 480)
#import "EventAndActivityViewController.h"
#import "AsyncImageView.h"
#import "LoadDataEvent.h"
#import "TableNewsViewCell.h"
#import "Connect.h"
#import "NewsDetailViewController.h"
#import "EventListVC.h"

@interface EventAndActivityViewController (){
    NSDate *_dateSelected;
}

@end

@implementation EventAndActivityViewController

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
        self.viewTable.frame = CGRectMake(self.viewTable.frame.origin.x,
                                          self.viewTable.frame.origin.y,
                                          self.viewTable.frame.size.width,
                                          self.viewTable.frame.size.height - 85);
    }
    
    NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
    self.newsDataArray = [data objectForKey:@"eventData"];
    
    //[self loadData];
    
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
    // Generate random events sort by date using a dateformatter for the demonstration
    //[self createRandomEvents];
    
    _calendarMenuView.contentRatio = .75;
    _calendarManager.settings.weekDayFormat = JTCalendarWeekDayFormatSingle;
    _calendarManager.dateHelper.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"th_TH"];
    
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:[NSDate date]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    @try {
        if ([[segue identifier] isEqualToString:@"push_to_event_list"]) {
            //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            EventListVC *eventlistVC = [segue destinationViewController];
            eventlistVC.dateSelect = _dateSelected;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        
    }
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tableView = tableView;
    
    static NSString *CellIdentifier = @"EventCell";
    TableNewsViewCell *cell = (TableNewsViewCell *) [tableView dequeueReusableCellWithIdentifier : CellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EventCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.txtView.text = @"Loading…";
    }
    //  ex.
    //    {
    //        item_id: "3",
    //        item_name: "ทดสอบ News",
    //        item_image: "83382.jpg",
    //        item_date: "2014-12-09 03:00:00",
    //        item_description: "wwww",
    //        item_type: "news",
    //        item_status: "1"
    //    }
    NSDictionary *tmpDict = [self.newsDataArray objectAtIndex:indexPath.row];
    
    NSString * strDescription = [tmpDict objectForKey:@"item_description"];
    NSString * strImage = [tmpDict objectForKey:@"item_image"];
    NSURL * urlImage = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",pathImageNews,strImage]];
    cell.imgView.imageURL = urlImage;
    cell.txtView.text= strDescription;
    //    cell.lbBuy.text=[[self.goldDataArray objectAtIndex:indexPath.row] objectForKey:@"bid"];
    //    cell.lbSell.text=[[self.goldDataArray objectAtIndex:indexPath.row] objectForKey:@"ask"];
    //    cell.lbDifferent.text=[[self.goldDataArray objectAtIndex:indexPath.row] objectForKey:@"diff"];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try {
        [self performSegueWithIdentifier:@"push_to_event_detail" sender:indexPath];
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        
    }
}

-(void) loadData{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading..";
    [HUD show:YES];
    
    
    LoadDataEvent *loadData = [[LoadDataEvent alloc] init];
    loadData.delegate = self;
    //[loadData loadFormDataWithUserID:self.userId];
    
    [loadData loadFormData];
    
}

-(void) loadFormDataFailed{
    [HUD setHidden:YES];
    UIAlertView *alertError = [[UIAlertView alloc] initWithTitle:@"Info"
                                                         message:@"Cannot load data."
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
    [alertError setTag:1];
    [alertError show];
}
-(void) loadFormDataDidFinish:(NSArray *)formDataArray{
    //    [HUD setHidden:YES];
    [self hudWasHidden:HUD];
    NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
    [data setObject:formDataArray forKey:@"eventData"];
    [data synchronize];
    
    self.newsDataArray = formDataArray;
    
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	HUD = nil;
}


#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    dayView.hidden = NO;
    
    // Other month
    if([dayView isFromAnotherMonth]){
        dayView.hidden = YES;
    }
    // Today
    else if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor clearColor];
        dayView.circleView.layer.borderColor = [UIColor whiteColor].CGColor;
        dayView.circleView.layer.borderWidth = 1;
        //dayView.circleView.layer.cornerRadius = dayView.frame.size.width/2;
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor clearColor];
        dayView.circleView.layer.borderColor = [UIColor redColor].CGColor;
        dayView.circleView.layer.borderWidth = 1;
        //dayView.circleView.layer.cornerRadius = dayView.frame.size.width/2;
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    
//    if([self haveEventForDay:dayView.date]){
//        dayView.dotView.hidden = NO;
//    }
//    else{
//        dayView.dotView.hidden = YES;
//    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    _dateSelected = dayView.date;
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                    } completion:nil];
    
    
    // Load the previous or next page if touch a day from another month
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
    
    @try {
        [self performSegueWithIdentifier:@"push_to_event_list" sender:_dateSelected];
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        
    }

}

#pragma mark - Views customization

- (UIView *)calendarBuildMenuItemView:(JTCalendarManager *)calendar
{
    UILabel *label = [UILabel new];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"THFahkwang" size:24];
    label.textColor = [UIColor whiteColor];
    
    return label;
}

- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UILabel *)menuItemView date:(NSDate *)date
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"MMMM yyyy";
        
        dateFormatter.locale = _calendarManager.dateHelper.calendar.locale;
        dateFormatter.timeZone = _calendarManager.dateHelper.calendar.timeZone;
    }
    
    menuItemView.text = [dateFormatter stringFromDate:date];
}

- (UIView<JTCalendarWeekDay> *)calendarBuildWeekDayView:(JTCalendarManager *)calendar
{
    JTCalendarWeekDayView *view = [JTCalendarWeekDayView new];
    
    for(UILabel *label in view.dayViews){
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont fontWithName:@"THFahkwang" size:17];
    }
    
    return view;
}

- (UIView<JTCalendarDay> *)calendarBuildDayView:(JTCalendarManager *)calendar
{
    JTCalendarDayView *view = [JTCalendarDayView new];
    
    view.textLabel.font = [UIFont fontWithName:@"THFahkwang" size:15];
    
    view.circleRatio = .8;
    view.dotRatio = 1. / .9;
    
    return view;
}

#pragma mark - Fake data

// Used only to have a key for _eventsByDate
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}

/*- (BOOL)haveEventForDay:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
        return YES;
    }
    
    return NO;
    
}

- (void)createRandomEvents
{
    _eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!_eventsByDate[key]){
            _eventsByDate[key] = [NSMutableArray new];
        }
        
        [_eventsByDate[key] addObject:randomDate];
    }
}
*/


@end
