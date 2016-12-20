//
//  GFShigongDDViewController.m
//  CarMap
//
//  Created by 陈光法 on 16/12/7.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFShigongDDViewController.h"
#import "GFNavigationView.h"
#import "GFTipView.h"
#import "GFNewOrderModel.h"
#import "CLTitleView.h"

@interface GFShigongDDViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat vvWidth;
    CGFloat vvHeight;
    
    CGFloat maxY;
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) UIScrollView *scView;
@property (nonatomic, strong) NSMutableArray *heightArr;

@property (nonatomic, strong) UIView *lastView;

@property (nonatomic, strong) UILabel *lastLab;

@end

@implementation GFShigongDDViewController

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
    
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.35];
    
    self.heightArr = [[NSMutableArray alloc] init];
    
    // 导航栏
//    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"我的订单" withFrame:CGRectMake(0, 0, kWidth, 64)];
//    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.navView];
}

- (void)_setView {
    maxY = 0;
    vvWidth = [UIScreen mainScreen].bounds.size.width - 60 / 375.0 * [UIScreen mainScreen].bounds.size.width;
    vvHeight = [UIScreen mainScreen].bounds.size.height - 100;
    
    UIScrollView *vv = [[UIScrollView alloc] initWithFrame:CGRectMake(30 / 375.0 * [UIScreen mainScreen].bounds.size.width, 80, vvWidth, vvHeight)];
    vv.backgroundColor = [UIColor whiteColor];
    vv.layer.cornerRadius = 5;
    vv.layer.borderColor = [[UIColor orangeColor] CGColor];
    vv.layer.borderWidth = 1;
    [self.view addSubview:vv];
    self.scView = vv;
    
    UIButton *cancelBut = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBut.frame = CGRectMake(CGRectGetMaxX(vv.frame) - 20, vv.frame.origin.y - 18, 40, 40);
    [cancelBut setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [cancelBut setImage:[UIImage imageNamed:@"deleteOrder"] forState:UIControlStateHighlighted];
//    cancelBut.backgroundColor= [UIColor redColor];
    [self.view addSubview:cancelBut];
    [cancelBut addTarget:self action:@selector(cancelButClcik) forControlEvents:UIControlEventTouchUpInside];
    
    
//    CLTitleView *shigognVIew = [[CLTitleView alloc]initWithFrame:CGRectMake(0, 0, vvWidth, 40) Title:@"施工详情"];
//    [self.scView addSubview:shigognVIew];
    
    NSArray *arr = _model.orderConstructionShow;
    for(int i=0; i<arr.count; i++) {
    
        CGFloat hh = 0;
        for(int j=0; j<self.heightArr.count; j++) {
            CGFloat nn = [self.heightArr[j] floatValue];
            hh = hh + nn;
        }
//        NSLog(@"\\\\\\||||///////%f", hh);
        NSDictionary *dic = arr[i];
        NSString *techName = dic[@"techName"];
        NSArray *projectPositionArr = dic[@"projectPosition"];
        self.lastView = [self _setWithX:0 withY:hh withName:techName withProjectPositionArr:projectPositionArr];
    }
    
    CLTitleView *baofeiView = [[CLTitleView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lastView.frame) - 5, vvWidth, 40) Title:@"材料报废"];
    [self.scView addSubview:baofeiView];
    
    NSArray *baofeiArr = _model.constructionWasteShows;
    for(int i=0; i<baofeiArr.count; i++) {
    
        NSDictionary *dic = baofeiArr[i];
        NSString *nameSS = dic[@"techName"];
        NSString *proSS = dic[@"projectName"];
        NSString *posSS = dic[@"postitionName"];
        NSString *tatalSS = dic[@"total"];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(baofeiView.frame) + 30 * i, vvWidth - 30, 30)];
        lab.font = [UIFont systemFontOfSize:13];
        lab.textColor = [UIColor darkGrayColor];
        lab.text = [NSString stringWithFormat:@"%@     %@      %@ x %@", nameSS, proSS, posSS, tatalSS];
        [self.scView addSubview:lab];
        self.lastLab = lab;
    }
    
    self.scView.contentSize = CGSizeMake(vvWidth, CGRectGetMaxY(self.lastLab.frame) + 20);
    
}

- (UIView *)_setWithX:(CGFloat)x withY:(CGFloat)y withName:(NSString *)name withProjectPositionArr:(NSArray *)ppArr {
    
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(x, y, vvWidth, vvHeight)];
//    vv.backgroundColor = [UIColor greenColor];
    [self.scView addSubview:vv];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, vvWidth - 20, 30)];
    nameLab.font = [UIFont systemFontOfSize:16];
    nameLab.textColor = [UIColor darkGrayColor];
    nameLab.text = name;
    [vv addSubview:nameLab];
//    nameLab.backgroundColor = [UIColor greenColor];
    
    NSMutableArray *mmArr = [[NSMutableArray alloc] init];
    
    for(int i=0; i<ppArr.count; i++) {
    
        CGFloat hh = 0;
        NSDictionary *dic = ppArr[i];
        NSString *str = [NSString stringWithFormat:@"%@：%@", dic[@"project"], dic[@"position"]];
        CGRect strRect = [str boundingRectWithSize:CGSizeMake(vvWidth - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        [mmArr addObject:@(strRect.size.height)];
        for(int j=0; j<mmArr.count; j++) {
//            if(i > 0) {
            
                CGFloat nn = [mmArr[j] floatValue];
                hh = hh + nn + 5;
//            }
        }
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, hh + 30 - strRect.size.height, vvWidth - 40, strRect.size.height)];
        lab.font = [UIFont systemFontOfSize:14];
        lab.textColor = [UIColor darkGrayColor];
        lab.text = [NSString stringWithFormat:@"%@：%@", dic[@"project"], dic[@"position"]];
        lab.numberOfLines = 0;
//        lab.backgroundColor = [UIColor redColor];
        if(i == ppArr.count - 1) {
        
            maxY = hh + strRect.size.height + 30;
            vv.frame = CGRectMake(x, y, vvWidth, maxY);
            
            [self.heightArr addObject:@(maxY)];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, maxY - 5, vvWidth - 20, 1)];
            lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
            [vv addSubview:lineView];
        }
        
        [vv addSubview:lab];
    }
    
    return vv;
}


- (void)cancelButClcik {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
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
