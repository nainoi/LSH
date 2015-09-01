//
//  TableGoldViewCell.h
//  LiangSengHeng
//
//  Created by iSomZEE on 9/21/14.
//  Copyright (c) 2014 iSomZEE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLabel.h"

@interface TableGoldViewCell : UITableViewCell

@property(nonatomic,retain)IBOutlet CustomLabel *lbTime;
@property(nonatomic,retain)IBOutlet CustomLabel *lbBuy;
@property(nonatomic,retain)IBOutlet CustomLabel *lbSell;
@property(nonatomic,retain)IBOutlet CustomLabel *lbDifferent;
@end
