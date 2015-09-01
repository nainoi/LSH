//
//  NewsViewController.m
//  LiangSengHeng
//
//  Created by iSomZEE on 9/20/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//
#define IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define IS_IPHONE4 ([[UIScreen mainScreen] bounds].size.height == 480)

#import "AsyncImageView.h"
#import "NewsViewController.h"
#import "LoadDataNews.h"
#import "TableNewsViewCell.h"
#import "Connect.h"
#import "NewsDetailViewController.h"
#import "AFNetworking.h"
#import "News.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NewsViewController ()

@end

@implementation NewsViewController

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
    
    //NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
    //self.newsDataArray = [data objectForKey:@"newsData"];
    self.newsDataArray = [[NSMutableArray alloc] init];
    [self loadData];
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
        if ([[segue identifier] isEqualToString:@"push_to_news_detail"]) {
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
    
    static NSString *CellIdentifier = @"NewsCell";
    TableNewsViewCell *cell = (TableNewsViewCell *) [tableView dequeueReusableCellWithIdentifier : CellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil];
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
    News *new = [self.newsDataArray objectAtIndex:indexPath.row];
    
    NSString * strDescription = new.newsTitle;
    NSURL * urlImage = [NSURL URLWithString:new.imageUrl];
    [cell.imgView sd_setImageWithURL:urlImage placeholderImage:[UIImage imageNamed:@"tb_1280561141.jpg"]];
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
        [self performSegueWithIdentifier:@"push_to_news_detail" sender:indexPath];

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
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *url = [MAIN_URL stringByAppendingString:NEW_LIST];
    //NSDictionary *parameters = @{@"foo": @"bar"};
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id response){
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

    
    /*LoadDataNews *loadData = [[LoadDataNews alloc] init];
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
    [data setObject:formDataArray forKey:@"newsData"];
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
