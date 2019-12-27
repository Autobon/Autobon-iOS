//
//  GFDDMessageViewController.m
//  CarMap
//
//  Created by 陈光法 on 16/12/8.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFDDMessageViewController.h"
#import "GFNavigationView.h"
#import "GFHttpTool.h"
#import "UIImageView+WebCache.h"
#import "CLHomeOrderViewController.h"
#import "GFTipView.h"
#import "GFCertifyModel.h"
#import "GFFCertifyViewController.h"

@interface GFDDMessageViewController ()
{
    
    NSString *_skillString;
    
    
    
    UIImageView *_headImage;
    UILabel *_userNameLabel;
    UILabel *_identityLabel;
    UILabel *_tuijianrenLab;
    UILabel *_skillLabel;
    UILabel *_bankNumberLabel;
    UILabel *_bankLabel;
    UIImageView *_identityImageView;
    UIView *_line;
}

@property (nonatomic, strong) UILabel *bankCardLab;
@property (nonatomic, strong) UILabel *bankNameLab;
@property (nonatomic, strong) UILabel *bankAddressLab;
@property (nonatomic, strong) UILabel *jianjieLab;


@property (nonatomic, strong) UIScrollView *scView;

@end

@implementation GFDDMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigation];
    
    [self setViewForCertify];
}
#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}


- (void)setViewForCertify{
    
    [[SDImageCache sharedImageCache] clearDisk];
    
    UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 75, 100, 30)];
    stateLabel.text = @"审核状态：";
    stateLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    stateLabel.font = [UIFont systemFontOfSize:16];
    [_scView addSubview:stateLabel];
    
    UILabel *failLabel = [[UILabel alloc]initWithFrame:CGRectMake(95, 75, 100, 30)];
    failLabel.text = @"已通过";
    failLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    failLabel.font = [UIFont systemFontOfSize:16];
    [_scView addSubview:failLabel];
    
    
//    UILabel *stateLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 105, 100, 30)];
//    stateLabel1.text = @"失败原因：";
//    stateLabel1.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
//    stateLabel1.font = [UIFont systemFontOfSize:16];
//    [_scView addSubview:stateLabel1];
//    
//    NSString *shibaiStr = _model.verifyMsg;
//    CGRect shibaiRect = [shibaiStr boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 125, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
//    UILabel *failLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(95, 110, [UIScreen mainScreen].bounds.size.width - 125, shibaiRect.size.height)];
//    failLabel1.numberOfLines = 0;
//    failLabel1.text = shibaiStr;
//    failLabel1.textColor = [UIColor darkGrayColor];
//    failLabel1.font = [UIFont systemFontOfSize:16];
//    [_scView addSubview:failLabel1];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(failLabel.frame) + 15, self.view.frame.size.width-20, 1)];
    view.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [_scView addSubview:view];
    
    UILabel *certifyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    certifyLabel.center = view.center;
    certifyLabel.text = @"认证信息";
    certifyLabel.textAlignment = NSTextAlignmentCenter;
    certifyLabel.backgroundColor = [UIColor whiteColor];
    certifyLabel.font = [UIFont systemFontOfSize:15];
    certifyLabel.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [_scView addSubview:certifyLabel];
    
    //头像
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(view.frame) + 10, 80, 80)];
    _headImage.image = [UIImage imageNamed:@"userHeadImage"];
    _headImage.layer.cornerRadius = 40;
    _headImage.clipsToBounds = YES;
    //    NSLog(@"===%@", _model.avatar);
    [_headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BaseHttp,_model.avatar]] placeholderImage:[UIImage imageNamed:@"userHeadImage"]];
    [_scView addSubview:_headImage];
    
    
    _userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, CGRectGetMaxY(view.frame) + 10, 100, 30)];
    _userNameLabel.font = [UIFont systemFontOfSize:15];
    _userNameLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    _userNameLabel.text = _model.name;
    [_scView addSubview:_userNameLabel];
    
    _identityLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, CGRectGetMaxY(view.frame) + 10 + 30, self.view.frame.size.width - 140, 30)];
    _identityLabel.text = _model.idNo;
    _identityLabel.font = [UIFont systemFontOfSize:14];
    _identityLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    [_scView addSubview:_identityLabel];
    
    _tuijianrenLab = [[UILabel alloc] initWithFrame:CGRectMake(120, CGRectGetMaxY(view.frame) + 10 + 30 + 30, self.view.frame.size.width - 140, 30)];
    _tuijianrenLab.font = [UIFont systemFontOfSize:14];
    _tuijianrenLab.text = _model.reference;
    _tuijianrenLab.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    [_scView addSubview:_tuijianrenLab];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_headImage.frame) + 10, self.view.frame.size.width-20, 1)];
    lineView2.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [_scView addSubview:lineView2];
    
    
    // 银行卡
    self.bankCardLab = [[UILabel  alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lineView2.frame) + 10, [UIScreen mainScreen].bounds.size.width - 20, 25)];
    self.bankCardLab.font = [UIFont systemFontOfSize:12 / 320.0 * [UIScreen mainScreen].bounds.size.width];
    self.bankCardLab.text = [NSString stringWithFormat:@"银行卡号：%@ | %@", _model.bankCardNo, _model.bank];
    [_scView addSubview:self.bankCardLab];
    
    // 银行卡地址
    self.bankAddressLab = [[UILabel  alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.bankCardLab.frame) + 5, [UIScreen mainScreen].bounds.size.width - 20, 25)];
    self.bankAddressLab.font = [UIFont systemFontOfSize:12 / 320.0 * [UIScreen mainScreen].bounds.size.width];
    self.bankAddressLab.text = [NSString stringWithFormat:@"开户行地址：%@", _model.bankAddress];
    [_scView addSubview:self.bankAddressLab];
    
    // 简介
    NSString *str = [NSString stringWithFormat:@"个人简介：%@", _model.resume];
    CGRect strRect = [str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    self.jianjieLab = [[UILabel  alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.bankAddressLab.frame) + 8, [UIScreen mainScreen].bounds.size.width - 20, strRect.size.height)];
    self.jianjieLab.font = [UIFont systemFontOfSize:12 / 320.0 * [UIScreen mainScreen].bounds.size.width];
    self.jianjieLab.text = str;
    self.jianjieLab.numberOfLines = 0;
    [_scView addSubview:self.jianjieLab];
    
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.jianjieLab.frame) + 23, self.view.frame.size.width-20, 1)];
    lineView3.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [_scView addSubview:lineView3];
    UILabel *idImageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    idImageLabel.center = lineView3.center;
    idImageLabel.text = @"技能项目";
    idImageLabel.textAlignment = NSTextAlignmentCenter;
    idImageLabel.backgroundColor = [UIColor whiteColor];
    idImageLabel.font = [UIFont systemFontOfSize:15];
    idImageLabel.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [_scView addSubview:idImageLabel];
    
    
    [self _setjishiWithX:0 withY:CGRectGetMaxY(idImageLabel.frame) + 10 withXingji:[_model.filmLevel integerValue] withNianxian:_model.filmWorkingSeniority withTitle:@"隔热膜"];
    
    [self _setjishiWithX:0 withY:CGRectGetMaxY(idImageLabel.frame) + 10 + 30 withXingji:[_model.carCoverLevel integerValue] withNianxian:_model.carCoverWorkingSeniority withTitle:@"隐形车衣"];
    
    [self _setjishiWithX:0 withY:CGRectGetMaxY(idImageLabel.frame) + 10 + 30 + 30 withXingji:[_model.colorModifyLevel integerValue] withNianxian:_model.colorModifyWorkingSeniority withTitle:@"车身改色"];
    
    [self _setjishiWithX:0 withY:CGRectGetMaxY(idImageLabel.frame) + 10 + 30 + 30 + 30 withXingji:[_model.beautyLevel integerValue] withNianxian:_model.beautyWorkingSeniority withTitle:@"美容清洁"];
    
    
    UIView *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(idImageLabel.frame) + 23 + 30 + 30 + 30 + 30 + 15, self.view.frame.size.width-20, 1)];
    lineView4.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [_scView addSubview:lineView4];
    UILabel *idImageLabel22 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 20)];
    idImageLabel22.center = lineView4.center;
    idImageLabel22.text = @"手持身份证正面照";
    idImageLabel22.textAlignment = NSTextAlignmentCenter;
    idImageLabel22.backgroundColor = [UIColor whiteColor];
    idImageLabel22.font = [UIFont systemFontOfSize:15];
    idImageLabel22.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [_scView addSubview:idImageLabel22];
    
    
    // 证件照
    _identityImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(idImageLabel22.frame) + 15, self.view.frame.size.width-120, (self.view.frame.size.width-120)*2/3)];
    [_identityImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BaseHttp,_model.idPhoto]] placeholderImage:[UIImage imageNamed:@"userImage"]];
    [_scView addSubview:_identityImageView];
    
    // 更改认证信息
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(45, CGRectGetMaxY(_identityImageView.frame) + 30, [UIScreen mainScreen].bounds.size.width - 90, 40);
    but.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [but setTitle:@"更改认证信息" forState:UIControlStateNormal];
    but.layer.cornerRadius = 5;
    [_scView addSubview:but];
    [but addTarget:self action:@selector(butClick) forControlEvents:UIControlEventTouchUpInside];
    
    _scView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(but.frame) + 40);
    
    
}

