//
//  News.h
//  LiangSengHeng
//
//  Created by GLIVE on 8/9/2558 BE.
//  Copyright (c) 2558 iSomZEE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property(nonatomic, strong) NSString *newsID;
@property(nonatomic, strong) NSString *newsStart;
@property(nonatomic, strong) NSString *newsEnd;
@property(nonatomic, strong) NSString *newsTitle;
@property(nonatomic, strong) NSString *newsDetail;
@property(nonatomic, strong) NSString *newsImage;
@property(nonatomic, strong) NSString *imageUrl;

-(id)initWithDictionary:(NSDictionary*)dict;

@end
