//
//  CLCooperateViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/3/11.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLCooperateFailViewController.h"
#import "GFNavigationView.h"




@interface CLCooperateFailViewController ()

@end

@implementation CLCooperateFailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    
    [self setViewForCooperate];
    
    
}


#pragma mark - 页面设置
- (void)setViewForCooperate{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
//    scrollView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:scrollView];
    
//加盟状态
    UILabel *settingLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 100, 30)];
    settingLabel.text = @"加盟状态：";
    [scrollView addSubview:settingLabel];
    
    UILabel *setLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, 100, 30)];
    setLabel.text = @"失败";
    setLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    setLabel.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:setLabel];
    
//失败原因
    UILabel *failLabel = [[UILabel alloc]init];
    failLabel.text = @"失败原因：失败原因失败原因失败原因失败原因失败原因失败原因";
    failLabel.numberOfLines = 0;
    failLabel.frame = CGRectMake(15, 50, self.view.frame.size.width-30, 60);
    [scrollView addSubview:failLabel];
    
    
// 加盟信息
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, failLabel.frame.origin.y + 60+15, self.view.frame.size.width-30, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [scrollView addSubview:lineView];
    
    
    UILabel *idImageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 20)];
    idImageLabel.center = lineView.center;
    idImageLabel.text = @"加盟信息";
    idImageLabel.textAlignment = NSTextAlignmentCenter;
    idImageLabel.backgroundColor = [UIColor whiteColor];
    idImageLabel.font = [UIFont systemFontOfSize:16];
    idImageLabel.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [scrollView addSubview:idImageLabel];
    
    
// 营业执照名，号；法人姓名，身份证号
    
    UILabel *licenceName = [[UILabel alloc]init];
    licenceName.text = @"营业执照名：北京卡曼车饰有限公司";
    licenceName.frame = CGRectMake(15, lineView.frame.origin.y + 31 , self.view.frame.size.width-30, 30);
    [scrollView addSubview:licenceName];
    
    UILabel *licenceNumber = [[UILabel alloc]init];
    licenceNumber.text = @"营业执照号：420023123515";
    licenceNumber.frame = CGRectMake(15, licenceName.frame.origin.y + 35, self.view.frame.size.width-30, 30);
    [scrollView addSubview:licenceNumber];
    
    
    UILabel *legalEntity = [[UILabel alloc]init];
    legalEntity.text = @"法人的姓名：北京卡曼车饰有限公司";
    legalEntity.frame = CGRectMake(15, licenceNumber.frame.origin.y + 35, self.view.frame.size.width-30, 30);
    [scrollView addSubview:legalEntity];

    
    UILabel *legalEntityId = [[UILabel alloc]init];
    legalEntityId.text = @"法人身份证：42100000000000000001236";
    legalEntityId.frame = CGRectMake(15, legalEntity.frame.origin.y + 35, self.view.frame.size.width-30, 30);
    [scrollView addSubview:legalEntityId];
    
    
// 营业执照副本
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(15, legalEntityId.frame.origin.y + 30+15, self.view.frame.size.width-30, 1)];
    lineView2.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [scrollView addSubview:lineView2];
    
    
    UILabel *licenceDuplicate = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 20)];
    licenceDuplicate.center = lineView2.center;
    licenceDuplicate.text = @"营业执照副本";
    licenceDuplicate.textAlignment = NSTextAlignmentCenter;
    licenceDuplicate.backgroundColor = [UIColor whiteColor];
    licenceDuplicate.font = [UIFont systemFontOfSize:16];
    licenceDuplicate.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [scrollView addSubview:licenceDuplicate];
    
    
    UIImageView *licenceDuplicateImage = [[UIImageView alloc]init];
    licenceDuplicateImage.frame = CGRectMake(30, lineView2.frame.origin.y + 30, self.view.frame.size.width-60, (self.view.frame.size.width-60)*9/14.0);
    licenceDuplicateImage.backgroundColor = [UIColor darkGrayColor];
    [scrollView addSubview:licenceDuplicateImage];
    
