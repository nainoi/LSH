//
//  CollectionProductViewCell.h
//  LiangSengHeng
//
//  Created by iSomZEE on 9/28/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface CollectionProductViewCell : UICollectionViewCell

@property (nonatomic, strong) Product *product;
@property (nonatomic, strong) IBOutlet UIImageView *productImage;

@end
