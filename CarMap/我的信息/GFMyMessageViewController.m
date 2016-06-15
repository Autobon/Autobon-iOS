//
//  GFMyMessageViewController.m
//  车邻邦自定义控件
//
//  Created by 陈光法 on 16/2/16.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFMyMessageViewController.h"
#import "GFNavigationView.h"
#import "GFAlertView.h"
#import "GFHttpTool.h"
#import "GFChangePwdViewController.h"
#import "GFBalanceViewController.h"
#import "GFBillViewController.h"
#import "GFSignInViewController.h"
#import "GFIndentViewController.h"
#import "CLCertifyViewController.h"
#import "UIImageView+WebCache.h"
#import "GFTipView.h"
#import "CLNotificationViewController.h"
#import "GFTransformViewController.h"
#import "GFServeViewController.h"



@interface GFMyMessageViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jiange1;
    
    CGFloat jianjv1;
    CGFloat jianjv2;

    
}

@property (nonatomic, strong) GFNavigationView *navView;




@end

@implementation GFMyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[SDImageCache sharedImageCache] clearDisk];
    
    // 基础设置
    [self _setBase];
    
    // 界面搭建
    [self _setView];
    
    
    
}

- (void)_setBase {
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    
    jiange1 = kHeight * 0.018;
    
    
    jianjv1 = kWidth * 0.028;
    jianjv2 = kWidth * 0.042;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"我的信息" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}


- (void)_setView {
    
    // 个人基本信息
    CGFloat msgViewW = kWidth;
    CGFloat msgViewH = kHeight * 0.162;
    CGFloat msgViewX = 0;
    CGFloat msgViewY = 64;
    UIView *msgView = [[UIView alloc] initWithFrame:CGRectMake(msgViewX, msgViewY, msgViewW, msgViewH)];
    msgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:msgView];
    // 边线
    UIView *msgLine = [[UIView alloc] initWithFrame:CGRectMake(0, msgViewH - 1, msgViewW, 1)];
    msgLine.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [msgView addSubview:msgLine];
    // 右边箭头
    CGFloat msgRightButW = kWidth * 0.08;
    CGFloat msgRightButH = msgViewH;
    CGFloat msgRightButX = kWidth * 0.92;
    CGFloat msgRightButY = 0;
    UIButton *msgRightBut = [UIButton buttonWithType:UIButtonTypeCustom];
    msgRightBut.frame = CGRectMake(msgRightButX, msgRightButY, msgRightButW, msgRightButH-10);
    [msgRightBut setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    msgRightBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [msgView addSubview:msgRightBut];
//    msgRightBut.backgroundColor = [UIColor redColor];
    // 左边头像
    CGFloat iconImgViewW = kWidth * 0.176;
    CGFloat iconImgViewH = iconImgViewW;
    CGFloat iconImgViewX = jianjv2;
    CGFloat iconImgViewY = (msgRightButH - iconImgViewH) / 2.0;
    UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iconImgViewX, iconImgViewY, iconImgViewW, iconImgViewH)];
    iconImgView.layer.cornerRadius = iconImgViewW / 2.0;
    iconImgView.clipsToBounds = YES;
    iconImgView.contentMode = UIViewContentModeScaleAspectFill;
    iconImgView.image = [UIImage imageNamed:@"userHeadImage"];
    [msgView addSubview:iconImgView];
    // 姓名
    NSString *nameStr = @"";
    NSMutableDictionary *attDic = [[NSMutableDictionary alloc] init];
    attDic[NSFontAttributeName] = [UIFont systemFontOfSize:16 / 320.0 * kWidth];
    attDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect strRect = [nameStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
    CGFloat nameLabW = strRect.size.width + jianjv1;
    CGFloat nameLabH = iconImgViewH / 2.0;
    CGFloat nameLabX = CGRectGetMaxX(iconImgView.frame) + jianjv2;
    CGFloat nameLabY = iconImgViewY + 2;
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, nameLabY, nameLabW, nameLabH)];
    nameLab.font = [UIFont systemFontOfSize:16.5 / 320.0 * kWidth];
    nameLab.text = nameStr;
    [msgView addSubview:nameLab];

    
    // 订单数
    CGFloat indentLabW = kWidth * 0.16;
    CGFloat indentLabH = nameLabH;
    CGFloat indentLabX = nameLabX;
    CGFloat indentLabY = CGRectGetMaxY(nameLab.frame);
    UILabel *indentLab = [[UILabel alloc] initWithFrame:CGRectMake(indentLabX, indentLabY, indentLabW, indentLabH)];
    indentLab.text = @"订单数";
    indentLab.font = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
    [msgView addSubview:indentLab];
    NSString *numStr = @"0";
    NSMutableDictionary *numDic = [[NSMutableDictionary alloc] init];
    numDic[NSFontAttributeName] = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
    numDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect numRect = [numStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:numDic context:nil];
    CGFloat numLabW = numRect.size.width;
    CGFloat numLabH = indentLabH;
    CGFloat numLabX = CGRectGetMaxX(indentLab.frame) - 3;
    CGFloat numLabY = indentLabY;
    UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(numLabX, numLabY, numLabW, numLabH)];
    numLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    numLab.font = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
    numLab.text = numStr;
    [msgView addSubview:numLab];
    
    NSString *fenStr = @"0";
    NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
    fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
    CGFloat fenLabW = fenRect.size.width + 10;
    CGFloat fenLabH = strRect.size.height;
    CGFloat fenLabX = CGRectGetMaxX(nameLab.frame) + strRect.size.height * 5 + jianjv1;
    CGFloat fenLabY = numLabY + 3.5 / 568 * kHeight;
    UILabel *fenLab = [[UILabel alloc] initWithFrame:CGRectMake(fenLabX, fenLabY, fenLabW, fenLabH)];
    fenLab.textColor = [UIColor whiteColor];
    fenLab.textAlignment = NSTextAlignmentCenter;
    fenLab.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    fenLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    fenLab.text = fenStr;
    fenLab.layer.cornerRadius = 7.5;
    fenLab.clipsToBounds = YES;
    [msgView addSubview:fenLab];
    
    //好评率
