//
//  HomeViewController.m
//  DDScrollViewController Example
//
//  Created by Hirat on 13-11-8.
//  Copyright (c) 2013年 Hirat. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (nonatomic, strong) NSMutableArray* viewControllerArray;
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    self.dataSource = self;
    
    [super viewDidLoad];
    
    UIImage *selectedImage0 = [UIImage imageNamed:@"gold-pn.png"];
    UIImage *unselectedImage0 = [UIImage imageNamed:@"gold-pn.png"];
    
    UIImage *selectedImage1 = [UIImage imageNamed:@"product-pn.png"];
    UIImage *unselectedImage1 = [UIImage imageNamed:@"product-pn.png"];
    
    UIImage *selectedImage2 = [UIImage imageNamed:@"event-pn.png"];
    UIImage *unselectedImage2 = [UIImage imageNamed:@"event-pn.png"];
    
    UIImage *selectedImage3 = [UIImage imageNamed:@"news-pn.png"];
    UIImage *unselectedImage3 = [UIImage imageNamed:@"news-pn.png"];
    
    UIImage *selectedImage4 = [UIImage imageNamed:@"about-pn.png"];
    UIImage *unselectedImage4 = [UIImage imageNamed:@"about-pn.png"];
    
    
    UITabBar *tabBar = self.tabBarController.tabBar;
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    UITabBarItem *item3 = [tabBar.items objectAtIndex:3];
    UITabBarItem *item4 = [tabBar.items objectAtIndex:4];
    
    tabBar.barTintColor = [UIColor whiteColor];
    
    //tabBar.backgroundImage = [UIImage imageNamed:@"tabbar-bg"];
    
    item0.title =@"Gold Price";
    item1.title =@"Product";
    item2.title =@"Event & Activity";
    item3.title =@"News";
    item4.title =@"About Us";
    
//    [item0 setFinishedSelectedImage:selectedImage0 withFinishedUnselectedImage:unselectedImage0];
//    [item1 setFinishedSelectedImage:selectedImage1 withFinishedUnselectedImage:unselectedImage1];
//    [item2 setFinishedSelectedImage:selectedImage2 withFinishedUnselectedImage:unselectedImage2];
//    [item3 setFinishedSelectedImage:selectedImage3 withFinishedUnselectedImage:unselectedImage3];
//    [item4 setFinishedSelectedImage:selectedImage4 withFinishedUnselectedImage:unselectedImage4];
    
    
    [item0 setImage:[unselectedImage0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item1 setImage:[unselectedImage1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item2 setImage:[unselectedImage2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item3 setImage:[unselectedImage3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item4 setImage:[unselectedImage4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
     [item0 setSelectedImage:[selectedImage0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item1 setSelectedImage:[selectedImage1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item2 setSelectedImage:[selectedImage2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item3 setSelectedImage:[selectedImage3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item4 setSelectedImage:[selectedImage4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [self.pageControl setNumberOfPages:2];
    [self.view addSubview:self.pageControl];
    self.pageControl.currentPage = 0;
}

- (void)awakeFromNib
{
    NSUInteger numberOfPages = 2;
    self.viewControllerArray = [[NSMutableArray alloc] initWithCapacity:numberOfPages];
    for (NSUInteger k = 0; k < numberOfPages; ++k)
    {
        [self.viewControllerArray addObject:[NSNull null]];
    }
    
    [self.viewControllerArray replaceObjectAtIndex: 0 withObject: [self.storyboard instantiateViewControllerWithIdentifier:@"sGold"]];
    [self.viewControllerArray replaceObjectAtIndex: 1 withObject: [self.storyboard instantiateViewControllerWithIdentifier:@"sGrap"]];
    
   
}

#pragma mark - DDScrollViewDataSource

- (NSUInteger)numberOfViewControllerInDDScrollView:(DDScrollViewController *)DDScrollView
{
    return [self.viewControllerArray count];
}

- (UIViewController*)ddScrollView:(DDScrollViewController *)ddScrollView contentViewControllerAtIndex:(NSUInteger)index
{
    if (index == 1) {
        self.pageControl.currentPage = 0;
    }else{
        self.pageControl.currentPage = 1;
    }
    
    return [self.viewControllerArray objectAtIndex:index];
}

@end
