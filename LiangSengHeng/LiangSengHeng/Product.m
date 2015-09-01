//
//  Product.m
//  LiangSengHeng
//
//  Created by GLIVE on 8/9/2558 BE.
//  Copyright (c) 2558 iSomZEE. All rights reserved.
//

#import "Product.h"
#import "Connect.h"

@implementation Product

-(id)initWithDictionary:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        self.productID = [dict objectForKey:@"ProductsID"];
        self.productImage = [dict objectForKey:@"ImgName"];
        self.productName = [dict objectForKey:@"ProductsName"];
        self.productRatio = [dict objectForKey:@"ratio"];
        self.productSize = [dict objectForKey:@"size"];
        self.productWeight = [dict objectForKey:@"weight"];
        self.productDetail = [dict objectForKey:@"Description"];
    }
    return self;
}

-(NSString *)imageUrl{
    NSString *url = [IMAGE_PATH stringByAppendingString:_productImage];
    return url;
}

@end
