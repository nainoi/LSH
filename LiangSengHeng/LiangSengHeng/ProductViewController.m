//
//  ProductViewController.m
//  LiangSengHeng
//
//  Created by iSomZEE on 9/20/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//
#define IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define IS_IPHONE4 ([[UIScreen mainScreen] bounds].size.height == 480)
#import "AsyncImageView.h"
#import "ProductViewController.h"
#import "LoadDataProduct.h"
#import "CollectionProductViewCell.h"
#import "Connect.h"
#import "AFNetworking.h"
#import "Product.h"

//#import "PrductDetailViewController.h"
#import "ProductSubViewController.h"
@interface ProductViewController ()

@end

@implementation ProductViewController

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
    

    self.productDataArray = [NSMutableArray array];
    
    
//    [dicArray5 setObject:@"5" forKey:@"cat_id"];
//    [dicArray5 setObject:@"ต่างหู" forKey:@"cat_name"];
//    [dicArray5 setObject:@"" forKey:@"cat_image"];
//    [self.productDataArray addObject:dicArray5];
//    
//    [dicArray7 setObject:@"7" forKey:@"cat_id"];
//    [dicArray7 setObject:@"ของขวัญ" forKey:@"cat_name"];
//    [dicArray7 setObject:@"tb_1278750764.jpg" forKey:@"cat_image"];
//    
//    [dicArray8 setObject:@"8" forKey:@"cat_id"];
//    [dicArray8 setObject:@"อื่นๆ" forKey:@"cat_name"];
//    [dicArray8 setObject:@"" forKey:@"cat_image"];
//    
//    [self.productDataArray addObject:dicArray8];
    
    
    NSLog(@"===%@",self.productDataArray);
    

//    self.productDataArray = [data objectForKey:@"productData"];
    
    [self loadProduct];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.productDataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.collectionView = collectionView;
    
    CollectionProductViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary *tmpDict = [self.productDataArray objectAtIndex:indexPath.row];
    Product *product = [[Product alloc]initWithDictionary:tmpDict];
    cell.product = product;
//    NSString * strImage = [tmpDict objectForKey:@"cat_image"];
//    cell.productImage.image = [UIImage imageNamed:strImage];
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(150, 120);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    @try {
        [self performSegueWithIdentifier:@"push_to_product_sub" sender:indexPath];
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    @try {
        
        if ([[segue identifier] isEqualToString:@"push_to_product_sub"]) {
            NSArray *arrayOfIndexPaths = [self.collectionView indexPathsForSelectedItems];
            NSIndexPath *indexPathImInterestedIn = [arrayOfIndexPaths firstObject];
            NSLog(@"%ld",(long)indexPathImInterestedIn.row);
            
            ProductSubViewController *detailController = [segue destinationViewController];
            NSDictionary *tmpDict = [self.productDataArray objectAtIndex:indexPathImInterestedIn.row];
            Product *product = [[Product alloc]initWithDictionary:tmpDict];
            detailController.product = product;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        
    }
}

-(void)loadProduct{
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
    NSString *url = [MAIN_URL stringByAppendingString:PRODUCT_LIST];
    //NSDictionary *parameters = @{@"foo": @"bar"};
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id response){
        NSLog(@"JSON: %@", response);
        self.productDataArray = [NSMutableArray arrayWithArray:response];
        [HUD removeFromSuperview];
        HUD = nil;
        [_collectionView reloadData];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"Error: %@", error);
        [HUD removeFromSuperview];
        HUD = nil;
    }];

}

-(void) loadData{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading..";
    [HUD show:YES];
    
    
    LoadDataProduct *loadData = [[LoadDataProduct alloc] init];
    loadData.delegate = self;
    //[loadData loadFormDataWithUserID:self.userId];
    
    [loadData loadFormData:nil];
    
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
    [data setObject:formDataArray forKey:@"productData"];
    [data synchronize];
    
//    self.productDataArray = formDataArray;
    
    [self.collectionView reloadData];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	HUD = nil;
}

@end
