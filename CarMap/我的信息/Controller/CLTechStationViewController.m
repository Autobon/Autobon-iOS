//
//  CLTechStationViewController.m
//  CarMap
//
//  Created by inCarL on 2019/12/16.
//  Copyright © 2019 mll. All rights reserved.
//

#import "CLTechStationViewController.h"
#import "GFNavigationView.h"
#import "CLStationListViewController.h"

@interface CLTechStationViewController ()
{
    CGFloat kWidth;
    CGFloat kHeight;
}
@property (nonatomic, strong) GFNavigationView *navView;

@end

@implementation CLTechStationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _setBase];
    
    
    [self setViewForDetail];
    
    if (self.stationModel == nil){
        [self rightBtnClick];
    }
    
}

- (void)setViewForDetail{
    
    UILabel *nameLabel = [[UILabel alloc] init];
    if (self.stationModel.coopName == nil){
        nameLabel.text = [NSString stringWithFormat:@"商户名称：%@", @" "];
    }else{
        nameLabel.text = [NSString stringWithFormat:@"商户名称：%@", self.stationModel.coopName];
    }
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.navView.mas_bottom).offset(5);
        make.height.mas_offset(40);
    }];
    UILabel *nameLineLabel = [[UILabel alloc] init];
    nameLineLabel.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    [self.view addSubview:nameLineLabel];
    [nameLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(nameLabel.mas_bottom);
        make.height.mas_offset(0.5);
    }];
    
    UILabel *addressLabel = [[UILabel alloc] init];
    if (self.stationModel.address == nil){
        addressLabel.text = [NSString stringWithFormat:@"商户位置：%@", @""];
    }else{
        addressLabel.text = [NSString stringWithFormat:@"商户位置：%@", self.stationModel.address];
    }
    [self.view addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(nameLabel.mas_bottom).offset(5);
        make.height.mas_offset(40);
    }];
    
    UILabel *addressLineLabel = [[UILabel alloc] init];
    addressLineLabel.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    [self.view addSubview:addressLineLabel];
    [addressLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(addressLabel.mas_bottom);
        make.height.mas_offset(0.5);
    }];
    
    
}


- (void)_setBase {
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:@"" withRightImgHightName:nil withCenterTitle:@"常驻地设置" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.rightBut setTitle:@"修改" forState:UIControlStateNormal];
    self.navView.rightBut.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.navView.rightBut addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)rightBtnClick{
    CLStationListViewController *stationListVC = [[CLStationListViewController alloc]init];
    [self.navigationController pushViewController:stationListVC animated:true];
}

- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
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
