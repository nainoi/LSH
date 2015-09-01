//
//  LoadDataNews.h
//  LiangSengHeng
//
//  Created by iSomZEE on 9/25/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoadDataNewsDelegate
- (void) loadFormDataFailed;
- (void) loadFormDataDidFinish:(NSArray *)formDataArray;
@end

@interface LoadDataNews : NSObject
{
    NSMutableData *responseData;
}

@property (weak, nonatomic) id <LoadDataNewsDelegate> delegate;

- (void) loadFormData;

@property (retain, nonatomic) NSDictionary *dict;
@property (retain, nonatomic) NSMutableArray *myObject;

@end
