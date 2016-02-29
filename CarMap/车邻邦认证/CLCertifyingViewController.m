//
//  CertifyingViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/23.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLCertifyingViewController.h"
#import "GFNavigationView.h"
#import "GFHttpTool.h"
#import "UIImageView+WebCache.h"

@interface CLCertifyingViewController ()
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
}
@end

@implementation CLCertifyingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    [self setNavigation];
    
    [self setViewForCertify];
    NSArray *skillArray = @[@"隔热膜",@"隐形车衣",@"车身改色",@"美容清洁"];
    
    [GFHttpTool getCertificateSuccess:^(NSDictionary *responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"result"]intValue]==1) {
            NSDictionary *dataDic = responseObject[@"data"];

// 0,1,2,3
            NSArray *array = [dataDic[@"skill"] componentsSeparatedByString:@","];
            
            [array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
                int a = [obj intValue];
                if (idx == 0) {
                    _skillLabel.text = [NSString stringWithFormat:@"%@%@",_skillLabel.text,skillArray[a]];
                }else{
                    _skillLabel.text = [NSString stringWithFormat:@"%@，%@",_skillLabel.text,skillArray[a]];
                }
            }];
            
            
            
            _userNameLabel.text = dataDic[@"name"];
            _bankNumberLabel.text = [NSString stringWithFormat:@"银行卡号：%@",dataDic[@"bankCardNo"]];
            CGSize titleSize = [_bankNumberLabel.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
            _bankNumberLabel.frame = CGRectMake(15, 250, titleSize.width, 40);
            _line.frame = CGRectMake(15+titleSize.width+5, 260, 1, 20);
            
            _bankLabel.text = dataDic[@"bank"];
            _bankLabel.frame = CGRectMake(15+titleSize.width+10, 250, 60, 40);
            
            
            _identityLabel.text = dataDic[@"idNo"];
            [_headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.40.157.200:51234/%@",dataDic[@"avatar"]]]];
            [_identityImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.40.157.200:51234/%@",dataDic[@"idPhoto"]]]];
            
           
            
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}



- (void)setViewForCertify{
    
    UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 75, 100, 30)];
    stateLabel.text = @"审核状态：";
    stateLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    stateLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:stateLabel];
    
    UILabel *failLabel = [[UILabel alloc]initWithFrame:CGRectMake(95, 75, 100, 30)];
    failLabel.text = @"正在审核";
    failLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    failLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:failLabel];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 115, self.view.frame.size.width-20, 1)];
    view.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [self.view addSubview:view];
    
    
    
    UILabel *certifyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    certifyLabel.center = view.center;
    certifyLabel.text = @"认证信息";
    certifyLabel.textAlignment = NSTextAlignmentCenter;
    certifyLabel.backgroundColor = [UIColor whiteColor];
    certifyLabel.font = [UIFont systemFontOfSize:16];
    certifyLabel.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [self.view addSubview:certifyLabel];
    
    //头像
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(25, 130, 80, 80)];
    _headImage.image = [UIImage imageNamed:@"userHeadImage"];
    _headImage.layer.cornerRadius = 40;
    _headImage.clipsToBounds = YES;
    [self.view addSubview:_headImage];
    
    
    _userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 130, 100, 40)];
    _userNameLabel.text = @"林峰";
    _userNameLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    [self.view addSubview:_userNameLabel];
    
    _identityLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 170, self.view.frame.size.width - 140, 40)];
    _identityLabel.text = @"4200000000231235";
    _identityLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    [self.view addSubview:_identityLabel];
    
    
    
    
    
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(10, 220, self.view.frame.size.width-20, 1)];
    lineView2.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [self.view addSubview:lineView2];
    
    // 技能项目
    _skillLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 220, self.view.frame.size.width-30, 40)];
    _skillLabel.text = @"技能项目：";
    _skillLabel.font = [UIFont systemFontOfSize:14];
    _skillLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    [self.view addSubview:_skillLabel];
    
    _bankNumberLabel = [[UILabel alloc]init];
//    _bankNumberLabel.text = @"银行卡号：1234 1233 1254 1234";
    _bankNumberLabel.font = [UIFont systemFontOfSize:15];
//    _bankNumberLabel.backgroundColor = [UIColor cyanColor];
    _bankNumberLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    [self.view addSubview:_bankNumberLabel];
    
    _bankLabel = [[UILabel alloc]init];
    _bankLabel.text = @"农业银行";
    _bankLabel.font = [UIFont systemFontOfSize:14];
    _bankLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    [self.view addSubview:_bankLabel];
    
    
    _line = [[UIView alloc]init];
    _line.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [self.view addSubview:_line];
    
    
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(10, 300, self.view.frame.size.width-20, 1)];
    lineView3.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [self.view addSubview:lineView3];
    
    
    UILabel *idImageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 30)];
    idImageLabel.center = lineView3.center;
    idImageLabel.text = @"手持身份证正面照";
    idImageLabel.textAlignment = NSTextAlignmentCenter;
    idImageLabel.backgroundColor = [UIColor whiteColor];
    idImageLabel.font = [UIFont systemFontOfSize:16];
    idImageLabel.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [self.view addSubview:idImageLabel];
    // 证件照
    _identityImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 320, self.view.frame.size.width-120, (self.view.frame.size.width-120)*2/3)];
    _identityImageView.image = [UIImage imageNamed:@"userImage"];
    [self.view addSubview:_identityImageView];
    
    
    
    
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
