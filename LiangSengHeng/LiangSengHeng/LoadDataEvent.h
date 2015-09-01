//
//  LoadDataEvent.h
//  LiangSengHeng
//
//  Created by iSomZEE on 10/18/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol LoadDataEventDelegate
- (void) loadFormDataFailed;
- (void) loadFormDataDidFinish:(NSArray *)formDataArray;

@end
@interface LoadDataEvent : NSObject

{
    NSMutableData *responseData;
}

@property (weak, nonatomic) id <LoadDataEventDelegate> delegate;

- (void) loadFormData;

@property (retain, nonatomic) NSDictionary *dict;
@property (retain, nonatomic) NSMutableArray *myObject;

@end
