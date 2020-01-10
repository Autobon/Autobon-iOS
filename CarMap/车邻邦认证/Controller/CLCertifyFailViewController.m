//
//  CertifyFailViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/23.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLCertifyFailViewController.h"
#import "GFNavigationView.h"
#import "GFHttpTool.h"
#import "UIImageView+WebCache.h"
#import "CLCertifyViewController.h"
#import "GFTipView.h"



@interface CLCertifyFailViewController ()
{
    
    NSString *_skillString;
    
    
    
    UIImageView *_headImage;
    UILabel *_userNameLabel;
    UILabel *_identityLabel;
    UILabel *_skillLabel;
    UILabel *_bankNumberLabel;
    UILabel *_bankLabel;
    UIImageView *_identityImageView;
    UIView *_line;
    UILabel *_detailLabel;
    
    
}
@end

@implementation CLCertifyFailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigation];
    
    
    
    _detailLabel = [[UILabel alloc]init];
    
    NSArray *skillArray = @[@"隔热膜",@"隐形车衣",@"车身改色",@"美容清洁",@"安全膜",@"其他"];
    
    [GFHttpTool getCertificateSuccess:^(NSDictionary *responseObject) {
//        NSLog(@"%@",responseObject);
        if ([responseObject[@"result"]intValue]==1) {
            NSDictionary *dataDic = responseObject[@"data"];
            
            _detailLabel.text = [NSString stringWithFormat:@"失败原因：%@",dataDic[@"verifyMsg"]];
            _detailLabel.numberOfLines = 0;
            CGSize detailSize = [_detailLabel.text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(self.view.frame.size.width-30, MAXFLOAT)];
            
            _detailLabel.frame = CGRectMake(15, 100, self.view.frame.size.width-30, detailSize.height);
            [self setViewForCertify];
//            NSLog(@"----_datailLabel --%@---size---%f",_detailLabel,detailSize.height);
            
            // 0,1,2,3
            NSArray *array = [dataDic[@"skill"] componentsSeparatedByString:@","];
            _skillLabel.numberOfLines = 0;
            [array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
                int a = [obj intValue] - 1;
                if (idx == 0) {
                    _skillLabel.text = [NSString stringWithFormat:@"%@%@",_skillLabel.text,skillArray[a]];
                }else{
                    _skillLabel.text = [NSString stringWithFormat:@"%@，%@",_skillLabel.text,skillArray[a]];
                }
            }];
            
            
            
            
            
            
            _userNameLabel.text = dataDic[@"name"];
            _bankNumberLabel.text = [NSString stringWithFormat:@"银行卡号：%@",dataDic[@"bankCardNo"]];
            CGSize titleSize = [_bankNumberLabel.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
            _bankNumberLabel.frame = CGRectMake(_bankNumberLabel.frame.origin.x, _bankNumberLabel.frame.origin.y, titleSize.width, 20);
            _line.frame = CGRectMake(13+titleSize.width+5,  _bankNumberLabel.frame.origin.y, 1, 20);
            
            _bankLabel.text = dataDic[@"bank"];
            _bankLabel.frame = CGRectMake(12+titleSize.width+10,  _bankNumberLabel.frame.origin.y, 60, 20);
            
            
            _identityLabel.text = dataDic[@"idNo"];
            [_headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",BaseHttp,dataDic[@"avatar"]]] placeholderImage:[UIImage imageNamed:@"userHeadImage"]];
            [_identityImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",BaseHttp,dataDic[@"idPhoto"]]] placeholderImage:[UIImage imageNamed:@"userImage"]];
            
            
            
        }
    } failure:^(NSError *error) {
//        [self addAlertView:@"请求失败"];
    }];
    
}

#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}


- (void)setViewForCertify{
    
// 创建滑动视图
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:scrollView];
    [self.view sendSubviewToBack:scrollView];
    
    
    
    
    UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 75, 100, 25)];
    stateLabel.text = @"审核状态：";
    stateLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    stateLabel.font = [UIFont systemFontOfSize:16];
    [scrollView addSubview:stateLabel];
    
    UILabel *failLabel = [[UILabel alloc]initWithFrame:CGRectMake(95, 75, 100, 25)];
    failLabel.text = @"失败";
    failLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    failLabel.font = [UIFont systemFontOfSize:16];
    [scrollView addSubview:failLabel];
    
    
    
