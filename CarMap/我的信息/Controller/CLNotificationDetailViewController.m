//
//  CLNotificationDetailViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/4/12.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLNotificationDetailViewController.h"
#import "GFNavigationView.h"



@interface CLNotificationDetailViewController ()

@end

@implementation CLNotificationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _setBase];
    
    
    
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.text = _detailModel.titleString;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    CGRect labelRect = [label.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
    
    label.frame = CGRectMake(10, 74, self.view.frame.size.width-20, labelRect.size.height);
    
    [self.view addSubview:label];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.frame = CGRectMake(10, CGRectGetMaxY(label.frame)+10, self.view.frame.size.width-20, 20);
    timeLabel.text = _detailModel.timeString;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.alpha = 0.6;
    [self.view addSubview:timeLabel];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.alpha = 0.8;
    contentLabel.text = [NSString stringWithFormat:@"      %@",_detailModel.contentString];
    
    CGRect lcontentLabelRect = [contentLabel.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    
    contentLabel.frame = CGRectMake(10, CGRectGetMaxY(timeLabel.frame)+20, self.view.frame.size.width-20, lcontentLabelRect.size.height);
    
    [self.view addSubview:contentLabel];
}


- (void)_setBase {
    
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"通知详情" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
    
    
    
}
- (void)leftButClick{
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
