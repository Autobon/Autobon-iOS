//
//  GFServeViewController.m
//  CarMap
//
//  Created by 陈光法 on 16/2/29.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFServeViewController.h"
#import "GFNavigationView.h"
#import "GFTextField.h"
#import "GFHttpTool.h"

@interface GFServeViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
}

@property (nonatomic, strong) GFNavigationView *navView;

@end

@implementation GFServeViewController

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
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"服务中心" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)_setView {
    
    CGFloat baseViewW = kWidth;
    CGFloat baseViewH = 0.2 * kHeight;
    CGFloat baseViewX = 0;
    CGFloat baseViewY = 64 + kHeight * 0.024;
    UIView *baseView = [[UIView alloc] init];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(_navView.mas_bottom);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    CGFloat photoLabW = kWidth - kWidth * 0.06;
    CGFloat photoLabH = baseViewH / 3.0;
    CGFloat photoLabX = kWidth * 0.06;
    CGFloat photoLabY = 0;
    UILabel *photoLab = [[UILabel alloc] initWithFrame:CGRectMake(photoLabX, photoLabY, photoLabW, photoLabH)];
    photoLab.text = @"电话：4001871500";
    photoLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    [baseView addSubview:photoLab];
    
    CGFloat emailLabW = photoLabW;
    CGFloat emailLabH = photoLabH;
    CGFloat emailLabX = photoLabX;
    CGFloat emailLabY = CGRectGetMaxY(photoLab.frame);
    UILabel *emailLab = [[UILabel alloc] initWithFrame:CGRectMake(emailLabX, emailLabY, emailLabW, emailLabH)];
    emailLab.text = @"邮箱：contact@incardata.com.cn";
    emailLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    [baseView addSubview:emailLab];
    
    
    CGFloat addressLabW = photoLabW;
    CGFloat addressLabH = photoLabH;
    CGFloat addressLabX = photoLabX;
    CGFloat addressLabY = CGRectGetMaxY(emailLab.frame);
    UILabel *addressLab = [[UILabel alloc] initWithFrame:CGRectMake(addressLabX, addressLabY, addressLabW, addressLabH)];
    addressLab.text = @"地址：湖北省武汉市洪山区光谷软件园";
    addressLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    [baseView addSubview:addressLab];
    
    // 边线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 1)];
    lineView1.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, photoLabH, kWidth, 1)];
    lineView2.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:lineView2];
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(emailLab.frame), kWidth, 1)];
    lineView3.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:lineView3];
    
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(addressLab.frame), kWidth, 1)];
    lineView4.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:lineView4];
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
