//
//  LoadData.m
//  Invite
//
//  Created by iSomZEE on 2/16/14.
//  Copyright (c) 2014 iSomZEE Inc. All rights reserved.
//

#import "LoadData.h"
#import "CJSONDeserializer.h"
#import "Connect.h"

@implementation LoadData

//-(void) loadFormDataWithUserID:(NSString*) userId{
-(void) loadFormData{

    
    responseData = [NSMutableData data];
    
//    NSString *myRequestString = [NSString stringWithFormat:@"&userid=%@",userId];
//    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
      NSString *serverUrl = [NSString stringWithFormat:@"%@%@%@",http,BASE_URL,products];
    //  NSString *serverUrl = [NSString stringWithFormat:@"http://103.13.30.153/~invite/test/place/categories?inajax=2"];
    

    NSLog(@"%@",serverUrl);
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
    NSString* newStr = [[NSString alloc] initWithData:inputData  encoding:NSUTF8StringEncoding];
    //NSLog(@"json form data : %@",newStr);
    //NSLog(@"%@",[json objectForKey:@"category"]);
    NSMutableArray *formData = [NSMutableArray arrayWithArray:[json objectForKey:@"category"]];
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:YES];
    [formData sortUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
    
    [self.delegate loadFormDataDidFinish:formData];
    
    [self.delegate saveFormDataDidFinish:newStr];
   
}


@end



