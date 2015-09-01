//
//  GoldPriceViewController.m
//  LiangSengHeng
//
//  Created by iSomZEE on 9/20/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//
#define IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define IS_IPHONE4 ([[UIScreen mainScreen] bounds].size.height == 480)
#import "GoldPriceViewController.h"
#import "LoadDataGoldPrice.h"
#import "LoadDataProduct_965.h"
#import "LoadDataProduct_organize.h"
#import "TableGoldViewCell.h"
#import "AFNetworking.h"
#import "Connect.h"

@interface GoldPriceViewController ()

@end

@implementation GoldPriceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    
    if (IS_IPHONE4) {
        self.viewTable.frame = CGRectMake(self.viewTable.frame.origin.x,
                                          self.viewTable.frame.origin.y,
                                          self.viewTable.frame.size.width,
                                          self.viewTable.frame.size.height - 85);
    }
    
    self.goldDataArray = [NSArray array];
    self.goldDataArray_965 = [NSArray array];
    self.goldDataArray_organize = [NSArray array];

    
    NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
    
    if ([data objectForKey:@"goldData"]) {
        self.goldDataArray = [data objectForKey:@"goldData"];
    }
    if ([data objectForKey:@"goldData_965"]) {
        self.goldDataArray_965 = [data objectForKey:@"goldData_965"];
        self.goldDataArray_965 = [data objectForKey:@"goldData_organize"];
        NSString * strBuy = [[self.goldDataArray_965 objectAtIndex:0] objectForKey:@"ask"];
        NSString * sttSale = [[self.goldDataArray_965 objectAtIndex:0] objectForKey:@"bid"];
        self.lbl_buy_1.text = strBuy;
        self.lbl_sale_1.text = sttSale;
        
        NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
        [dateformate setDateFormat:@"dd/MM/yyyy"]; // Date formater
        [dateformate setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"]];
        NSString *date = [dateformate stringFromDate:[NSDate date]]; // Convert date to string
        NSLog(@"date :%@",date);
        
        self.dateNow_1.text = date;
    }
    if ([data objectForKey:@"goldData_organize"]) {
        self.goldDataArray_organize = [data objectForKey:@"goldData_organize"];
        NSString * strBuy = [[self.goldDataArray_organize objectAtIndex:0] objectForKey:@"ask"];
        NSString * sttSale = [[self.goldDataArray_organize objectAtIndex:0] objectForKey:@"bid"];
        self.lbl_buy_2.text = strBuy;
        self.lbl_sale_2.text = sttSale;
        
        NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
        [dateformate setDateFormat:@"dd/MM/yyyy"]; // Date formater
        [dateformate setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"]];
        NSString *date = [dateformate stringFromDate:[NSDate date]]; // Convert date to string
        NSLog(@"date :%@",date);
        
        self.dateNow_2.text = date;
    }
    
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading..";
    [HUD show:YES];
    
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.1];
    [self performSelector:@selector(loadPriceData) withObject:nil afterDelay:0.1];
    //[self performSelector:@selector(loadData_965) withObject:nil afterDelay:0.2];
    //[self performSelector:@selector(loadData_organize) withObject:nil afterDelay:0.3];

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goldDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tableView = tableView;
    
    static NSString *CellIdentifier = @"GoldCell";
    TableGoldViewCell *cell = (TableGoldViewCell *) [tableView dequeueReusableCellWithIdentifier : CellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GoldCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.lbTime.text = @"Loading…";
    }
    
    
//    NSString * strName = [[self.goldDataArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    NSString * strBuy = [[self.goldDataArray objectAtIndex:indexPath.row] objectForKey:@"bid"];
    NSString * strSell = [[self.goldDataArray objectAtIndex:indexPath.row] objectForKey:@"ask"];
    NSString * strDifferent = [[self.goldDataArray objectAtIndex:indexPath.row] objectForKey:@"diff"];
    NSString * strTime = [[self.goldDataArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.lbTime.text=strTime;
    cell.lbBuy.text=strBuy;
    cell.lbSell.text=strSell;
    cell.lbDifferent.text=strDifferent;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void)loadPriceData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *url = [MAIN_URL stringByAppendingString:PRICE_TODAY];
    //NSDictionary *parameters = @{@"foo": @"bar"};
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id response){
        NSLog(@"NEWS: %@", response);
        if ([response isKindOfClass:[NSArray class]]) {
            NSArray *data = [NSArray arrayWithArray:response];
            if (data.count > 0) {
                self.lbl_buy_1.text = [data[0] objectForKey:@"prices1_lblBLBuy"] ;
                self.lbl_sale_1.text = [data[0] objectForKey:@"prices1_lblBLSell"];
                self.lbl_buy_2.text = [data[0] objectForKey:@"prices1_lblOMBuy"];
                self.lbl_sale_2.text = [data[0] objectForKey:@"prices1_lblOMSell"];
            }
            
            NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
            [dateformate setDateFormat:@"dd/MM/yyyy"]; // Date formater
            [dateformate setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"]];
            NSString *date = [dateformate stringFromDate:[NSDate date]]; // Convert date to string
            NSLog(@"date :%@",date);
            
            self.dateNow_1.text = date;
            self.dateNow_2.text = date;
        }
        [HUD removeFromSuperview];
        HUD = nil;
        [_tableView reloadData];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"Error: %@", error);
        [HUD removeFromSuperview];
        HUD = nil;
    }];

}

