//
//  LoadDataAboutUs.h
//  LiangSengHeng
//
//  Created by iSomZEE on 9/21/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol LoadDataAboutUsDelegate
- (void) loadFormDataFailed;
- (void) loadFormDataDidFinish:(NSArray *) formDataArray;
@end

@interface LoadDataAboutUs : NSObject
{
    NSMutableData *responseData;
}

@property (weak, nonatomic) id <LoadDataAboutUsDelegate> delegate;

//-(void) loadFormDataWithUserID:(NSString*) userId;
-(void) loadFormData;

@property (retain, nonatomic) NSDictionary *dict;
@property (retain, nonatomic) NSMutableArray *myObject;


@end
