//
//  LoadDataProduct.h
//  LiangSengHeng
//
//  Created by iSomZEE on 9/28/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol LoadDataProductDelegate
- (void) loadFormDataFailed;
- (void) loadFormDataDidFinish:(NSArray *)formDataArray;
@end
@interface LoadDataProduct : NSObject
{
    NSMutableData *responseData;
}

@property (weak, nonatomic) id <LoadDataProductDelegate> delegate;

- (void) loadFormData:(NSString *)pName;

@property (retain, nonatomic) NSDictionary *dict;
@property (retain, nonatomic) NSMutableArray *myObject;
@end