// 法人身份证正面照

    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(15, licenceDuplicateImage.frame.origin.y + licenceDuplicateImage.frame.size.height + 30, self.view.frame.size.width-30, 1)];
    lineView3.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [scrollView addSubview:lineView3];
    
    
    UILabel *legalEntityIdLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 20)];
    legalEntityIdLabel.center = lineView3.center;
    legalEntityIdLabel.text = @"法人身份证正面照";
    legalEntityIdLabel.textAlignment = NSTextAlignmentCenter;
    legalEntityIdLabel.backgroundColor = [UIColor whiteColor];
    legalEntityIdLabel.font = [UIFont systemFontOfSize:16];
    legalEntityIdLabel.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [scrollView addSubview:legalEntityIdLabel];
    
    
    UIImageView *legalEntityIdImage = [[UIImageView alloc]init];
    legalEntityIdImage.frame = CGRectMake(30, lineView3.frame.origin.y + 30, self.view.frame.size.width-60, (self.view.frame.size.width-60)*9/14.0);
    legalEntityIdImage.backgroundColor = [UIColor darkGrayColor];
    [scrollView addSubview:legalEntityIdImage];
    
    
// 发票信息
    UIView *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(15, legalEntityIdImage.frame.origin.y + licenceDuplicateImage.frame.size.height + 30, self.view.frame.size.width-30, 1)];
    lineView4.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [scrollView addSubview:lineView4];
    
    
    UILabel *invoiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 20)];
    invoiceLabel.center = lineView4.center;
    invoiceLabel.text = @"发票信息";
    invoiceLabel.textAlignment = NSTextAlignmentCenter;
    invoiceLabel.backgroundColor = [UIColor whiteColor];
    invoiceLabel.font = [UIFont systemFontOfSize:16];
    invoiceLabel.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [scrollView addSubview:invoiceLabel];
    
    
// 发票抬头，纳税识别号，邮政编号
    UILabel *invoiceName = [[UILabel alloc]init];
    invoiceName.text = @"发票抬头名：北京卡曼车饰有限公司";
    invoiceName.frame = CGRectMake(15, lineView4.frame.origin.y + 31 , self.view.frame.size.width-30, 30);
    [scrollView addSubview:invoiceName];
    
    
    UILabel *payNumber = [[UILabel alloc]init];
    payNumber.text = @"纳税识别号：4200231213544";
    payNumber.frame = CGRectMake(15, invoiceName.frame.origin.y + 35 , self.view.frame.size.width-30, 30);
    [scrollView addSubview:payNumber];
    
    UILabel *postcode = [[UILabel alloc]init];
    postcode.text = @"邮政编码号：400101";
    postcode.frame = CGRectMake(15, payNumber.frame.origin.y + 31 , self.view.frame.size.width-30, 30);
    [scrollView addSubview:postcode];
    
    
    UIView *lineView5 = [[UIView alloc]initWithFrame:CGRectMake(15, postcode.frame.origin.y + 40, self.view.frame.size.width-30, 1)];
    lineView5.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    [scrollView addSubview:lineView5];
    
    
// 邮寄地址，商户位置
    
    
    UILabel *addressLabel = [[UILabel alloc]init];
    addressLabel.text = @"邮寄地址：北京市朝阳区某某某位置";
    addressLabel.frame = CGRectMake(15, lineView5.frame.origin.y + 11 , self.view.frame.size.width-30, 30);
    [scrollView addSubview:addressLabel];
    
    
    UILabel *placeLabel = [[UILabel alloc]init];
    placeLabel.text = @"商户位置：北京市朝阳区某某某位置";
    placeLabel.frame = CGRectMake(15, addressLabel.frame.origin.y + 35 , self.view.frame.size.width-30, 30);
    [scrollView addSubview:placeLabel];
    
    
    
// 我要加盟
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(30, placeLabel.frame.origin.y+40, self.view.frame.size.width-60, 40)];
    [addButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [addButton setBackgroundImage:[UIImage imageNamed:@"buttonClick"] forState:UIControlStateHighlighted];
    [addButton setTitle:@"我要加盟" forState:UIControlStateNormal];
//    [changeButton addTarget:self action:@selector(changeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:addButton];
    
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, addButton.frame.origin.y + 80);
}

#pragma mark - 设置导航条
- (void)setNavigation{
    
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"合作商加盟" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
    
    
    //    navView.hidden = YES;
}

-(void)backBtnClick{
//    NSLog(@"个人信息界面");
//    GFMyMessageViewController *myMsgVC = [[GFMyMessageViewController alloc] init];
//    [self.navigationController pushViewController:myMsgVC animated:YES];
    
    
    //    [self receiveNotification:nil];
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
