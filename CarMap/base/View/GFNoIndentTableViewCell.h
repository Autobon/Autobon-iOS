//
//  GFNoIndentTableViewCell.h
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/10.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFNoIndentTableViewCell : UITableViewCell



@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UIImageView *indentImgView;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UILabel *lab4;
@property (nonatomic, strong) UIView *baseView2;
@property (nonatomic, assign) CGFloat cellHeight;



- (void)setMessage;
@property (nonatomic, copy) NSString *orderNum;
@property (nonatomic, copy) NSString *orderType;
@property (nonatomic, copy) NSString *workCon;
@property (nonatomic, copy) NSString *workTime;
@property (nonatomic, copy) NSString *imgName;
@property (nonatomic, copy) NSString *beizhu;
@property (nonatomic, copy) NSString *xiadanTime;

@end
