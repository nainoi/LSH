//
//  Service.m
//  LiangSengHeng
//
//  Created by GLIVE on 8/8/2558 BE.
//  Copyright (c) 2558 iSomZEE. All rights reserved.
//

#import "Service.h"
#import "AFNetworking.h"

#define MAIN_URL @"http://localhost:8888/gold/index.php/api/GoldAPI/"
#define PRODUCT_LIST @"listProduct"

@implementation Service

+(void)loadProductList{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [MAIN_URL stringByAppendingString:PRODUCT_LIST];
    NSDictionary *parameters = @{@"foo": @"bar"};
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
