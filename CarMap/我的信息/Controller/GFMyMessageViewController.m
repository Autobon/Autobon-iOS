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

#import "GFNewOrderViewController.h"
#import "GFCertifyFaileViewController.h"
#import "GFCertifyModel.h"

#import "GFDDMessageViewController.h"
#import "CLCommissionViewController.h"
#import "CLCollectViewController.h"
#import "CLStudyViewController.h"
#import "CLTeamManagerViewController.h"
#import "CLMyTeamViewController.h"



@interface GFMyMessageViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jiange1;
    
    CGFloat jianjv1;
    CGFloat jianjv2;

    UIView *_contentView;
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) GFCertifyModel *model;


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
    
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navView.mas_bottom).offset(0);
        make.left.bottom.right.equalTo(self.view).offset(0);
    }];
    
    _contentView = [[UIView alloc]init];
    [scrollView addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(scrollView);
        make.edges.equalTo(scrollView);
    }];
    
    
    
    
    
    // 个人基本信息
    CGFloat msgViewW = kWidth;
    CGFloat msgViewH = kHeight * 0.162;
    CGFloat msgViewX = 0;
    CGFloat msgViewY = 64;
    UIView *msgView = [[UIView alloc] init];
    msgView.backgroundColor = [UIColor whiteColor];
    [_contentView addSubview:msgView];
    
    
    [msgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentView);
        make.top.equalTo(_contentView);
        make.right.equalTo(_contentView);
        make.height.mas_offset(kHeight * 0.162);
    }];
    
    
    
    
    // 边线
    UIView *msgLine = [[UIView alloc] init];
    msgLine.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [msgView addSubview:msgLine];
    [msgLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_contentView);
        make.height.mas_offset(1);
        make.bottom.equalTo(msgView);
    }];
    
    
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
    fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
    CGFloat fenLabW = fenRect.size.width + 10;
    CGFloat fenLabH = strRect.size.height;
    CGFloat fenLabX = CGRectGetMaxX(nameLab.frame) + strRect.size.height * 5 + jianjv1;
    CGFloat fenLabY = numLabY + 3.5 / 568 * kHeight + 1;
    UILabel *fenLab = [[UILabel alloc] initWithFrame:CGRectMake(fenLabX, fenLabY, fenLabW, fenLabH)];
    fenLab.textColor = [UIColor whiteColor];
    fenLab.textAlignment = NSTextAlignmentCenter;
    fenLab.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    fenLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    fenLab.text = fenStr;
    fenLab.layer.cornerRadius = 7.5;
    fenLab.clipsToBounds = YES;
    [msgView addSubview:fenLab];
    
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
    UIView *moneyView = [[UIView alloc] init];
    moneyView.backgroundColor = [UIColor whiteColor];
    [_contentView addSubview:moneyView];
    
    [moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_contentView);
        make.top.equalTo(msgView.mas_bottom).offset(jiange1);
        make.height.mas_equalTo(kHeight*(0.078 + 0.104));
    }];
    
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
    