//    CGFloat goodLabW = indentLabW;
//    CGFloat goodLabH = indentLabH;
//    CGFloat goodLabX = CGRectGetMaxX(numLab.frame) + jianjv1;
//    CGFloat goodLabY = indentLabY;
//    UILabel *goodLab = [[UILabel alloc] initWithFrame:CGRectMake(goodLabX, goodLabY, goodLabW, goodLabH)];
//    goodLab.text = @"好评率";
//    goodLab.font = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
//    [msgView addSubview:goodLab];
//    NSString *proStr = @"99.99%";
//    NSMutableDictionary *proDic = [[NSMutableDictionary alloc] init];
//    proDic[NSFontAttributeName] = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
//    proDic[NSForegroundColorAttributeName] = [UIColor blackColor];
//    CGRect proRect = [proStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:proDic context:nil];
//    CGFloat proLabW = proRect.size.width;
//    CGFloat proLabH = goodLabH;
//    CGFloat proLabX = CGRectGetMaxX(goodLab.frame) - 3;
//    CGFloat proLabY = goodLabY;
//    UILabel *proLab = [[UILabel alloc] initWithFrame:CGRectMake(proLabX, proLabY, proLabW, proLabH)];
//    proLab.text = proStr;
//    proLab.font = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
//    proLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
//    [msgView addSubview:proLab];
    // 页面按钮
    CGFloat msgButW = msgViewW;
    CGFloat msgButH = msgViewH;
    CGFloat msgButX = 0;
    CGFloat msgButY = 0;
    UIButton *msgBut = [UIButton buttonWithType:UIButtonTypeCustom];
    msgBut.frame = CGRectMake(msgButX, msgButY, msgButW, msgButH);
    [msgView addSubview:msgBut];
    [msgBut addTarget:self action:@selector(msgButClick) forControlEvents:UIControlEventTouchUpInside];

    
    
    

    // 钱包
    CGFloat moneyViewW = msgViewW;
    CGFloat moneyViewH = kHeight * (0.078 + 0.104);
    CGFloat moneyViewX = msgViewX;
    CGFloat moneyViewY = CGRectGetMaxY(msgView.frame) + jiange1;
    UIView *moneyView = [[UIView alloc] initWithFrame:CGRectMake(moneyViewX, moneyViewY, moneyViewW, moneyViewH)];
    moneyView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:moneyView];
    // 边线
    UIView *moneyLineUp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, moneyViewW, 1)];
    moneyLineUp.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [moneyView addSubview:moneyLineUp];
    UIView *moneyLineDown = [[UIView alloc] initWithFrame:CGRectMake(0, moneyViewH - 1, moneyViewW, 1)];
    moneyLineDown.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [moneyView addSubview:moneyLineDown];
    // 中间线
    UIView *moneyLineCenter = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight * 0.078, moneyViewW, 1)];
    moneyLineCenter.backgroundColor = [UIColor colorWithRed:223 / 255.0 green:223 / 255.0 blue:223 / 255.0 alpha:1];
    [moneyView addSubview:moneyLineCenter];
    UIView *moneyLineShu = [[UIView alloc] initWithFrame:CGRectMake((moneyViewW - 1) / 2.0, (kHeight * 0.078) + (kHeight * 0.104 * 0.22), 1, kHeight * 0.104 * 0.56)];
    moneyLineShu.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [moneyView addSubview:moneyLineShu];
    // 钱包行界面
    CGFloat moneyImgViewW = kWidth * 0.075;
    CGFloat moneyImgViewH = moneyImgViewW;
    CGFloat moneyImgViewX = jianjv1;
    CGFloat moneyImgViewY = (kHeight * 0.078 - moneyImgViewH) / 2.0;
    UIImageView *moneyImgView = [[UIImageView alloc] initWithFrame:CGRectMake(moneyImgViewX, moneyImgViewY, moneyImgViewW, moneyImgViewH)];
    moneyImgView.image = [UIImage imageNamed:@"purse"];
    [moneyView addSubview:moneyImgView];
    CGFloat moneyLabW = 150;
    CGFloat moneyLabH = moneyImgViewH;
    CGFloat moneyLabX = CGRectGetMaxX(moneyImgView.frame) + jianjv1;
    CGFloat moneyLabY = moneyImgViewY;
    UILabel *moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(moneyLabX, moneyLabY, moneyLabW, moneyLabH)];
    moneyLab.text = @"钱包";
    [moneyView addSubview:moneyLab];
    // 余额栏界面
    CGFloat balanceLabUpW = (kWidth - 1) / 2.0;
    CGFloat balanceLabUpH = moneyLineShu.frame.size.height / 2.0;
    CGFloat balanceLabUpX = 0;
    CGFloat balanceLabUpY = moneyLineShu.frame.origin.y - 2;
    UILabel *balanceLabUp = [[UILabel alloc] initWithFrame:CGRectMake(balanceLabUpX, balanceLabUpY, balanceLabUpW, balanceLabUpH)];
    balanceLabUp.textAlignment = NSTextAlignmentCenter;
    balanceLabUp.text = @"100.32";
    balanceLabUp.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    [moneyView addSubview:balanceLabUp];
    CGFloat balanceLabDownW = balanceLabUpW;
    CGFloat balanceLabDownH = balanceLabUpH;
    CGFloat balanceLabDownX = balanceLabUpX;
    CGFloat balanceLabDownY = CGRectGetMaxY(balanceLabUp.frame) + 3;
    UILabel *balanceLabDown = [[UILabel alloc] initWithFrame:CGRectMake(balanceLabDownX, balanceLabDownY, balanceLabDownW, balanceLabDownH)];
    balanceLabDown.textAlignment = NSTextAlignmentCenter;
    balanceLabDown.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
    balanceLabDown.font = [UIFont systemFontOfSize:10 / 320.0 * kWidth];
    balanceLabDown.text = @"余额(￥)";
    [moneyView addSubview:balanceLabDown];
    // 余额栏按钮
    CGFloat balButW = balanceLabUpW;
    CGFloat balButH = moneyViewH - moneyImgViewH;
    CGFloat balButX = 0;
    CGFloat balButY = moneyImgViewH;
    UIButton *balBut = [UIButton buttonWithType:UIButtonTypeCustom];
    balBut.frame = CGRectMake(balButX, balButY, balButW, balButH);
    [moneyView addSubview:balBut];
    [balBut addTarget:self action:@selector(balButClick) forControlEvents:UIControlEventTouchUpInside];
    // 账单栏界面
    CGFloat billLabUpW = (kWidth - 1) / 2.0;
    CGFloat billLabUpH = moneyLineShu.frame.size.height / 2.0;
    CGFloat billLabUpX = kWidth / 2.0 + 0.5;
    CGFloat billLabUpY = moneyLineShu.frame.origin.y - 2;
    UILabel *billLabUp = [[UILabel alloc] initWithFrame:CGRectMake(billLabUpX, billLabUpY, billLabUpW, billLabUpH)];
    billLabUp.textAlignment = NSTextAlignmentCenter;
    billLabUp.text = @"6";
    billLabUp.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    [moneyView addSubview:billLabUp];
    CGFloat billLabDownW = billLabUpW;
    CGFloat billLabDownH = billLabUpH;
    CGFloat billLabDownX = billLabUpX;
    CGFloat billLabDownY = CGRectGetMaxY(billLabUp.frame) + 3;
    UILabel *billLabDown = [[UILabel alloc] initWithFrame:CGRectMake(billLabDownX, billLabDownY, billLabDownW, billLabDownH)];
    billLabDown.textAlignment = NSTextAlignmentCenter;
    billLabDown.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
    billLabDown.font = [UIFont systemFontOfSize:10 / 320.0 * kWidth];
    billLabDown.text = @"账单(条)";
    [moneyView addSubview:billLabDown];
    // 账单栏按钮
    CGFloat billButW = balButW;
    CGFloat billButH = balButH;
    CGFloat billButX = CGRectGetMaxX(balBut.frame);
    CGFloat billButY = balButY;
    UIButton *billBut = [UIButton buttonWithType:UIButtonTypeCustom];
    billBut.frame = CGRectMake(billButX, billButY, billButW, billButH);
    [moneyView addSubview:billBut];
    [billBut addTarget:self action:@selector(billBut) forControlEvents:UIControlEventTouchUpInside];

    
    
    
    
    // 我的订单
    CGFloat indentViewW = msgViewW;
    CGFloat indentViewH = kHeight * 0.078;
    CGFloat indentViewX = msgViewX;
    CGFloat indentViewY = CGRectGetMaxY(moneyView.frame) + jiange1;
    UIView *indentView = [[UIView alloc] initWithFrame:CGRectMake(indentViewX, indentViewY, indentViewW, indentViewH)];
    indentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:indentView];
    // 边线
    UIView *indentLineUp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, indentViewW, 1)];
    indentLineUp.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [indentView addSubview:indentLineUp];
    UIView *indentLineDown  = [[UIView alloc] initWithFrame:CGRectMake(0, indentViewH - 1, indentViewW, 1)];
    indentLineDown.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [indentView addSubview:indentLineDown];
    // 界面
    CGFloat indentImgViewW = kWidth * 0.075;
    CGFloat indentImgViewH = indentImgViewW;
    CGFloat indentImgViewX = jianjv1;
    CGFloat indentImgViewY = (indentViewH - indentImgViewH) / 2.0;
    UIImageView *indentImgView = [[UIImageView alloc] initWithFrame:CGRectMake(indentImgViewX, indentImgViewY, indentImgViewW, indentImgViewH)];
    indentImgView.image = [UIImage imageNamed:@"order"];
    [indentView addSubview:indentImgView];
    CGFloat billLabW = 150;
    CGFloat billLabH = indentImgViewH;
    CGFloat billLabX = CGRectGetMaxX(indentImgView.frame) + jianjv1;
    CGFloat billLabY = indentImgViewY;
    UILabel *billLab = [[UILabel alloc] initWithFrame:CGRectMake(billLabX, billLabY, billLabW, billLabH)];
    billLab.text = @"我的订单";
    [indentView addSubview:billLab];
    // 右边箭头
    CGFloat indentRightButW = kWidth * 0.08;
    CGFloat indentRightButH = indentViewH;
    CGFloat indentRightButX = kWidth * 0.92;
    CGFloat indentRightButY = 0;
    UIButton *indentRightBut = [UIButton buttonWithType:UIButtonTypeCustom];
    indentRightBut.frame = CGRectMake(indentRightButX, indentRightButY, indentRightButW, indentRightButH);
    [indentRightBut setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    indentRightBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [indentView addSubview:indentRightBut];
    // 订单界面按钮
    CGFloat indentButW = indentViewW;
    CGFloat indentButH = indentViewH;
    CGFloat indentButX = 0;
    CGFloat indentButY = 0;
    UIButton *indentBut = [UIButton buttonWithType:UIButtonTypeCustom];
    indentBut.frame = CGRectMake(indentButX, indentButY, indentButW, indentButH);
    [indentView addSubview:indentBut];
    [indentBut addTarget:self action:@selector(indentButClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    // 通知列表
    CGFloat notificationViewW = msgViewW;
    CGFloat notificationViewH = indentViewH;
    CGFloat notificationViewX = msgViewX;
    CGFloat notificationViewY = CGRectGetMaxY(indentView.frame) + jiange1;
    UIView *notificationView = [[UIView alloc] initWithFrame:CGRectMake(notificationViewX, notificationViewY, notificationViewW, notificationViewH)];
    notificationView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:notificationView];
    // 边线
    UIView *notificationLineUp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, notificationViewW, 1)];
    notificationLineUp.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [notificationView addSubview:notificationLineUp];
    UIView *notificationLineDown = [[UIView alloc] initWithFrame:CGRectMake(0, notificationViewH - 1, notificationViewW, 1)];
    notificationLineDown.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [notificationView addSubview:notificationLineDown];
    // 界面
    CGFloat notificationImgViewW = kWidth * 0.075;
    CGFloat notificationImgViewH = notificationImgViewW;
    CGFloat notificationImgViewX = jianjv1;
    CGFloat notificationImgViewY = (notificationViewH - notificationImgViewH) / 2.0;
    UIImageView *notificationImgView = [[UIImageView alloc] initWithFrame:CGRectMake(notificationImgViewX, notificationImgViewY, notificationImgViewW, notificationImgViewH)];
    notificationImgView.image = [UIImage imageNamed:@"information-2"];
    [notificationView addSubview:notificationImgView];
    CGFloat notificationLabW = 150;
    CGFloat notificationLabH = notificationImgViewH;
    CGFloat notificationLabX = CGRectGetMaxX(notificationImgView.frame) + jianjv1;
    CGFloat notificationLabY = notificationImgViewY;
    UILabel *notificationLab = [[UILabel alloc] initWithFrame:CGRectMake(notificationLabX, notificationLabY, notificationLabW, notificationLabH)];
    notificationLab.text = @"通知列表";
