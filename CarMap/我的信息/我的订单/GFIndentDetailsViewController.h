//
//  GFIndentDetailsViewController.h
//  CarMap
//
//  Created by 陈光法 on 16/2/25.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GFIndentViewController;
@class GFIndentModel;

@interface GFIndentDetailsViewController : UIViewController


@property (nonatomic, strong) UILabel *numberLab;
@property (nonatomic, strong) UILabel *moneyLab;
@property (nonatomic, strong) UIButton *tipBut;
@property (nonatomic, strong) UIImageView *photoImgView;
@property (nonatomic, strong) UILabel *beizhuLab;
@property (nonatomic, strong) UILabel *workDayLab;
@property (nonatomic, strong) UILabel *workTimeLab;
@property (nonatomic, strong) UILabel *carPlaceLab;



@property (nonatomic, strong) UILabel *pingjiaLab;
@property (nonatomic, assign) NSInteger fenshu;
@property (nonatomic, strong) UIButton *daodaBut;
@property (nonatomic, strong) UIButton *wangongBut;
@property (nonatomic, strong) UIButton *zhuanyeBut;
@property (nonatomic, strong) UIButton *zhengjieBut;
@property (nonatomic, strong) UIButton *bangBut;
@property (nonatomic, strong) UIButton *haoBut;

@property (nonatomic, strong) GFIndentViewController *indentVC;
@property (nonatomic, strong) GFIndentModel *model;

@end