#pragma mark - 佣金标准
    UIButton *commissionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commissionButton setTitle:@"佣金标准" forState:UIControlStateNormal];
    [commissionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    commissionButton.frame = CGRectMake(_contentView.frame.size.width - 110, moneyImgViewY, 100, moneyImgViewH);
//    commissionButton.backgroundColor = [UIColor cyanColor];
    [commissionButton addTarget:self action:@selector(commissionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [moneyView addSubview:commissionButton];
    
    
    // 余额栏界面
    CGFloat balanceLabUpW = (kWidth - 1) / 2.0;
    CGFloat balanceLabUpH = moneyLineShu.frame.size.height / 2.0;
    CGFloat balanceLabUpX = 0;
    CGFloat balanceLabUpY = moneyLineShu.frame.origin.y - 2;
    UILabel *balanceLabUp = [[UILabel alloc] initWithFrame:CGRectMake(balanceLabUpX, balanceLabUpY, balanceLabUpW, balanceLabUpH)];
    balanceLabUp.textAlignment = NSTextAlignmentCenter;
    balanceLabUp.text = @"0";
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

    
    
    NSArray *imageArray = @[@"order",@"my_team",@"collection",@"information-2",@"editPassword",@"centre",@"study_garden"];
    NSArray *titleArray = @[@"我的订单",@"我的团队",@"我的收藏",@"通知列表",@"修改密码",@"服务中心",@"学习园地"];
    
    for (int i = 0; i < titleArray.count; i++) {
        // baseView
        UIView *baseView = [[UIView alloc] init];
        baseView.backgroundColor = [UIColor whiteColor];
        [_contentView addSubview:baseView];
        [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(moneyView.mas_bottom).offset(20 + 45*i);
            make.height.mas_offset(45);
        }];
        
        // 边线
        UIView *lineUpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
        lineUpView.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [baseView addSubview:lineUpView];
        UIView *collectLineDown = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 1)];
        collectLineDown.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [baseView addSubview:lineUpView];
        // 界面
        CGFloat imgViewW = kWidth * 0.075;
        CGFloat imgViewH = imgViewW;
        CGFloat imgViewX = jianjv1;
        CGFloat imgViewY = (45 - imgViewH) / 2.0;
        UIImageView *collectImgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH)];
        collectImgView.image = [UIImage imageNamed:imageArray[i]];
        [baseView addSubview:collectImgView];
        CGFloat labW = 150;
        CGFloat collectLabH = imgViewH;
        CGFloat collectLabX = CGRectGetMaxX(collectImgView.frame) + jianjv1;
        CGFloat collectLabY = imgViewY;
        UILabel *collectLab = [[UILabel alloc] initWithFrame:CGRectMake(collectLabX, collectLabY, labW, collectLabH)];
        collectLab.text = titleArray[i];
        //    notificationLab.backgroundColor = [UIColor redColor];
        [baseView addSubview:collectLab];
        // 右边箭头
        CGFloat collectRightButW = kWidth * 0.08;
        CGFloat collectRightButH = 45;
        CGFloat collectRightButX = kWidth * 0.92;
        CGFloat collectRightButY = 0;
        UIButton *collectRightBut = [UIButton buttonWithType:UIButtonTypeCustom];
        collectRightBut.frame = CGRectMake(collectRightButX, collectRightButY, collectRightButW, collectRightButH);
        [collectRightBut setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
        collectRightBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [baseView addSubview:collectRightBut];
        // 修改密码界面按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [baseView addSubview:button];
        button.tag = i + 1;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.left.equalTo(baseView).offset(0);
        }];
    }
    
    
    // 退出登录
    UIButton *exitBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitBut setBackgroundColor:[UIColor whiteColor]];
    [exitBut setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitBut setTitleColor:[UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1] forState:UIControlStateNormal];
    exitBut.titleLabel.font = [UIFont systemFontOfSize:16];
//    exitBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_contentView addSubview:exitBut];
    [exitBut addTarget:self action:@selector(exitButClick) forControlEvents:UIControlEventTouchUpInside];
    [exitBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyView.mas_bottom).offset(60 + 45*9);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.mas_offset(45);

        make.bottom.equalTo(_contentView).offset(-20);
    }];
    
    // 边线
//    UIView *exitLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
//    exitLine.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
//    [exitBut addSubview:exitLine];
    
    
    
    // 数据请求
