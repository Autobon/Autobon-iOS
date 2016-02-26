//
//  GFIndentDetailsViewController.m
//  CarMap
//
//  Created by 陈光法 on 16/2/25.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFIndentDetailsViewController.h"
#import "GFNavigationView.h"
#import "GFTextField.h"
#import "GFHttpTool.h"

@interface GFIndentDetailsViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jianjv1;
    CGFloat jianjv2;
    
    CGFloat jiange1;
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation GFIndentDetailsViewController

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
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    jianjv1 = kHeight * 0.0183;
    jianjv2 = kHeight * kHeight * 0.013;
    
    jiange1 = kWidth * 0.033;
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"账单" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)_setView {
    
    // 订单信息
    [self _setIndentMessage];
    
    // 评价信息
    [self _setPingjiaMessage];
    
}

- (void)_setIndentMessage {

    CGFloat baseViewW = kWidth;
    CGFloat baseViewH = kHeight * 0.61;
    CGFloat baseViewX = 0;
    CGFloat baseViewY = 64;
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    
    // 订单编号
    CGFloat numberLabW = kWidth - jiange1 * 2;
    CGFloat numberLabH = kHeight * 0.078125;
    CGFloat numberLabX = jiange1;
    CGFloat numberLabY = jianjv1;
    self.numberLab = [[UILabel alloc] initWithFrame:CGRectMake(numberLabX, numberLabY, numberLabW, numberLabH)];
    self.numberLab.text = @"订单编号sdjfhashdfgs";
    self.numberLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    [baseView addSubview:self.numberLab];
    
    // 金额
    CGFloat moneyLabW = 200;
    CGFloat moneyLabH = numberLabH / 2.0;
    CGFloat moneyLabX = kWidth - jiange1 - moneyLabW;
    CGFloat moneyLabY = numberLabY;
    self.moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(moneyLabX, moneyLabY, moneyLabW, moneyLabH)];
    self.moneyLab.text = @"￥200";
    self.moneyLab.textAlignment = NSTextAlignmentRight;
    self.moneyLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
    self.moneyLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    [baseView addSubview:self.moneyLab];
    
    // 结算按钮
    CGFloat tipButW = moneyLabW;
    CGFloat tipButH = moneyLabH;
    CGFloat tipButX = moneyLabX;
    CGFloat tipButY = CGRectGetMaxY(self.moneyLab.frame);
    self.tipBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.tipBut.frame = CGRectMake(tipButX, tipButY, tipButW, tipButH);
    [self.tipBut setTitle:@"未结算" forState:UIControlStateNormal];
    [self.tipBut setTitle:@"已结算" forState:UIControlStateSelected];
    [self.tipBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.tipBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateSelected];
    self.tipBut.titleLabel.font = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
    self.tipBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [baseView addSubview:self.tipBut];
    
    // 订单图片
    CGFloat photoImgViewW = kWidth - jiange1 * 2;
    CGFloat photoImgViewH = kHeight * 0.2344;
    CGFloat photoImgViewX = jiange1;
    CGFloat photoImgViewY = CGRectGetMaxY(self.numberLab.frame) + kHeight * 0.013;
    self.photoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(photoImgViewX, photoImgViewY, photoImgViewW, photoImgViewH)];
    self.photoImgView.image = [UIImage imageNamed:@"orderImage.png"];
    [baseView addSubview:self.photoImgView];
    
    
}

- (void)_setPingjiaMessage {


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
