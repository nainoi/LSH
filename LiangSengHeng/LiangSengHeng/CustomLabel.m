//
//  CustomLabel.m
//  LiangSengHeng
//
//  Created by GLIVE on 7/5/2558 BE.
//  Copyright (c) 2558 iSomZEE. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

-(void)awakeFromNib{
    [super awakeFromNib];
    self.font = [UIFont fontWithName:@"THFahkwang" size:16];
}

-(void)fontRegularWithSize:(NSInteger)size{
    self.font = [UIFont fontWithName:@"THFahkwang" size:size];
}

-(void)fontBoldWithSize:(NSInteger)size{
    self.font = [UIFont fontWithName:@"TH Fahkwang Bold" size:size];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
