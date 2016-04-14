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

#import "GFIndentViewController.h"
#import "GFIndentModel.h"

#import "UIImageView+WebCache.h"

@interface GFIndentDetailsViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
    
    CGFloat jianjv1;
    CGFloat jianjv2;
    CGFloat jianjv3;
    CGFloat jianjv4;
    
    CGFloat jiange1;
    CGFloat jiange2;

    
    CGFloat upBaseViewH;
    CGFloat downBaseViewH;
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
    jianjv3 = kHeight * 0.02865;
    jianjv4 = kHeight * 0.02;
    
    jiange1 = kWidth * 0.033;
    jiange2 = kWidth * 0.065;
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"详情" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)_setView {
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64)];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
//    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    
    
    
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
    CGFloat baseViewY = 0;
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:baseView];
    
    // 订单编号
    CGFloat numberLabW = kWidth - jiange1 * 2;
    CGFloat numberLabH = kHeight * 0.078125;
    CGFloat numberLabX = jiange1;
    CGFloat numberLabY = jianjv1;
    self.numberLab = [[UILabel alloc] initWithFrame:CGRectMake(numberLabX, numberLabY, numberLabW, numberLabH)];
    self.numberLab.text = [NSString stringWithFormat:@"订单编号%@", self.model.orderNum];
    self.numberLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    [baseView addSubview:self.numberLab];
    
    // 金额
    CGFloat moneyLabW = 200;
    CGFloat moneyLabH = numberLabH / 2.0;
    CGFloat moneyLabX = kWidth - jiange1 - moneyLabW;
    CGFloat moneyLabY = numberLabY + 3 / 568.0 * kHeight;
    self.moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(moneyLabX, moneyLabY, moneyLabW, moneyLabH)];
    self.moneyLab.text = [NSString stringWithFormat:@"￥%@", self.model.payment];
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
    // 判断订单是否结算
    NSInteger jisuanNum = (NSInteger)[self.model.payStatus integerValue];
    if(jisuanNum == 0 || jisuanNum == 1) {
        self.tipBut.selected = NO;
    }else {
        self.tipBut.selected = YES;
    }
    
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
//    self.photoImgView.backgroundColor = [UIColor greenColor];
    self.photoImgView.contentMode = UIViewContentModeScaleAspectFit;
    [baseView addSubview:self.photoImgView];
    NSLog(@"%f,,%f,,%f,,%f", photoImgViewX, photoImgViewY, photoImgViewW, photoImgViewH);
    NSURL *imgUrl = [NSURL URLWithString:self.model.photo];
    [self.photoImgView sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"orderImage.png"]];
    
    
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
    NSString *beizhuStr = [NSString stringWithFormat:@"%@", self.model.remark];
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
    if ([self.model.remark isKindOfClass:[NSNull class]]) {
        self.beizhuLab.text = @"";
    }else{
        self.beizhuLab.text = beizhuStr;
    }
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
    
    if ([self.moneyLab.text isEqualToString:@"￥0"]) {
        self.workDayLab.text = @"施工时间：无";
    }else{
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.model.signinTime floatValue]/1000];
        self.workDayLab.text = [NSString stringWithFormat:@"施工时间：%@", [formatter stringFromDate:date]];
    }
    
    
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
    self.workTimeLab.text = [NSString stringWithFormat:@"施工耗时：%@", self.model.workTime];
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
    NSString *buweiStr = self.workItems;
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
    UIView *lineView6 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(baseView.frame), numberLabW + jiange1 * 2, 1)];
    lineView6.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:lineView6];
    
    
    upBaseViewH = baseView.frame.size.height;
    
}