//    notificationLab.backgroundColor = [UIColor redColor];
    [notificationView addSubview:notificationLab];
    // 右边箭头
    CGFloat notificationRightButW = kWidth * 0.08;
    CGFloat notificationRightButH = indentViewH;
    CGFloat notificationRightButX = kWidth * 0.92;
    CGFloat notificationRightButY = 0;
    UIButton *notificationRightBut = [UIButton buttonWithType:UIButtonTypeCustom];
    notificationRightBut.frame = CGRectMake(notificationRightButX, notificationRightButY, notificationRightButW, notificationRightButH);
    [notificationRightBut setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    notificationRightBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [notificationView addSubview:notificationRightBut];
    // 修改密码界面按钮
    CGFloat notificationButW = notificationViewW;
    CGFloat notificationButH = notificationViewH;
    CGFloat notificationButX = 0;
    CGFloat notificationButY = 0;
    UIButton *notificationBut = [UIButton buttonWithType:UIButtonTypeCustom];
    notificationBut.frame = CGRectMake(notificationButX, notificationButY, notificationButW, notificationButH);
    [notificationView addSubview:notificationBut];
    [notificationBut addTarget:self action:@selector(notificationButClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    // 修改密码
    CGFloat changePwdViewW = msgViewW;
    CGFloat changePwdViewH = indentViewH;
    CGFloat changePwdViewX = msgViewX;
    CGFloat changePwdViewY = CGRectGetMaxY(notificationView.frame) + jiange1;
    UIView *changePwdView = [[UIView alloc] initWithFrame:CGRectMake(changePwdViewX, changePwdViewY, changePwdViewW, changePwdViewH)];
    changePwdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:changePwdView];
    // 边线
    UIView *changePwdLineUp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, changePwdViewW, 1)];
    changePwdLineUp.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [changePwdView addSubview:changePwdLineUp];
    UIView *changePwdLineDown = [[UIView alloc] initWithFrame:CGRectMake(0, changePwdViewH - 1, changePwdViewW, 1)];
    changePwdLineDown.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [changePwdView addSubview:changePwdLineDown];
    // 界面
    CGFloat changPwdImgViewW = kWidth * 0.075;
    CGFloat changPwdImgViewH = changPwdImgViewW;
    CGFloat changPwdImgViewX = jianjv1;
    CGFloat changPwdImgViewY = (changePwdViewH - changPwdImgViewH) / 2.0;
    UIImageView *changPwdImgView = [[UIImageView alloc] initWithFrame:CGRectMake(changPwdImgViewX, changPwdImgViewY, changPwdImgViewW, changPwdImgViewH)];
    changPwdImgView.image = [UIImage imageNamed:@"editPassword"];
    [changePwdView addSubview:changPwdImgView];
    CGFloat changgePwdLabW = 150;
    CGFloat changgePwdLabH = changPwdImgViewH;
    CGFloat changgePwdLabX = CGRectGetMaxX(changPwdImgView.frame) + jianjv1;
    CGFloat changgePwdLabY = changPwdImgViewY;
    UILabel *changgePwdLab = [[UILabel alloc] initWithFrame:CGRectMake(changgePwdLabX, changgePwdLabY, changgePwdLabW, changgePwdLabH)];
    changgePwdLab.text = @"修改密码";
    [changePwdView addSubview:changgePwdLab];
    // 右边箭头
    CGFloat changePwdRightButW = kWidth * 0.08;
    CGFloat changePwdRightButH = indentViewH;
    CGFloat changePwdRightButX = kWidth * 0.92;
    CGFloat changePwdRightButY = 0;
    UIButton *changePwdRightBut = [UIButton buttonWithType:UIButtonTypeCustom];
    changePwdRightBut.frame = CGRectMake(changePwdRightButX, changePwdRightButY, changePwdRightButW, changePwdRightButH);
    [changePwdRightBut setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    changePwdRightBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [changePwdView addSubview:changePwdRightBut];
    // 修改密码界面按钮
    CGFloat changePwdButW = changePwdViewW;
    CGFloat changePwdButH = changePwdViewH;
    CGFloat changePwdButX = 0;
    CGFloat changePwdButY = 0;
    UIButton *changePwdBut = [UIButton buttonWithType:UIButtonTypeCustom];
    changePwdBut.frame = CGRectMake(changePwdButX, changePwdButY, changePwdButW, changePwdButH);
    [changePwdView addSubview:changePwdBut];
    [changePwdBut addTarget:self action:@selector(changePwdButClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    
    // 英卡服务项
    CGFloat serveViewW = msgViewW;
    CGFloat serveViewH = indentViewH;
    CGFloat serveViewX = msgViewX;
    CGFloat serveViewY = CGRectGetMaxY(changePwdView.frame) + jiange1;
    UIView *serveView = [[UIView alloc] initWithFrame:CGRectMake(serveViewX, serveViewY, serveViewW, serveViewH)];
//    serveView.backgroundColor = [UIColor redColor];
    [self.view addSubview:serveView];
    // 边线
    UIView *serveLineUp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, serveViewW, 1)];
    serveLineUp.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [serveView addSubview:serveLineUp];
    UIView *serveLineDown = [[UIView alloc] initWithFrame:CGRectMake(0, serveViewH - 1, serveViewW, 1)];
    serveLineDown.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [serveView addSubview:serveLineDown];
    // 界面
    CGFloat serveImgViewW = kWidth * 0.075;
    CGFloat serveImgViewH = serveImgViewW;
    CGFloat serveImgViewX = jianjv1;
    CGFloat serveImgViewY = (serveViewH - serveImgViewH) / 2.0;
    UIImageView *serveImgView = [[UIImageView alloc] initWithFrame:CGRectMake(serveImgViewX, serveImgViewY, serveImgViewW, serveImgViewH)];
    serveImgView.image = [UIImage imageNamed:@"centre"];
    [serveView addSubview:serveImgView];
    CGFloat serveLabW = 150;
    CGFloat serveLabH = serveImgViewH;
    CGFloat serveLabX = CGRectGetMaxX(serveImgView.frame) + jianjv1;
    CGFloat serveLabY = changPwdImgViewY;
    UILabel *serveLab = [[UILabel alloc] initWithFrame:CGRectMake(serveLabX, serveLabY, serveLabW, serveLabH)];
    serveLab.text = @"服务中心";
    [serveView addSubview:serveLab];
    // 右边箭头
    CGFloat serveRightButW = kWidth * 0.08;
    CGFloat serveRightButH = indentViewH;
    CGFloat serveRightButX = kWidth * 0.92;
    CGFloat serveRightButY = 0;
    UIButton *serveRightBut = [UIButton buttonWithType:UIButtonTypeCustom];
    serveRightBut.frame = CGRectMake(serveRightButX, serveRightButY, serveRightButW, serveRightButH);
    [serveRightBut setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    serveRightBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [serveView addSubview:serveRightBut];
    // 修改密码界面按钮
    CGFloat serveButW = serveViewW;
    CGFloat serveButH = serveViewH;
    CGFloat serveButX = 0;
    CGFloat serveButY = 0;
    UIButton *serveBut = [UIButton buttonWithType:UIButtonTypeCustom];
    serveBut.frame = CGRectMake(serveButX, serveButY, serveButW, serveButH);
    [serveView addSubview:serveBut];
    [serveBut addTarget:self action:@selector(serveButClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    
    
    
    
    
    // 退出登录
    CGFloat exitButW = msgViewW;
    CGFloat exitButH = indentViewH;
    CGFloat exitButX = msgViewX;
    CGFloat exitButY = kHeight - exitButH;
    UIButton *exitBut = [UIButton buttonWithType:UIButtonTypeCustom];
    exitBut.frame = CGRectMake(exitButX, exitButY, exitButW, exitButH);
    [exitBut setBackgroundColor:[UIColor whiteColor]];
    [exitBut setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    exitBut.titleLabel.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    [self.view addSubview:exitBut];
    [exitBut addTarget:self action:@selector(exitButClick) forControlEvents:UIControlEventTouchUpInside];
    // 边线
    UIView *exitLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, exitButW, 1)];
    exitLine.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [exitBut addSubview:exitLine];
    
    
    // 数据请求
//    NSString *url = @"http://121.40.157.200:12345/api/mobile/technician";
    
    [GFHttpTool messageGetWithParameters:nil success:^(id responseObject) {
        
        NSInteger flage = [responseObject[@"result"] integerValue];
        if(flage == 1) {
            
//            NSLog(@"请求成功+++++++++++++%@", responseObject);
            
            NSDictionary *dataDic = responseObject[@"data"];
            
            NSString *idPhoto = dataDic[@"avatar"];
            NSString *name = dataDic[@"name"];
            NSString *starRate = dataDic[@"starRate"];
            if([name isKindOfClass:[NSNull class]]) {
                name = [NSString stringWithFormat:@""];
            }
            
            if([starRate isKindOfClass:[NSNull class]]) {
                starRate = [NSString stringWithFormat:@"0"];
            }
            NSString *totalOrders = dataDic[@"totalOrders"];
            if([totalOrders isKindOfClass:[NSNull class]]) {
                totalOrders = [NSString stringWithFormat:@"0"];
            }
            NSString *balance = dataDic[@"balance"];
            if([balance isKindOfClass:[NSNull class]]) {
                balance = [NSString stringWithFormat:@"0"];
            }
            NSString *unpaidOrders = dataDic[@"unpaidOrders"];
            if([unpaidOrders isKindOfClass:[NSNull class]]) {
                unpaidOrders = [NSString stringWithFormat:@"0"];
            }
            
            
            self.bank = dataDic[@"bank"];
            self.bankCardNo = dataDic[@"bankCardNo"];
            self.balance = balance;
            self.name = name;
//            NSLog(@"\n%@\n%@\n%@\n%@\n%@\n%@\n", idPhoto, name, starRate, totalOrders, balance, unpaidOrders);
            
            // 头像
            extern NSString* const URLHOST;
            idPhoto = [NSString stringWithFormat:@"%@%@",URLHOST,idPhoto];
            NSURL *imgUrl = [NSURL URLWithString:idPhoto];
            [iconImgView sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"userHeadImage"]];
            // 姓名
            NSString *nameStr = name;
            NSMutableDictionary *attDic = [[NSMutableDictionary alloc] init];
            attDic[NSFontAttributeName] = [UIFont systemFontOfSize:16 / 320.0 * kWidth];
            attDic[NSForegroundColorAttributeName] = [UIColor blackColor];
            CGRect strRect1 = [nameStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
            CGFloat nameLabW = strRect1.size.width + jianjv1;
            nameLab.frame = CGRectMake(nameLabX, nameLabY, nameLabW, nameLabH);
            nameLab.text = nameStr;
            // 星星
            for(int i=0; i<5; i++) {
                
                CGFloat starImgViewW = strRect.size.height;
                CGFloat starImgViewH = starImgViewW;
                CGFloat starImgViewX = CGRectGetMaxX(numLab.frame) + 20 + starImgViewW * i;
                CGFloat starImgViewY = numLabY + 3.5 / 568 * kHeight;
                UIImageView *starImgView = [[UIImageView alloc] initWithFrame:CGRectMake(starImgViewX, starImgViewY, starImgViewW, starImgViewH)];
                starImgView.contentMode = UIViewContentModeScaleAspectFit;
                starImgView.image = [UIImage imageNamed:@"detailsStarDark.png"];
                [msgView addSubview:starImgView];
                
            }
            CGFloat starF = [starRate floatValue];
            CGFloat star = round(starF);
            for(int i=0; i<star; i++) {
                
                CGFloat starImgViewW = strRect.size.height;
                CGFloat starImgViewH = starImgViewW;
                CGFloat starImgViewX = CGRectGetMaxX(numLab.frame) + 20 + starImgViewW * i;
                CGFloat starImgViewY = numLabY + 3.5 / 568 * kHeight;
                UIImageView *starImgView = [[UIImageView alloc] initWithFrame:CGRectMake(starImgViewX, starImgViewY, starImgViewW, starImgViewH)];
                starImgView.contentMode = UIViewContentModeScaleAspectFit;
                starImgView.image = [UIImage imageNamed:@"information.png"];
                [msgView addSubview:starImgView];
            }
            // 评分
            NSString *fenStr1 = [NSString stringWithFormat:@"%@", starRate];
            NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
            fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
            fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
//            NSLog(@"\n%@", fenDic);
//            NSLog(@"%@", fenStr1);
            CGRect fenRect1 = [fenStr1 boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
            CGFloat fenLabW = fenRect1.size.width + 10;
            CGFloat fenLabX = CGRectGetMaxX(numLab.frame) + 20 + strRect.size.height * 5 + jianjv1;
            fenLab.frame = CGRectMake(fenLabX, fenLabY, fenLabW, fenLabH);
            fenLab.text = fenStr1;
            // 订单数
            NSString *numStr1 = [NSString stringWithFormat:@"%@", totalOrders];
            NSMutableDictionary *numDic = [[NSMutableDictionary alloc] init];
            numDic[NSFontAttributeName] = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
            numDic[NSForegroundColorAttributeName] = [UIColor blackColor];
            CGRect numRect1 = [numStr1 boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:numDic context:nil];
            CGFloat numLabW = numRect1.size.width;
            numLab.frame = CGRectMake(numLabX, numLabY, numLabW, numLabH);
            numLab.text = numStr1;
            // 余额
            balanceLabUp.text = [NSString stringWithFormat:@"%@", balance];
            // 账单
            billLabUp.text = [NSString stringWithFormat:@"%@", unpaidOrders];
            
        }else {
        
//            NSLog(@"请求失败+++++++++++++%@", responseObject);
        }
        
    } failure:^(NSError *error) {
         NSLog(@"请求失败+++++++++++++%@", error);
        [self addAlertView:@"信息请求失败"];
    }];
    
    
    
}


#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}

#pragma mark - 通知列表按钮的响应方法
- (void)notificationButClick{
    
    GFTransformViewController *notificationView = [[GFTransformViewController alloc]init];
    [self.navigationController pushViewController:notificationView animated:YES];
    
    
}

#pragma mark - 服务中心客服电话
- (void)serveButClick{
    
    GFServeViewController *serveView = [[GFServeViewController alloc]init];
    [self.navigationController pushViewController:serveView animated:YES];
    
}



// 信息界面按钮跳转
- (void)msgButClick {

    CLCertifyViewController *certify = [[CLCertifyViewController alloc]init];
    certify.isFail = YES;
    [certify.submitButton setTitle:@"再次认证" forState:UIControlStateNormal];
    [self.navigationController pushViewController:certify animated:YES];
    
}
// 余额界面跳转
- (void)balButClick {

//    NSLog(@"余额栏界面");
    
    GFBalanceViewController *balVC = [[GFBalanceViewController alloc] init];
    if (![self.bank isKindOfClass:[NSNull class]]) {
        balVC.bank = self.bank;
        balVC.bankCardNo = self.bankCardNo;
        balVC.balance = self.balance;
        balVC.name = self.name;
    }else{
        
    }
    [self.navigationController pushViewController:balVC animated:YES];
}
// 账单界面跳转
- (void)billBut {

//    NSLog(@"账单栏界面");
    GFBillViewController *billVC = [[GFBillViewController alloc] init];
    [self.navigationController pushViewController:billVC animated:YES];
}
// 我的订单界面跳转
- (void)indentButClick {
    
//    NSLog(@"我的订单界面");
    GFIndentViewController *indentVC = [[GFIndentViewController alloc] init];
    
    [self.navigationController pushViewController:indentVC animated:YES];
}
// 修改密码界面跳转
- (void)changePwdButClick {
    
//    NSLog(@"修改密码界面");
    
    GFChangePwdViewController *chagePwdVC = [[GFChangePwdViewController alloc] init];
    [self.navigationController pushViewController:chagePwdVC animated:YES];
    

    
    
}

- (void)exitButClick {
    
//    UIImage *btnNorImg = [UIImage imageNamed:@"delete"];
//    UIImage *btnHigImg = [UIImage imageNamed:@"deleteOrder"];
//    GFAlertView *vv = [[GFAlertView alloc] initWithTipName:@"提示" withTipMessage:@"地方哈说了" withButtonNameArray:@[@"ok"]];
//    GFAlertView *vv = [[GFAlertView alloc] initWithTipName:@"技师：李孟龙" withTipMessage:@"非常厉害的技师，专业贴膜十年，使用的保鲜膜可绕地球三周" withButtonNameArray:@[@"查看订单"] withRightUpButtonImage:btnImg];
//    GFAlertView *vv = [[GFAlertView alloc] initWithTipName:@"技师：李孟龙" withTipMessage:@"非常厉害的技师，专业贴膜十年，使用的保鲜膜可绕地球三周" withButtonNameArray:@[@"查看订单"] withRightUpButtonNormalImage:btnNorImg withRightUpButtonHightImage:btnHigImg];
//    [self.view addSubview:vv];
    
//    [self.navigationController pushViewController:[[GFSignInViewController alloc] init] animated:YES];
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:[[GFSignInViewController alloc] init]];
    navVC.navigationBarHidden = YES;
    window.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    window.rootViewController = navVC;
    [window makeKeyAndVisible];
    
}


- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
