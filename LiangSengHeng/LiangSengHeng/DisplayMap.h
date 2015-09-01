//
//  DisplayMap.h
//  VerenaShopping
//
//  Created by A-05 on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface DisplayMap : NSObject<MKAnnotation>{
    
    
    CLLocationCoordinate2D coordinate; 
    NSString *title; 
    NSString *subtitle;
    int id_map;
    UIImageView *imagePin;
    
}
@property (nonatomic, assign) CLLocationCoordinate2D coordinate; 
@property (nonatomic, copy) NSString *title; 
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, readwrite) int id_map;

@property (nonatomic, retain) UIImageView *imagePin;
@end