//    NSString *url = @"http://121.40.157.200:12345/api/mobile/technician";
    
    [GFHttpTool messageGetWithParameters:nil success:^(id responseObject) {
        
        
        ICLog(@"个人信息数据＝＝＝＝＝＝＝＝＝%@", responseObject);
        
        NSInteger flage = [responseObject[@"status"] integerValue];
        if(flage == 1) {
            
//            NSLog(@"请求成功++++++个人信息+++++++%@", responseObject);
            NSDictionary *dic = responseObject[@"message"];
            
            NSDictionary *dataDic = dic[@"technician"];
            
            self.model = [[GFCertifyModel alloc] initWithDictionary:dataDic];
            
            NSString *idPhoto = dataDic[@"avatar"];
            NSString *name = dataDic[@"name"];
            NSString *starRate = dic[@"starRate"];
            if([name isKindOfClass:[NSNull class]]) {
                name = [NSString stringWithFormat:@""];
            }
            
            if([starRate isKindOfClass:[NSNull class]]) {
                starRate = [NSString stringWithFormat:@"0"];
            }
            NSString *totalOrders = dic[@"totalOrders"];
            if([totalOrders isKindOfClass:[NSNull class]]) {
                totalOrders = [NSString stringWithFormat:@"0"];
            }
            NSString *balance = dic[@"balance"];
            if([balance isKindOfClass:[NSNull class]]) {
                balance = [NSString stringWithFormat:@"0"];
            }
            NSString *unpaidOrders = dic[@"unpaidOrders"];
            if([unpaidOrders isKindOfClass:[NSNull class]]) {
                unpaidOrders = [NSString stringWithFormat:@"0"];
            }
            
            if([dataDic[@"reference"] isKindOfClass:[NSNull class]]) {
            
                self.model.reference = @"无";
            }else {
            
                self.model.reference = [NSString stringWithFormat:@"%@", dataDic[@"reference"]];
            }
            
            

            
            
            self.bank = dataDic[@"bank"];
            self.bankCardNo = dataDic[@"bankCardNo"];
            self.balance = balance;
            self.name = name;
            self.idString = dataDic[@"id"];
//            NSLog(@"\n%@\n%@\n%@\n%@\n%@\n%@\n", idPhoto, name, starRate, totalOrders, balance, unpaidOrders);
            
            // 头像
//            idPhoto = [NSString stringWithFormat:@"%@%@",URLHOST,idPhoto];
            idPhoto = [NSString stringWithFormat:@"%@%@",BaseHttp, idPhoto];
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
            NSInteger star = (NSInteger)starF;
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
            fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
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
            
            
            if([dataDic[@"resume"] isKindOfClass:[NSNull class]]) {
                
                self.model.resume = @"无";
            }else {
                
                self.model.resume = [NSString stringWithFormat:@"%@", dataDic[@"resume"]];
            }
            
        }else {
        
//            NSLog(@"请求失败+++++++++++++%@", responseObject);
        }
        
    } failure:^(NSError *error) {
//         NSLog(@"请求失败+++++++++++++%@", error);
        [self addAlertView:@"信息请求失败"];
    }];
    
    
    
}


- (void)btnClick:(UIButton *)button{
    switch (button.tag) {
        case 1:
            ICLog(@"我的订单");
            [self indentButClick];
            break;
        case 2:
            ICLog(@"团队管理");
            [self teamManagerBtnClick];
            break;
        case 3:
            ICLog(@"我的收藏");
            [self collectButClick];
            break;
        case 4:
            ICLog(@"通知列表");
            [self notificationButClick];
            break;
        case 5:
            ICLog(@"修改密码");
            [self changePwdButClick];
            break;
        case 6:
            ICLog(@"服务中心");
            [self serveButClick];
            break;
        case 7:
            ICLog(@"学习园地");
            [self studyBtnClick];
            break;
        case 8:
            ICLog(@"我的团队");
            [self myTeamBtnClick];
            break;
        default:
            break;
    }
    
    
}


#pragma mark - 佣金标准
- (void)commissionBtnClick{
    CLCommissionViewController *commissionVC = [[CLCommissionViewController alloc]init];
    [self.navigationController pushViewController:commissionVC animated:YES];
    
    
}


#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}

#pragma mark - 我的收藏按钮响应方法
- (void)collectButClick{
    CLCollectViewController *collectVC = [[CLCollectViewController alloc]init];
    [self.navigationController pushViewController:collectVC animated:YES];
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

#pragma mark - 团队管理
- (void)teamManagerBtnClick{
    CLTeamManagerViewController *teamManagerVC = [[CLTeamManagerViewController alloc]init];
    [self.navigationController pushViewController:teamManagerVC animated:YES];
    
}

#pragma mark - 我的团队
- (void)myTeamBtnClick{
    CLMyTeamViewController *myTeamVC = [[CLMyTeamViewController alloc]init];
    [self.navigationController pushViewController:myTeamVC animated:YES];
    
}

#pragma mark - 学习园地
- (void)studyBtnClick{
    CLStudyViewController *studyVC = [[CLStudyViewController alloc]init];
    [self.navigationController pushViewController:studyVC animated:YES];
    
}


// 信息界面按钮跳转
- (void)msgButClick {

//    CLCertifyViewController *certify = [[CLCertifyViewController alloc]init];
//    certify.isFail = YES;
//    [certify.submitButton setTitle:@"再次认证" forState:UIControlStateNormal];
//    [self.navigationController pushViewController:certify animated:YES];
    

    GFDDMessageViewController *homeVC = [[GFDDMessageViewController alloc] init];
    homeVC.model = self.model;
    [self.navigationController pushViewController:homeVC animated:YES];
    
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
        balVC.idString = self.idString;
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
//    GFIndentViewController *indentVC = [[GFIndentViewController alloc] init];
    GFNewOrderViewController *indentVC = [[GFNewOrderViewController alloc] init];
    
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
