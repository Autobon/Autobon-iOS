//
//  CLTitleTableViewCell.h
//  CarMap
//
//  Created by 李孟龙 on 16/2/18.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLTitleTableViewCell : UITableViewCell

@property (nonatomic ,strong) UILabel *titleLable;
@property (nonatomic ,strong) UILabel *detailLabel;


- (void)initWithTitle;







@end
