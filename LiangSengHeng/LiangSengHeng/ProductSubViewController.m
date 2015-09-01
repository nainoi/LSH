//
//  ProductSubViewController.m
//  LiangSengHeng
//
//  Created by iSomZEE on 10/21/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//
#define IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define IS_IPHONE4 ([[UIScreen mainScreen] bounds].size.height == 480)
#import "AsyncImageView.h"
#import "ProductSubViewController.h"
#import "LoadDataProduct.h"
#import "CollectionProductViewCell.h"
#import "Connect.h"
#import "PrductDetailViewController.h"
#import "Product.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AFNetworking.h"

@interface ProductSubViewController ()

@end

@implementation ProductSubViewController

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
    
    self.str_product_data = [NSString stringWithFormat:@"productData_%@",self.str_cat_id];
    
    NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
    
    self.productDataArray = [data objectForKey:self.str_product_data];
    
    
    [_imageProduct sd_setImageWithURL:[NSURL URLWithString:_product.imageUrl] placeholderImage:[UIImage imageNamed:@"tb_1280561141.jpg"]];
    self.lblProduct.text = _product.productName;
    self.detailTV.text = _product.productDetail;
//    if (self.productDataArray.count > 0)
//    {
//        NSDictionary *tmpDict = [self.productDataArray objectAtIndex:0];
//        NSString * strImage = [tmpDict objectForKey:@"image_filename_tb"];
//        NSString * strProductName = [tmpDict objectForKey:@"product_name"];
//        NSURL * urlImage = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",pathImage_web,strImage]];
//        self.imageProduct.imageURL = urlImage;
//        self.lblProduct.text = strProductName;
//    }

    
    
    [self loadData];
    
    
//    NSLog(@"================%@",self.str_cat_id);
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
    NSString * strImage = [tmpDict objectForKey:@"ImgName"];
    NSURL * urlImage = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_PATH,strImage]];

    [cell.productImage sd_setImageWithURL:urlImage placeholderImage:[UIImage imageNamed:@"tb_1280561141.jpg"]];
    
    return cell;
    
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake(150, 150);
//}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    @try {
        //[self performSegueWithIdentifier:@"push_to_product_detail" sender:indexPath];
        NSDictionary *tmpDict = [self.productDataArray objectAtIndex:indexPath.row];
        NSString * strImage = [tmpDict objectForKey:@"ImgName"];
        NSURL * urlImage = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_PATH,strImage]];
        [_imageProduct sd_setImageWithURL:urlImage placeholderImage:[UIImage imageNamed:@"tb_1280561141.jpg"]];
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
        
        if ([[segue identifier] isEqualToString:@"push_to_product_detail"]) {
            NSArray *arrayOfIndexPaths = [self.collectionView indexPathsForSelectedItems];
            NSIndexPath *indexPathImInterestedIn = [arrayOfIndexPaths firstObject];
            NSLog(@"%ld",(long)indexPathImInterestedIn.row);
            
            PrductDetailViewController *detailController = [segue destinationViewController];
            detailController.productDataDic = [self.productDataArray objectAtIndex:indexPathImInterestedIn.row];
        }
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
    NSString *url = [MAIN_URL stringByAppendingString:PRODUCT_DETAIL];
    NSDictionary *parameters = @{@"productID": _product.productID};
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id response){
        NSLog(@"JSON: %@", response);
        self.productDataArray = [NSMutableArray arrayWithArray:[response objectForKey:@"album"]];
        [HUD removeFromSuperview];
        HUD = nil;
        [_collectionView reloadData];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"Error: %@", error);
        [HUD removeFromSuperview];
        HUD = nil;
    }];

    
//    LoadDataProduct *loadData = [[LoadDataProduct alloc] init];
//    loadData.delegate = self;
//    //[loadData loadFormDataWithUserID:self.userId];
//    
//    [loadData loadFormData:self.str_cat_name];
    
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

    NSMutableArray * objArray = [NSMutableArray array];
    for (NSDictionary * dicArray in formDataArray) {
        if ([self.str_cat_id isEqualToString:[dicArray objectForKey:@"cate_id"]]) {
            [objArray addObject:dicArray];
        }
    }
    if (objArray.count > 0) {
        self.productDataArray = nil;
    }
    
    self.productDataArray = objArray;
    
    NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
    [data setObject:objArray forKey:self.str_product_data];
    [data synchronize];
    
    [self.collectionView reloadData];
    
    self.imageProduct.image = [UIImage imageNamed:@"tb_1280561141.jpg"];
    self.lblProduct.text = @"";
    if (self.productDataArray.count > 0)
    {
        NSDictionary *tmpDict = [self.productDataArray objectAtIndex:0];
        NSString * strImage = [tmpDict objectForKey:@"image_filename_tb"];
        NSString * strProductName = [tmpDict objectForKey:@"product_name"];
        NSURL * urlImage = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",pathImage_web,strImage]];
        self.imageProduct.imageURL = urlImage;
        self.lblProduct.text = strProductName;
    }
    
    
    for( int i = 0; i < self.productDataArray.count; i++ ) {
        
        NSDictionary *tmpDict = [self.productDataArray objectAtIndex:i];
        NSString * strImage = [tmpDict objectForKey:@"image_filename_tb"];
        NSURL * urlImage = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",pathImage_web,strImage]];
        
        UIButton* btnImage = [[UIButton alloc] init];
        btnImage.frame = CGRectMake((130 * i)+(5*i), 12, 130, 130);
        [btnImage setTag:i];
        [btnImage addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"tb_1280561141.jpg"];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        imageView.frame = CGRectMake((130 * i)+(5*i), 12, 130, 130);
        imageView.imageURL = urlImage;
        
        NSLog(@"%@",NSStringFromCGRect(imageView.frame));
        
//        [self.scrollView addSubview:imageView];
//        [self.scrollView addSubview:btnImage];
    }
//    self.scrollView.delegate = self;
//    [self.scrollView setScrollEnabled:YES];
    
    //[self.scrollView setContentSize:CGSizeMake((self.productDataArray.count * 130)+(5*self.productDataArray.count), 153)];
    
}

-(void)buttonClicked:(id)sender
{
    UIButton * btnSender = (UIButton *)sender;
//    self.selectedImage = [_images objectAtIndex(UIButton *)sender.tag];
    
    self.imageProduct.image = [UIImage imageNamed:@"tb_1280561141.jpg"];
    NSDictionary *tmpDict = [self.productDataArray objectAtIndex:btnSender.tag];
    NSString * strImage = [tmpDict objectForKey:@"image_filename_tb"];
    NSString * strProductName = [tmpDict objectForKey:@"product_name"];
    NSURL * urlImage = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",pathImage_web,strImage]];
    self.imageProduct.imageURL = urlImage;
    self.lblProduct.text = strProductName;
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	HUD = nil;
}

- (IBAction)btn_back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
@end
