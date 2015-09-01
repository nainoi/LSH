//
//  LoadDataProduct.h
//  LiangSengHeng
//
//  Created by iSomZEE on 9/28/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol LoadDataProduct_organizeDelegate
- (void) loadFormDataFailed_organize;
- (void) loadFormDataDidFinish_organize:(NSArray *)formDataArray;
@end
@interface LoadDataProduct_organize : NSObject
{
    NSMutableData *responseData;
}

@property (weak, nonatomic) id <LoadDataProduct_organizeDelegate> delegate;

- (void) loadFormData;

@property (retain, nonatomic) NSDictionary *dict;
@property (retain, nonatomic) NSMutableArray *myObject;
@end
