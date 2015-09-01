//
//  LoadDataGoldPrice.m
//  LiangSengHeng
//
//  Created by iSomZEE on 9/21/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import "LoadDataGoldPrice.h"
#import "CJSONDeserializer.h"
#import "Connect.h"

@implementation LoadDataGoldPrice

-(void) loadFormData{
    
    
    responseData = [NSMutableData data];

    NSString *serverUrl = [NSString stringWithFormat:@"%@%@%@%@",http,BASE_URL,products,get_gold_price];

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
    [self.delegate loadFormDataFailed];
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
    
    [self.delegate loadFormDataDidFinish:formData];
    
}


@end



