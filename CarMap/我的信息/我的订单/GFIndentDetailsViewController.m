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
    jianjv2 = kHeight * 0.013;
    
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
//    CGFloat baseViewH = kHeight * 0.61;
    CGFloat baseViewH = 600;
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
    CGFloat moneyLabY = numberLabY + 3 / 568.0 * kHeight;
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
    CGFloat tipButY = CGRectGetMaxY(self.moneyLab.frame) - 6 / 568.0 * kHeight;
    self.tipBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.tipBut.frame = CGRectMake(tipButX, tipButY, tipButW, tipButH);
    [self.tipBut setTitle:@"未结算" forState:UIControlStateNormal];
    [self.tipBut setTitle:@"已结算" forState:UIControlStateSelected];
    [self.tipBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.tipBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateSelected];
    self.tipBut.titleLabel.font = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
    self.tipBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [baseView addSubview:self.tipBut];
    
    // 边线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(jiange1, CGRectGetMaxY(self.numberLab.frame) - 1, numberLabW, 1)];
    lineView1.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:lineView1];
    
    // 订单图片
    CGFloat photoImgViewW = kWidth - jiange1 * 2;
    CGFloat photoImgViewH = kHeight * 0.2344;
    CGFloat photoImgViewX = jiange1;
    CGFloat photoImgViewY = CGRectGetMaxY(self.numberLab.frame) + jianjv2;
    self.photoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(photoImgViewX, photoImgViewY, photoImgViewW, photoImgViewH)];
    self.photoImgView.image = [UIImage imageNamed:@"orderImage.png"];
    self.photoImgView.backgroundColor = [UIColor greenColor];
    [baseView addSubview:self.photoImgView];
    NSLog(@"%f,,%f,,%f,,%f", photoImgViewX, photoImgViewY, photoImgViewW, photoImgViewH);
    
    // 边线
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(jiange1, CGRectGetMaxY(self.photoImgView.frame) - 1 + jianjv2, numberLabW, 1)];
    lineView2.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:lineView2];
    
    // 下单备注
    CGFloat baseView1W = kWidth - jiange1 * 2;
    CGFloat baseView1H = kHeight * 0.068;
    CGFloat baseView1X = jiange1;
    CGFloat baseView1Y = CGRectGetMaxY(self.photoImgView.frame) + jianjv2;
    UIView *baseView1 = [[UIView alloc] initWithFrame:CGRectMake(baseView1X, baseView1Y, baseView1W, baseView1H)];
    [baseView addSubview:baseView1];
    CGFloat xiadanLabW = kWidth * 0.21;
    CGFloat xiadanLabH = baseView1H * 0.462;
    CGFloat xiadanLabX = 0;
    CGFloat xiadanLabY = baseView1H * 0.269;
    UILabel *xiadanLab = [[UILabel alloc] initWithFrame:CGRectMake(xiadanLabX, xiadanLabY, xiadanLabW, xiadanLabH)];
    xiadanLab.text = @"下单备注：";
    xiadanLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    [baseView1 addSubview:xiadanLab];
    NSString *beizhuStr = @"就发来上课就发顺丰嘎哈是嘎哈是否伽师瓜灵魂搜噶看时间回复尕乱收费伽师打个卡还是家里怪兽的话覅";
    NSMutableDictionary *bezhuDic = [[NSMutableDictionary alloc] init];
    bezhuDic[NSFontAttributeName] = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    bezhuDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect beizhuRect = [beizhuStr boundingRectWithSize:CGSizeMake(baseView1W - xiadanLabW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:bezhuDic context:nil];
    CGFloat beizhuLabW = baseView1W - xiadanLabW;
    CGFloat beizhuLabH = beizhuRect.size.height;
    CGFloat beizhuLabX = CGRectGetMaxX(xiadanLab.frame);
    CGFloat beizhuLabY = xiadanLabY + 1.58 / 568.0 * kHeight;
    self.beizhuLab = [[UILabel alloc] initWithFrame:CGRectMake(beizhuLabX, beizhuLabY, beizhuLabW, beizhuLabH)];
    self.beizhuLab.numberOfLines = 0;
    self.beizhuLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    self.beizhuLab.text = beizhuStr;
    [baseView1 addSubview:self.beizhuLab];
    baseView1.frame = CGRectMake(baseView1X, baseView1Y, baseView1W, beizhuRect.size.height - xiadanLabH + baseView1H);
    
    // 边线
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(jiange1, CGRectGetMaxY(baseView1.frame), numberLabW, 1)];
    lineView3.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:lineView3];
    
    // 施工时间
    CGFloat workDayLabW = baseView1W;
    CGFloat workDayLabH = baseView1H;
    CGFloat workDayLabX = baseView1X;
    CGFloat workDayLabY = CGRectGetMaxY(baseView1.frame);
    self.workDayLab = [[UILabel alloc] initWithFrame:CGRectMake(workDayLabX, workDayLabY, workDayLabW, workDayLabH)];
    self.workDayLab.text = @"施工时间：昨天15:00";
    self.workDayLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    [baseView addSubview:self.workDayLab];
    
    // 边线
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(jiange1, CGRectGetMaxY(self.workDayLab.frame), numberLabW, 1)];
    lineView4.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:lineView4];
    
    
    // 施工耗时
    CGFloat workTimeLabW = workDayLabW;
    CGFloat workTimeLabH = workDayLabH;
    CGFloat workTimeLabX = workDayLabX;
    CGFloat workTimeLabY = CGRectGetMaxY(self.workDayLab.frame);
    self.workTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(workTimeLabX, workTimeLabY, workTimeLabW, workTimeLabH)];
    self.workTimeLab.text = @"施工耗时：1小时30分钟";
    self.workTimeLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    [baseView addSubview:self.workTimeLab];
    
    // 边线
    UIView *lineView5 = [[UIView alloc] initWithFrame:CGRectMake(jiange1, CGRectGetMaxY(self.workTimeLab.frame), numberLabW, 1)];
    lineView5.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:lineView5];
    
    // 施工部位
    CGFloat baseView2W = baseView1W;
    CGFloat baseView2H = baseView1H;
    CGFloat baseView2X = baseView1X;
    CGFloat baseView2Y = CGRectGetMaxY(self.workTimeLab.frame);
    UIView *baseView2 = [[UIView alloc] initWithFrame:CGRectMake(baseView2X, baseView2Y, baseView2W, baseView2H)];
    [baseView addSubview:baseView2];
    // "施工部位"
    CGFloat shigongLabW = kWidth * 0.21;
    CGFloat shigongLabH = baseView2H * 0.462;
    CGFloat shigongLabX = 0;
    CGFloat shigongLabY = baseView2H * 0.269;
    UILabel *shigongLab = [[UILabel alloc] initWithFrame:CGRectMake(shigongLabX, shigongLabY, shigongLabW, shigongLabH)];
    shigongLab.text = @"施工部位：";
    shigongLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    [baseView2 addSubview:shigongLab];
    NSString *buweiStr = @"就发来上课就发顺丰嘎哈是嘎哈是否伽sdhfkljahskdfjakshdgjdhfagjks师瓜灵魂搜噶看时间回复尕乱收费伽师打个卡还是家里怪兽的话覅";
    NSMutableDictionary *buweiDic = [[NSMutableDictionary alloc] init];
    buweiDic[NSFontAttributeName] = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    buweiDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect buweiRect = [buweiStr boundingRectWithSize:CGSizeMake(baseView2W - shigongLabW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:buweiDic context:nil];
    CGFloat carPlaceLabW = baseView2W - shigongLabW;
    CGFloat carPlaceLabH = buweiRect.size.height;
    CGFloat carPlaceLabX = CGRectGetMaxX(shigongLab.frame);
    CGFloat carPlaceLabY = shigongLabY + 1.58 / 568.0 * kHeight;
    self.carPlaceLab = [[UILabel alloc] initWithFrame:CGRectMake(carPlaceLabX, carPlaceLabY, carPlaceLabW, carPlaceLabH)];
    self.carPlaceLab.numberOfLines = 0;
    self.carPlaceLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    self.carPlaceLab.text = buweiStr;
    [baseView2 addSubview:self.carPlaceLab];
    baseView2.frame = CGRectMake(baseView2X, baseView2Y, baseView2W, carPlaceLabH - shigongLabH + baseView2H);

    baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, numberLabH + jianjv2 * 2 + photoImgViewH + beizhuRect.size.height - xiadanLabH + baseView1H + workDayLabH + workTimeLabH + carPlaceLabH - shigongLabH + baseView2H + jianjv1);
    
    // 边线
    UIView *lineView6 = [[UIView alloc] initWithFrame:CGRectMake(jiange1, CGRectGetMaxY(baseView.frame) - 64, numberLabW, 1)];
    lineView6.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:lineView6];
    
    
    
    
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
