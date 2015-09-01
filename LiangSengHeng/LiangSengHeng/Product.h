//
//  Product.h
//  LiangSengHeng
//
//  Created by GLIVE on 8/9/2558 BE.
//  Copyright (c) 2558 iSomZEE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property(nonatomic, strong) NSString *productName;
@property(nonatomic, strong) NSString *productID;
@property(nonatomic, strong) NSString *productImage;
@property(nonatomic, strong) NSString *productWeight;
@property(nonatomic, strong) NSString *productSize;
@property(nonatomic, strong) NSString *productRatio;
@property(nonatomic, strong) NSString *productDetail;
@property(nonatomic, strong) NSString *imageUrl;

-(id)initWithDictionary:(NSDictionary*)dict;

@end
