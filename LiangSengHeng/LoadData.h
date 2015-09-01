//
//  LoadData.h
//  Invite
//
//  Created by iSomZEE on 2/16/14.
//  Copyright (c) 2014 iSomZEE Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol LoadDataDelegate
- (void) loadFormDataFailed;
- (void) loadFormDataDidFinish:(NSArray *) formDataArray;
- (void) saveFormDataDidFinish:(NSString *) strData;
@end

@interface LoadData : NSObject{
    NSMutableData *responseData;}

@property (weak, nonatomic) id <LoadDataDelegate> delegate;

//-(void) loadFormDataWithUserID:(NSString*) userId;
-(void) loadFormData;

@property (retain, nonatomic) NSDictionary *dict;
@property (retain, nonatomic) NSMutableArray *myObject;

@end

