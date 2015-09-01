//
//  TableGoldViewCell.m
//  LiangSengHeng
//
//  Created by iSomZEE on 9/21/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import "TableGoldViewCell.h"

@implementation TableGoldViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_lbBuy fontRegularWithSize:12];
    [_lbDifferent fontRegularWithSize:12];
    [_lbSell fontRegularWithSize:12];
    [_lbTime fontRegularWithSize:12];
}

@end
