//
//  EventListVC.m
//  LiangSengHeng
//
//  Created by GLIVE on 7/17/2558 BE.
//  Copyright (c) 2558 iSomZEE. All rights reserved.
//

#import "EventListVC.h"
#import "AsyncImageView.h"
#import "TableNewsViewCell.h"
#import "Connect.h"
#import "NewsDetailViewController.h"
#import "AFNetworking.h"

@interface EventListVC (){
    MBProgressHUD *HUD;
}

@end

@implementation EventListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
//    self.newsDataArray = [data objectForKey:@"eventData"];
    self.newsDataArray = [[NSMutableArray alloc] init];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    @try {
        if ([[segue identifier] isEqualToString:@"push_to_event_detail"]) {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            NewsDetailViewController *detailController = [segue destinationViewController];
            detailController.newsItem = [self.newsDataArray objectAtIndex:indexPath.row];
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
    News *tmpNews = [self.newsDataArray objectAtIndex:indexPath.row];
    
    NSString * strDescription = tmpNews.newsTitle;
    NSURL * urlImage = [NSURL URLWithString:tmpNews.imageUrl];
    cell.imgView.imageURL = urlImage;
    cell.txtView.text= strDescription;
    //    cell.lbBuy.text=[[self.goldDataArray objectAtIndex:indexPath.row] objectForKey:@"bid"];
    //    cell.lbSell.text=[[self.goldDataArray objectAtIndex:indexPath.row] objectForKey:@"ask"];
    //    cell.lbDifferent.text=[[self.goldDataArray objectAtIndex:indexPath.row] objectForKey:@"diff"];
    
    return cell;
    
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
    
    NSLog(@"select date %@",_dateSelect);
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@""];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *url = [MAIN_URL stringByAppendingString:EVENT_LIST];
    NSDictionary *parameters = @{@"date": @"bar"};
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id response){
        NSLog(@"NEWS: %@", response);
        [_newsDataArray removeAllObjects];
        for (NSDictionary *dict in response) {
            News *obj = [[News alloc] initWithDictionary:dict];
            [self.newsDataArray addObject:obj];
        }
        [HUD removeFromSuperview];
        HUD = nil;
        [_tableView reloadData];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"Error: %@", error);
        [HUD removeFromSuperview];
        HUD = nil;
    }];

    
    /*LoadDataEvent *loadData = [[LoadDataEvent alloc] init];
    loadData.delegate = self;
    //[loadData loadFormDataWithUserID:self.userId];
    
    [loadData loadFormData];*/
    
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
    
    //self.newsDataArray = formDataArray;
    
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    HUD = nil;
}

@end