-(void) loadData{
    
    LoadDataGoldPrice *loadData = [[LoadDataGoldPrice alloc] init];
    loadData.delegate = self;
    [loadData loadFormData];
    
}
-(void) loadData_965{
    
    LoadDataProduct_965 *loadData = [[LoadDataProduct_965 alloc] init];
    loadData.delegate = self;
    [loadData loadFormData];
    
}
-(void) loadData_organize{
    
    LoadDataProduct_organize *loadData = [[LoadDataProduct_organize alloc] init];
    loadData.delegate = self;
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
-(void) loadFormDataFailed_965{
    [HUD setHidden:YES];
    UIAlertView *alertError = [[UIAlertView alloc] initWithTitle:@"Info"
                                                         message:@"Cannot load data."
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
    [alertError setTag:1];
    [alertError show];
}
-(void) loadFormDataFailed_organize{
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
    [data setObject:formDataArray forKey:@"goldData"];
    [data synchronize];

    self.goldDataArray = formDataArray;
    
    [self.tableView reloadData];
}
-(void) loadFormDataDidFinish_965:(NSArray *)formDataArray{
    //    [HUD setHidden:YES];
    [self hudWasHidden:HUD];
    NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
    [data setObject:formDataArray forKey:@"goldData_965"];
    [data synchronize];
    
    self.goldDataArray_965 = formDataArray;
    
    if (self.goldDataArray_965 != nil) {
        NSString * strBuy = [[self.goldDataArray_965 objectAtIndex:0] objectForKey:@"ask"];
        NSString * sttSale = [[self.goldDataArray_965 objectAtIndex:0] objectForKey:@"bid"];
        self.lbl_buy_1.text = strBuy;
        self.lbl_sale_1.text = sttSale;
        
        NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
        [dateformate setDateFormat:@"dd/MM/yyyy"]; // Date formater
        [dateformate setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"]];
        NSString *date = [dateformate stringFromDate:[NSDate date]]; // Convert date to string
        NSLog(@"date :%@",date);
        
        self.dateNow_1.text = date;

        
    }
    
 
}
-(void) loadFormDataDidFinish_organize:(NSArray *)formDataArray{
    //    [HUD setHidden:YES];
    [self hudWasHidden:HUD];
    NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
    [data setObject:formDataArray forKey:@"goldData_organize"];
    [data synchronize];
    
    self.goldDataArray_organize = formDataArray;
    
    if (self.goldDataArray_organize != nil) {
        NSString * strBuy = [[self.goldDataArray_organize objectAtIndex:0] objectForKey:@"ask"];
        NSString * sttSale = [[self.goldDataArray_organize objectAtIndex:0] objectForKey:@"bid"];
        self.lbl_buy_2.text = strBuy;
        self.lbl_sale_2.text = sttSale;
        
        NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
        [dateformate setDateFormat:@"dd/MM/yyyy"]; // Date formater
        [dateformate setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"]];
        NSString *date = [dateformate stringFromDate:[NSDate date]]; // Convert date to string
        NSLog(@"date :%@",date);
        
        self.dateNow_2.text = date;
        
        
    }
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	HUD = nil;
}

@end
