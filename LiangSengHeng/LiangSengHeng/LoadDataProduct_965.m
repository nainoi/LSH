//
//  LoadDataProduct.m
//  LiangSengHeng
//
//  Created by iSomZEE on 9/28/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import "LoadDataProduct_965.h"
#import "CJSONDeserializer.h"
#import "Connect.h"
@implementation LoadDataProduct_965
-(void) loadFormData{
    
    
    responseData = [NSMutableData data];
    
    
    NSString *serverUrl = [NSString stringWithFormat:@"%@%@%@%@",http,BASE_URL,products,get_gold_price_965];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: serverUrl]];
    [request setHTTPMethod: @"GET"];
    //    [request setHTTPBody: myRequestData];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	//label.text = [NSString stringWithFormat:@"Connection failed: %@", [error description]];
    NSLog(@"Connection failed: %@", [error description]);
    [self.delegate loadFormDataFailed_965];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSError *theError = NULL;
    NSData *inputData = [NSData dataWithData:responseData];
    
    id json = [[CJSONDeserializer deserializer] deserialize:inputData error:&theError];
    
    NSLog(@"error: %@",[theError localizedDescription]);
    //    NSString* newStr = [[NSString alloc] initWithData:inputData  encoding:NSUTF8StringEncoding];
    NSMutableArray *formData = [NSMutableArray array];
    if ([json isKindOfClass:[NSArray class]]) {
        formData = [NSMutableArray arrayWithArray:json];
    }else{
        formData = [NSMutableArray arrayWithObject:json];
    }

    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:YES];
    [formData sortUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
    
    [self.delegate loadFormDataDidFinish_965:formData];
    
}

@end