- (void)butClick {
    
    GFFCertifyViewController *vvc = [[GFFCertifyViewController alloc] init];
    vvc.isChange = YES;
    [self.navigationController pushViewController:vvc animated:YES];
}

- (void)_setjishiWithX:(CGFloat)x withY:(CGFloat)y withXingji:(NSInteger)xingji withNianxian:(NSString *)nianxian withTitle:(NSString *)title {
    
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width, 30)];
    [_scView addSubview:vv];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 85, 30)];
    lab.text = title;
    lab.textColor = [UIColor darkGrayColor];
    lab.font = [UIFont systemFontOfSize:14];
    [vv addSubview:lab];
    
    for(int i=0; i<5; i++) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame) + 20 / 320.0 * [UIScreen mainScreen].bounds.size.width + 25 * i, 6, 18, 18)];
        img.image = [UIImage imageNamed:@"detailsStarDark"];
        [vv addSubview:img];
    }
    
    for(int i=0; i<xingji; i++) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame) + 20 / 320.0 * [UIScreen mainScreen].bounds.size.width + 25 * i, 6, 18, 18)];
        img.image = [UIImage imageNamed:@"detailsStar"];
        [vv addSubview:img];
    }
    
    UILabel *rightLab = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 75, 0, 60, 30)];
    rightLab.textColor = [UIColor colorWithRed:231 / 255.0 green:97 / 255.0 blue:30 / 255.0 alpha:1];
    rightLab.text = [NSString stringWithFormat:@"%@年", nianxian];;
    rightLab.font =[UIFont systemFontOfSize:14];
    rightLab.textAlignment = NSTextAlignmentRight;
    [vv addSubview:rightLab];
}

// 添加导航
- (void)setNavigation{
    
    _scView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 20)];
    [self.view addSubview:_scView];
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"个人信息" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
}

-(void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
    
    //    CLHomeOrderViewController *home = [[CLHomeOrderViewController alloc]init];
    //    [self.navigationController pushViewController:home animated:YES];
    
    
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
