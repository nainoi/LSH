//
//  News.m
//  LiangSengHeng
//
//  Created by GLIVE on 8/9/2558 BE.
//  Copyright (c) 2558 iSomZEE. All rights reserved.
//

#import "News.h"
#import "Connect.h"

@implementation News

-(id)initWithDictionary:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        self.newsID = [dict objectForKey:@"id"];
        self.newsDetail = [dict objectForKey:@"detail"];
        self.newsEnd = [dict objectForKey:@"end"];
        self.newsStart = [dict objectForKey:@"start"];
        self.newsTitle = [dict objectForKey:@"title"];
        self.newsImage = [dict objectForKey:@"img"];
    }
    return self;
}

-(NSString *)imageUrl{
    NSString *url = [IMAGE_PATH stringByAppendingString:_newsImage];
    return url;
}

@end
