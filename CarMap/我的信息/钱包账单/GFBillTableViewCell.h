//
//  GFBillTableViewCell.h
//  CarMap
//
//  Created by 陈光法 on 16/2/24.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFBillTableViewCell : UITableViewCell

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, strong) UIButton *jiesuanBut;
@property (nonatomic, strong) UILabel *monthLab;
@property (nonatomic, strong) UILabel *sumMoneyLab;


@end
