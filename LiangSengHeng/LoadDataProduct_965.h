//
//  LoadDataProduct_965.h
//  LiangSengHeng
//
//  Created by iSomZEE on 9/28/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol LoadDataProduct_965Delegate
- (void) loadFormDataFailed_965;
- (void) loadFormDataDidFinish_965:(NSArray *)formDataArray;
@end
@interface LoadDataProduct_965 : NSObject
{
    NSMutableData *responseData;
}

@property (weak, nonatomic) id <LoadDataProduct_965Delegate> delegate;

- (void) loadFormData;

@property (retain, nonatomic) NSDictionary *dict;
@property (retain, nonatomic) NSMutableArray *myObject;
@end