- (void)_setPingjiaMessage {

    CGFloat baseViewW = kWidth;
    CGFloat baseViewH = 500;
    CGFloat baseViewX = 0;
    CGFloat baseViewY = upBaseViewH + jianjv1;
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:baseView];
    
    // 评价
    CGFloat baseView_1W = kWidth;
    CGFloat baseView_1H = kHeight * 0.078125;
    CGFloat baseView_1X = 0;
    CGFloat baseView_1Y = 0;
    UIView *baseView_1 = [[UIView alloc] initWithFrame:CGRectMake(baseView_1X, baseView_1Y, baseView_1W, baseView_1H)];
    [baseView addSubview:baseView_1];
    // 竖条
    CGFloat shuViewW = 3.5 / 320.0 * kWidth;
    CGFloat shuViewH = baseView_1H;
    CGFloat shuViewX = 0;
    CGFloat shuViewY = 0;
    UIView *shuView = [[UIView alloc] initWithFrame:CGRectMake(shuViewX, shuViewY, shuViewW, shuViewH)];
    shuView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [baseView_1 addSubview:shuView];
    // “评价”
    CGFloat pingjiaLabW = 300;
    CGFloat pingjiaLabH = baseView_1H;
    CGFloat pingjiaLabX = jiange2;
    CGFloat pingjiaLabY = 0;
    UILabel *pingjiaLab = [[UILabel alloc] initWithFrame:CGRectMake(pingjiaLabX, pingjiaLabY, pingjiaLabW, pingjiaLabH)];
    pingjiaLab.text = @"评价";
    pingjiaLab.font = [UIFont systemFontOfSize:15.5 /320.0 * kWidth];
    [baseView_1 addSubview:pingjiaLab];
    
    // 边线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(baseView_1.frame) - 1, kWidth, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:lineView];
    
    
    if ([_model.commentDictionary isKindOfClass:[NSNull class]]) {
        // 其他意见和建议
        
        UILabel *otherLabel = [[UILabel alloc]init];
        otherLabel.text = @"暂无评价";
        otherLabel.frame = CGRectMake(0, lineView.frame.origin.y + 5, self.view.frame.size.width, 40);
        otherLabel.textAlignment = NSTextAlignmentCenter;
        baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewH, downBaseViewH);
        [baseView addSubview:otherLabel];
        
        
        self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(baseView.frame)+30);
    }else{
        // 星星
        for(int i=0; i<5; i++) {
            
            CGFloat imgViewW = (kWidth - kWidth * 0.25 * 2) / 5.0;
            CGFloat imgViewH = imgViewW - 4 / 320.0 * kWidth;
            CGFloat imgViewX = kWidth * 0.21 + (imgViewW + 1 / 320.0 * kWidth) * i;
            CGFloat imgViewY = jianjv3 + CGRectGetMaxY(baseView_1.frame);
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH)];
            [baseView addSubview:imgView];
            imgView.image = [UIImage imageNamed:@"detailsStarDark.png"];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
        }
        
        for(int i=0; i<[_model.commentDictionary[@"star"] integerValue]; i++) {
            
            CGFloat imgViewW = (kWidth - kWidth * 0.25 * 2) / 5.0;
            CGFloat imgViewH = imgViewW - 4 / 320.0 * kWidth;
            CGFloat imgViewX = kWidth * 0.21 + (imgViewW + 1 / 320.0 * kWidth) * i;
            CGFloat imgViewY = jianjv3 + CGRectGetMaxY(baseView_1.frame);
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH)];
            [baseView addSubview:imgView];
            imgView.image = [UIImage imageNamed:@"information.png"];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
        }
        
        // 准时到达
        UIView *daodaView = [self messageButView:@"准时到达" withSelected:[_model.commentDictionary[@"arriveOnTime"] integerValue] withX:jiange2 withY:CGRectGetMaxY(baseView_1.frame) + jianjv3 * 2 + jianjv4 + (kWidth - kWidth * 0.25 * 2) / 5.0 - 4 / 320.0 * kWidth];
        [baseView addSubview:daodaView];
        
        // 准时完工
        UIView *wangongView = [self messageButView:@"准时完工" withSelected:[_model.commentDictionary[@"completeOnTime"] integerValue] withX:kWidth * 0.676 withY:CGRectGetMaxY(baseView_1.frame) + jianjv3 * 2 + jianjv4 + (kWidth - kWidth * 0.25 * 2) / 5.0 - 4 / 320.0 * kWidth];
        [baseView addSubview:wangongView];
        
        // 技术专业
        UIView *zhuanyeView = [self messageButView:@"技术专业" withSelected:[_model.commentDictionary[@"professional"] integerValue] withX:jiange2 withY:CGRectGetMaxY(wangongView.frame) + jianjv4];
        [baseView addSubview:zhuanyeView];
        
        // 着装整洁
        UIView *zhengjieView = [self messageButView:@"着装整洁" withSelected:[_model.commentDictionary[@"dressNeatly"] integerValue] withX:kWidth * 0.676 withY:CGRectGetMaxY(wangongView.frame) + jianjv4];
        [baseView addSubview:zhengjieView];
        
        // 车辆保护超级棒
        UIView *bangView = [self messageButView:@"车辆保护超级棒" withSelected:[_model.commentDictionary[@"carProtect"] integerValue] withX:jiange2 withY:CGRectGetMaxY(zhengjieView.frame) + jianjv4];
        [baseView addSubview:bangView];
        
        // 态度好
        UIView *haoView = [self messageButView:@"态度好" withSelected:[_model.commentDictionary[@"goodAttitude"] integerValue] withX:kWidth * 0.676 withY:CGRectGetMaxY(zhengjieView.frame) + jianjv4];
        [baseView addSubview:haoView];
        
        // 边线
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(jiange1, CGRectGetMaxY(haoView.frame) - 1 + jianjv3, kWidth - jiange1 * 2, 1)];
        lineView2.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [baseView addSubview:lineView2];
        
        // 其他意见和建议
        NSString *fenStr = _model.commentDictionary[@"advice"];
        NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
        fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake(kWidth - jiange2 * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
        CGFloat otherLabW = kWidth - jiange2 * 2;
        CGFloat otherLabH = fenRect.size.height;
        CGFloat otherLabX = jiange2;
        CGFloat otherLabY = CGRectGetMaxY(lineView2.frame) + jianjv4;
        UILabel *otherLab = [[UILabel alloc] initWithFrame:CGRectMake(otherLabX, otherLabY, otherLabW, otherLabH)];
        otherLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        otherLab.text = fenStr;
        otherLab.numberOfLines = 0;
        //    otherLab.backgroundColor = [UIColor redColor];
        [baseView addSubview:otherLab];
        
        downBaseViewH = CGRectGetMaxY(otherLab.frame) + jianjv4;
        baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewH, downBaseViewH);
        
        self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(baseView.frame)+30);
    }
    
    
}

- (UIView *)messageButView:(NSString *)messageStr withSelected:(BOOL)select withX:(CGFloat)x withY:(CGFloat)y{
    
    UIButton *imgBut = [UIButton buttonWithType:UIButtonTypeCustom];
    imgBut.frame = CGRectMake(0, 0, kWidth * 0.051, kWidth * 0.051);
    [imgBut setImage:[UIImage imageNamed:@"over.png"] forState:UIControlStateNormal];
    [imgBut setImage:[UIImage imageNamed:@"overClick.png"] forState:UIControlStateSelected];
    imgBut.selected = select;
    
    NSString *fenStr = messageStr;
    NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
    fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
    CGFloat labW = fenRect.size.width;
    CGFloat labH = kWidth * 0.051;
    CGFloat labX = jiange1 / 2.0 + kWidth * 0.051;
    CGFloat labY = 0;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(labX, labY, labW, labH)];
    lab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
    lab.text = messageStr;
    
    CGFloat baseViewW = labX + labW;
    CGFloat baseViewH = labH;
    CGFloat baseViewX = x;
    CGFloat baseViewY = y;
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
    
    [baseView addSubview:imgBut];
    [baseView addSubview:lab];

    return baseView;
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
