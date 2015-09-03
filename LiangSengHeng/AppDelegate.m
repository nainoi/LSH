//
//  AppDelegate.m
//  LiangSengHeng
//
//  Created by iSomZEE on 8/14/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import "AppDelegate.h"
#import "AFHTTPRequestOperationManager.h"
#import "defs.h"
#import "DataModel.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
    
    _dataModel = [[DataModel alloc]init];
    
    // Let the device know we want to receive push notifications
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert )];
    }
    
//    UIDevice *device = [[UIDevice alloc] init];
//    if([device.systemVersion floatValue] >= 8.0)
//    {
//        //[[UIApplication sharedApplication] registerForRemoteNotifications];
//        UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
//        [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
//        [[UIApplication sharedApplication] registerForRemoteNotifications];
//        
//    }
//    else{
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeNone)];
//    }

    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    NSString* oldToken = [self.dataModel deviceToken];
    
    if (oldToken == nil)
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
        else
        {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert )];
        }
    }
    

}





- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Push notification

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"My token is: %@", deviceToken);
    // Start the GGLInstanceID shared instance with the default config and request a registration
    // token to enable reception of notifications
    /*[[GGLInstanceID sharedInstance] startWithConfig:[GGLInstanceIDConfig defaultConfig]];
    _registrationOptions = @{kGGLInstanceIDRegisterAPNSOption:deviceToken,
                             kGGLInstanceIDAPNSServerTypeSandboxOption:@NO};
    [[GGLInstanceID sharedInstance] tokenWithAuthorizedEntity:_gcmSenderID
                                                        scope:kGGLInstanceIDScopeGCM
                                                      options:_registrationOptions
                                                      handler:_registrationHandler];*/
    
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

- (void)onTokenRefresh {
    // A rotation of the registration tokens is happening, so the app needs to request a new token.
    NSLog(@"The GCM registration token needs to be changed.");
    /*[[GGLInstanceID sharedInstance] tokenWithAuthorizedEntity:_gcmSenderID
                                                        scope:kGGLInstanceIDScopeGCM
                                                      options:_registrationOptions
                                                      handler:_registrationHandler];*/
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"Notification received: %@", userInfo);
    // This works only if the app started the GCM service
    //[[GCMService sharedInstance] appDidReceiveMessage:userInfo];
    // Handle the received message
    /*[[NSNotificationCenter defaultCenter] postNotificationName:_messageKey
     object:nil
     userInfo:userInfo];*/
    
    //[self showNotification:userInfo[@"aps"][@"alert"]];
    //[self showAlarm:userInfo[@"aps"][@"alert"]];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))handler {
    NSLog(@"Notification received: %@", userInfo);
    // This works only if the app started the GCM service
    //[[GCMService sharedInstance] appDidReceiveMessage:userInfo];
    // Handle the received message
    // Invoke the completion handler passing the appropriate UIBackgroundFetchResult value
    // ...
    /*[[NSNotificationCenter defaultCenter] postNotificationName:_messageKey
     object:nil
     userInfo:userInfo];*/
    handler(UIBackgroundFetchResultNoData);
    
    //[self showNotification:userInfo[@"aps"][@"alert"]];
    //[self showAlarm:userInfo[@"aps"][@"alert"]];
    //[self showAlarm:@"xxxx"];
}

/*- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    //NSLog(@"My token is: %@", deviceToken);
    
    NSString* oldToken = [self.dataModel deviceToken];
    
    NSString* newToken = [deviceToken description];
    newToken = [newToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    newToken = [newToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [self.dataModel setDeviceToken:newToken];
    
    NSLog(@"My token is: %@", newToken);
    
    // case need update token to server
    if (![newToken isEqualToString:oldToken])
    {
        [self postJoinRequest:newToken];
    }
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

*/
- (void)postJoinRequest:(NSString *)pStr_newToken
{
    
    NSDictionary *params = @{@"cmd":@"join",
                             @"user_id":[self.dataModel userId],
                             @"token":[self.dataModel deviceToken]};
    
    AFHTTPRequestOperationManager *client = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@/api.php",ServerApiURL]);
    
    [client POST:[NSString stringWithFormat:@"%@/api.php",ServerApiURL] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}



- (void)postUpdateRequest:(NSString *)pStr_newToken
{
    
    NSDictionary *params = @{@"cmd":@"update",
                             @"user_id":[self.dataModel userId],
                             @"token":[self.dataModel deviceToken],
                             @"name":@"sombass",
                             @"code":@"isomzee_code"};
    
    AFHTTPRequestOperationManager *client = [AFHTTPRequestOperationManager manager];
    
    [client POST:[NSString stringWithFormat:@"%@/api.php",ServerApiURL] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
}



@end
