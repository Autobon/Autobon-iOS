//
//  GFIndentTableViewCell.h
//  CarMap
//
//  Created by 陈光法 on 16/2/25.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFIndentTableViewCell : UITableViewCell


@property (nonatomic, strong) UILabel *numberLab;
@property (nonatomic, strong) UILabel *moneyLab;
@property (nonatomic, strong) UIButton *tipBut;
@property (nonatomic, strong) UIImageView *photoImgView;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *placeLab;


@property (nonatomic, strong) NSString *workItems;

@end
