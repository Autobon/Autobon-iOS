//
//  GFBillDetailsTableViewCell.h
//  CarMap
//
//  Created by 陈光法 on 16/2/25.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFBillDetailsTableViewCell : UITableViewCell


@property (nonatomic, strong) UILabel *numberLab;
@property (nonatomic, strong) UILabel *moneyLab;
@property (nonatomic, strong) UIImageView *photoImgView;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *placeLab;

@property (nonatomic, assign) CGFloat placeLabW;
@property (nonatomic, assign) CGFloat placeLabH;
@property (nonatomic, assign) CGFloat placeLabX;
@property (nonatomic, assign) CGFloat placeLabY;


@property (nonatomic, strong) UIView *downLine;
@property (nonatomic, strong) UIView *baseView;

@end
