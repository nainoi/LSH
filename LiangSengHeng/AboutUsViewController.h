//
//  AboutUsViewController.h
//  LiangSengHeng
//
//  Created by iSomZEE on 9/20/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MapKit/MapKit.h>
#import "LoadDataAboutUs.h"
#import "MBProgressHUD.h"
@interface AboutUsViewController : UIViewController
<MFMailComposeViewControllerDelegate,MKMapViewDelegate,CLLocationManagerDelegate,LoadDataAboutUsDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}
@property (strong, nonatomic) NSArray *aboutDataArray;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic,readwrite)float _lat,_long;
@property(nonatomic,strong)NSString *strMail;

- (IBAction)btCall:(id)sender;
- (IBAction)btMail:(id)sender;
- (IBAction)btWeb:(id)sender;

@end
