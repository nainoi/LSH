//
//  LoadDataGoldPrice.h
//  LiangSengHeng
//
//  Created by iSomZEE on 9/21/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol LoadDataGoldPriceDelegate
- (void) loadFormDataFailed;
- (void) loadFormDataDidFinish:(NSArray *)formDataArray;
@end

@interface LoadDataGoldPrice : NSObject
{
    NSMutableData *responseData;
}

@property (weak, nonatomic) id <LoadDataGoldPriceDelegate> delegate;

-(void) loadFormData;

@property (retain, nonatomic) NSDictionary *dict;
@property (retain, nonatomic) NSMutableArray *myObject;

@end