//    _detailLabel.text = @"失败原因:显示失败原因，原因说明原因说明原因说明原因说明原因说明原因说明";
    _detailLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    _detailLabel.font = [UIFont systemFontOfSize:16];
    [scrollView addSubview:_detailLabel];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, _detailLabel.frame.origin.y + _detailLabel.frame.size.height + 10, self.view.frame.size.width-20, 1)];
    view.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [scrollView addSubview:view];
    
    
    
    UILabel *certifyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    certifyLabel.center = view.center;
    certifyLabel.text = @"认证信息";
    certifyLabel.textAlignment = NSTextAlignmentCenter;
    certifyLabel.backgroundColor = [UIColor whiteColor];
    certifyLabel.font = [UIFont systemFontOfSize:16];
    certifyLabel.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [scrollView addSubview:certifyLabel];
    
//头像
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(25, view.frame.origin.y + 10, 80, 80)];
    _headImage.image = [UIImage imageNamed:@"userHeadImage"];
    _headImage.layer.cornerRadius = 40;
    _headImage.clipsToBounds = YES;
    [scrollView addSubview:_headImage];
    
    
    _userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, view.frame.origin.y + 30, 100, 40)];
//    _userNameLabel.text = @"林峰";
    _userNameLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    [scrollView addSubview:_userNameLabel];
    
    _identityLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, view.frame.origin.y + 55, self.view.frame.size.width - 140, 40)];
    _identityLabel.font = [UIFont systemFontOfSize:16];
    _identityLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    [scrollView addSubview:_identityLabel];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(10, _headImage.frame.origin.y + 90, self.view.frame.size.width-20, 1)];
    lineView2.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [scrollView addSubview:lineView2];
    
// 技能项目
    _skillLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, lineView2.frame.origin.y + 5, self.view.frame.size.width-30, 40)];
    _skillLabel.text = @"技能项目：";
    _skillLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    _skillLabel.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:_skillLabel];
    
    _bankNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, lineView2.frame.origin.y + 50, self.view.frame.size.width-115, 20)];
    _bankNumberLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    _bankNumberLabel.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:_bankNumberLabel];
    
    _bankLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-100, lineView2.frame.origin.y + 50, 100, 20)];
    _bankLabel.text = @"农业银行";
    _bankLabel.font = [UIFont systemFontOfSize:14];
    _bankLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    [scrollView addSubview:_bankLabel];
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-100, lineView2.frame.origin.y + 50+10, 1, 20)];
    _line.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [scrollView addSubview:_line];
    
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(10, _bankLabel.frame.origin.y + 35, self.view.frame.size.width-20, 1)];
    lineView3.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [scrollView addSubview:lineView3];
    
    
    UILabel *idImageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 20)];
    idImageLabel.center = lineView3.center;
    idImageLabel.text = @"手持身份证正面照";
    idImageLabel.textAlignment = NSTextAlignmentCenter;
    idImageLabel.backgroundColor = [UIColor whiteColor];
    idImageLabel.font = [UIFont systemFontOfSize:16];
    idImageLabel.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [scrollView addSubview:idImageLabel];
    
    
// 证件照
    
    _identityImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60, lineView3.frame.origin.y + 20, self.view.frame.size.width-120, (self.view.frame.size.width-120)*2/3-20)];
    _identityImageView.image = [UIImage imageNamed:@"userImage"];
    [scrollView addSubview:_identityImageView];
    
    
// 更改认证信息按钮
    UIButton *changeButton = [[UIButton alloc]initWithFrame:CGRectMake(30, _identityImageView.frame.origin.y+_identityImageView.frame.size.height+10, self.view.frame.size.width-60, 40)];
    [changeButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [changeButton setBackgroundImage:[UIImage imageNamed:@"buttonClick"] forState:UIControlStateHighlighted];
    [changeButton setTitle:@"更改认证信息" forState:UIControlStateNormal];
    [changeButton addTarget:self action:@selector(changeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:changeButton];
    

    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, changeButton.frame.origin.y + 60);
}

- (void)changeBtnClick{
    
    CLCertifyViewController *certifyView = [[CLCertifyViewController alloc]init];
    certifyView.isFail = YES;
    [certifyView.submitButton setTitle:@"再次认证" forState:UIControlStateNormal];
    [self.navigationController pushViewController:certifyView animated:YES];
    
}

// 添加导航
- (void)setNavigation{
    
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"认证进度" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
    
    
    
}

-(void)backBtnClick{
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
