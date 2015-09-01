//
//  AppDelegate.h
//  LiangSengHeng
//
//  Created by iSomZEE on 8/14/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataModel;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong, readonly) DataModel* dataModel;
@property (strong, nonatomic) UIWindow *window;

@end
