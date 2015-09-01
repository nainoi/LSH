//
//  CollectionProductViewCell.m
//  LiangSengHeng
//
//  Created by iSomZEE on 9/28/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import "CollectionProductViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CollectionProductViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)setProduct:(Product *)product{
    _product = product;
    [_productImage sd_setImageWithURL:[NSURL URLWithString:_product.imageUrl] placeholderImage:[UIImage imageNamed:@"tb_1280561141.jpg"]];
}

@end
