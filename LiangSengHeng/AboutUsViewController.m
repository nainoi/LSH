//
//  AboutUsViewController.m
//  LiangSengHeng
//
//  Created by iSomZEE on 9/20/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import "AboutUsViewController.h"
#import "DisplayMap.h"
@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

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
    _mapView.showsUserLocation = YES;
    
    NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
    self.aboutDataArray = [data objectForKey:@"aboutData"];
    NSString * str_lat = [[self.aboutDataArray objectAtIndex:0] objectForKey:@"about_lat"];
    NSString * str_long = [[self.aboutDataArray objectAtIndex:0] objectForKey:@"about_long"];
    self._lat = str_lat.floatValue;
    self._long = str_long.floatValue;
    
//    if (self.aboutDataArray != nil) {
//        [self setDataMap];
//    }else{
        [self loadData];
//    }
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btCall:(id)sender {
    NSString *phoneNumber = [[self.aboutDataArray objectAtIndex:0] objectForKey:@"about_phone"];
    NSString *phone =[phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *telString = [NSString stringWithFormat:@"tel:%@", phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
    NSLog(@"DIALNUMBER = %@",phone);
    
}

-(IBAction)btWeb:(id)sender{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.liangsengheng.net"]];
}

#pragma mark - Open the mail interface
- (IBAction)btMail:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"หัวข้อ?"];
        
        self.strMail = [[self.aboutDataArray objectAtIndex:0] objectForKey:@"about_email"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:self.strMail, nil];
        [mailer setToRecipients:toRecipients];
        
        //UIImage *myImage = [UIImage imageNamed:@"title.png"];
        // NSData *imageData = UIImagePNGRepresentation(myImage);
        //[mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"ormschool"];
        
        NSString *emailBody = @"ข้อความถึง LiangSengHeng ?";
        [mailer setMessageBody:emailBody isHTML:NO];
        
        // only for iPad
        // mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        
        [self presentViewController:mailer animated:YES completion:nil];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    
    
}


-(void)setDataMap{
    [_mapView setMapType:MKMapTypeStandard];
    [_mapView setZoomEnabled:YES];
    [_mapView setScrollEnabled:YES];
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = self._lat;
    region.center.longitude = self._long;
    region.span.longitudeDelta = 0.1f;
    region.span.latitudeDelta = 0.1f;
    [_mapView setRegion:region animated:YES];
    [_mapView setDelegate:self];
    //_name.text = topic;
    
    DisplayMap *ann = [[DisplayMap alloc] init];
    ann.title = @"";
    ann.subtitle = @"";
    ann.coordinate = region.center;
    [_mapView addAnnotation:ann];
}
///////////// Map delegate ///////////////////////
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    NSLog(@"MKAnnotation");
    
    
    MKPinAnnotationView *pinView = nil;
    if(annotation != _mapView.userLocation)
    {
        static NSString *defaultPinID = @"Name";
        pinView = (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil ) pinView = [[MKPinAnnotationView alloc]
                                          initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        
        pinView.pinColor = MKPinAnnotationColorRed;
        pinView.canShowCallout = YES;
        pinView.animatesDrop = YES;
        
    }
    else {
        [_mapView.userLocation setTitle:@"Current Location"];
    }
    return pinView;
}


#pragma mark - MFMailComposeController delegate


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Mail saved: you saved the email message in the Drafts folder");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
			break;
		default:
			NSLog(@"Mail not sent");
			break;
	}
    
	[self dismissViewControllerAnimated:YES completion:nil];
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

-(void) loadData{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading..";
    [HUD show:YES];
    LoadDataAboutUs *loadData = [[LoadDataAboutUs alloc] init];
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
-(void) loadFormDataDidFinish:(NSArray *)formDataArray{
//    [HUD setHidden:YES];
    [self hudWasHidden:HUD];
    NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
    [data setObject:formDataArray forKey:@"aboutData"];
    [data synchronize];

    self.aboutDataArray = [data objectForKey:@"aboutData"];
    if (self.aboutDataArray != nil) {
        NSString * str_lat = [[self.aboutDataArray objectAtIndex:0] objectForKey:@"about_lat"];
        NSString * str_long = [[self.aboutDataArray objectAtIndex:0] objectForKey:@"about_long"];
        self._lat = str_lat.floatValue;
        self._long = str_long.floatValue;
         self.strMail = [[self.aboutDataArray objectAtIndex:0] objectForKey:@"about_email"];
        [self setDataMap];
        
    }else{
    
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
