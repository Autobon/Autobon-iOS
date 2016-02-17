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
    msgRightBut.frame = CGRectMake(msgRightButX, msgRightButY, msgRightButW, msgRightButH);
    [msgRightBut setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    msgRightBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [msgView addSubview:msgRightBut];
    // 左边头像
    CGFloat iconImgViewW = kWidth * 0.176;
    CGFloat iconImgViewH = iconImgViewW;
    CGFloat iconImgViewX = jianjv2;
    CGFloat iconImgViewY = (msgRightButH - iconImgViewH) / 2.0;
    UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iconImgViewX, iconImgViewY, iconImgViewW, iconImgViewH)];
    iconImgView.layer.cornerRadius = iconImgViewW / 2.0;
    iconImgView.clipsToBounds = YES;
    iconImgView.contentMode = UIViewContentModeScaleAspectFill;
    iconImgView.image = [UIImage imageNamed:@"11.png"];
    [msgView addSubview:iconImgView];
    // 姓名
    NSString *nameStr = @"陈光法";
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
    // 星星
    for(int i=0; i<5; i++) {
        
        CGFloat starImgViewW = strRect.size.height;
        CGFloat starImgViewH = starImgViewW;
        CGFloat starImgViewX = CGRectGetMaxX(nameLab.frame) + starImgViewW * i;
        CGFloat starImgViewY = nameLabY + 3.5 / 568 * kHeight;
        UIImageView *starImgView = [[UIImageView alloc] initWithFrame:CGRectMake(starImgViewX, starImgViewY, starImgViewW, starImgViewH)];
        starImgView.contentMode = UIViewContentModeScaleAspectFit;
        starImgView.image = [UIImage imageNamed:@"detailsStarDark.png"];
        [msgView addSubview:starImgView];
    }
    for(int i=0; i<3; i++) {
        
        CGFloat starImgViewW = strRect.size.height;
        CGFloat starImgViewH = starImgViewW;
        CGFloat starImgViewX = CGRectGetMaxX(nameLab.frame) + starImgViewW * i;
        CGFloat starImgViewY = nameLabY + 3.5 / 568 * kHeight;
        UIImageView *starImgView = [[UIImageView alloc] initWithFrame:CGRectMake(starImgViewX, starImgViewY, starImgViewW, starImgViewH)];
        starImgView.contentMode = UIViewContentModeScaleAspectFit;
        starImgView.image = [UIImage imageNamed:@"information.png"];
        [msgView addSubview:starImgView];
    }
    // 评分
    NSString *fenStr = @"2.7";
    NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
    fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
    CGFloat fenLabW = fenRect.size.width + 10;
    CGFloat fenLabH = strRect.size.height;
    CGFloat fenLabX = CGRectGetMaxX(nameLab.frame) + strRect.size.height * 5 + jianjv1;
    CGFloat fenLabY = nameLabY + 3.5 / 568 * kHeight;
    UILabel *fenLab = [[UILabel alloc] initWithFrame:CGRectMake(fenLabX, fenLabY, fenLabW, fenLabH)];
    fenLab.textColor = [UIColor whiteColor];
    fenLab.textAlignment = NSTextAlignmentCenter;
    fenLab.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    fenLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    fenLab.text = fenStr;
    fenLab.layer.cornerRadius = 7.5;
    fenLab.clipsToBounds = YES;
    [msgView addSubview:fenLab];
    // 订单数
    CGFloat indentLabW = kWidth * 0.16;
    CGFloat indentLabH = nameLabH;
    CGFloat indentLabX = nameLabX;
    CGFloat indentLabY = CGRectGetMaxY(nameLab.frame);
    UILabel *indentLab = [[UILabel alloc] initWithFrame:CGRectMake(indentLabX, indentLabY, indentLabW, indentLabH)];
    indentLab.text = @"订单数";
    indentLab.font = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
    [msgView addSubview:indentLab];
    NSString *numStr = @"999";
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
    //好评率
    CGFloat goodLabW = indentLabW;
    CGFloat goodLabH = indentLabH;
    CGFloat goodLabX = CGRectGetMaxX(numLab.frame) + jianjv1;
    CGFloat goodLabY = indentLabY;
    UILabel *goodLab = [[UILabel alloc] initWithFrame:CGRectMake(goodLabX, goodLabY, goodLabW, goodLabH)];
    goodLab.text = @"好评率";
    goodLab.font = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
    [msgView addSubview:goodLab];
    NSString *proStr = @"99.99%";
    NSMutableDictionary *proDic = [[NSMutableDictionary alloc] init];
    proDic[NSFontAttributeName] = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
    proDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect proRect = [proStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:proDic context:nil];
    CGFloat proLabW = proRect.size.width;
    CGFloat proLabH = goodLabH;
    CGFloat proLabX = CGRectGetMaxX(goodLab.frame) - 3;
    CGFloat proLabY = goodLabY;
    UILabel *proLab = [[UILabel alloc] initWithFrame:CGRectMake(proLabX, proLabY, proLabW, proLabH)];
    proLab.text = proStr;
    proLab.font = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
    proLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [msgView addSubview:proLab];

    
    
    

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
    
    
    
    
    
    // 修改密码
    CGFloat changePwdViewW = msgViewW;
    CGFloat changePwdViewH = indentViewH;
    CGFloat changePwdViewX = msgViewX;
    CGFloat changePwdViewY = CGRectGetMaxY(indentView.frame) + jiange1;
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
    
    
}

- (void)exitButClick {

    GFAlertView *vv = [[GFAlertView alloc] initWithTipName:@"提示" withTipMessage:@"地方哈说了就看过哈市的高科技啊哈SD卡感觉哈看见帅哥hi就是刚开局把时间可更换" withButtonNameArray:nil];
    
    [self.view addSubview:vv];
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
