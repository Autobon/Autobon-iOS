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

#import "MYImageView.h"
#import "CLImageView.h"

#import "GFIndentViewController.h"
#import "GFIndentModel.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "GFNewOrderModel.h"
#import "HZPhotoBrowser.h"
#import "GFShigongDDViewController.h"
#import "GFTipView.h"
#import "ACETelPrompt.h"


@interface GFIndentDetailsViewController ()<HZPhotoBrowserDelegate> {
    
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
    
    CGFloat beMaxY;
    CGFloat afMaxY;
    
    NSMutableArray *beforeImageArray;
    NSMutableArray *afterImageArray;
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *photoArr;

@property (nonatomic, strong) NSMutableArray *allPhotoUrlArr;
@property (nonatomic, strong) NSArray *curPhoto;;

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
    
    self.allPhotoUrlArr = [[NSMutableArray alloc] init];
    
    _photoArr = [_model.photo componentsSeparatedByString:@","];
    NSArray *beforePhoto = [_model.beforePhotos componentsSeparatedByString:@","];
    NSArray *afterPhoto = [_model.afterPhotos componentsSeparatedByString:@","];
    self.curPhoto = _photoArr;
    
    [self.allPhotoUrlArr addObject:_photoArr];
    [self.allPhotoUrlArr addObject:beforePhoto];
    [self.allPhotoUrlArr addObject:afterPhoto];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
//    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.navView.mas_bottom);
    }];
    
    // 订单信息
    [self _setIndentMessage];
    
    // 评价信息
    [self _setPingjiaMessage];
    
}

- (void)imgViewButClick:(UIButton *)sender {
    
//    NSLog(@"---tupiande de index %ld", sender.tag - 1);
    
    if([sender.titleLabel.text isEqualToString:@"订单"]) {
    
        self.curPhoto = self.allPhotoUrlArr[0];
    }else if([sender.titleLabel.text isEqualToString:@"施工前"]) {
        
        self.curPhoto = self.allPhotoUrlArr[1];
    }else {
        
        self.curPhoto = self.allPhotoUrlArr[2];
    }
    
    HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
    
    browser.sourceImagesContainerView = sender.superview;
    
    browser.imageCount = self.curPhoto.count;
    
    browser.currentImageIndex = sender.tag - 1;
    
    browser.delegate = self;
    
    [browser show]; // 展示图片浏览器
}
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    
    UIImage *img = [UIImage imageNamed:@"orderImage"];
    
    return img;
}
- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseHttp, self.curPhoto[index]]];
    
    return url;
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
    self.numberLab.text = [NSString stringWithFormat:@"订单编号：%@", self.model.orderNum];
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
    self.tipLabel = [[UILabel alloc]init];
    self.tipLabel.frame = CGRectMake(tipButX, tipButY, tipButW, tipButH);
//    [self.tipBut setTitle:@"未结算" forState:UIControlStateNormal];
//    [self.tipBut setTitle:@"已结算" forState:UIControlStateSelected];
//    [self.tipBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.tipBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateSelected];
    self.tipLabel.font = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
    self.tipLabel.textAlignment = NSTextAlignmentRight;
    [baseView addSubview:self.tipLabel];
    if([_model.payStatus integerValue] == 1) {
        
        self.tipLabel.text = @"未结算";
        self.tipLabel.textColor = [UIColor lightGrayColor];
        self.moneyLab.text = [NSString stringWithFormat:@"￥ %@", _model.payment];
    }else if(([_model.payment integerValue] == 0)){
        
        self.tipLabel.text = @"待计算";
        self.tipLabel.textColor = [UIColor lightGrayColor];
        self.moneyLab.text = @"无";
    }else {
        
        self.tipLabel.text = @"已结算";
        self.tipLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        self.moneyLab.text = [NSString stringWithFormat:@"￥ %@", _model.payment];
    }
    
    
    // 边线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(jiange1, CGRectGetMaxY(self.numberLab.frame) - 1, numberLabW, 1)];
    lineView1.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:lineView1];
    
    
    // 订单图片
    _photoArr = [_model.photo componentsSeparatedByString:@","];
    CGFloat butW = ([UIScreen mainScreen].bounds.size.width - 40) / 3.0;
    CGFloat butH = butW;
    CGFloat maxY = 0;
    for(int i=0; i<_photoArr.count; i++) {
        
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.backgroundColor = [UIColor redColor];
        but.frame = CGRectMake(10 + (butW + 10) * (i % 3), lineView1.frame.origin.y + 7 + (butH + 10) * (i / 3), butW, butH);
        [but sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BaseHttp,_photoArr[i]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"orderImage"]];
        but.clipsToBounds = YES;
        but.tag = i + 1;
        [but setTitle:@"订单" forState:UIControlStateNormal];
        [but setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [_scrollView addSubview:but];
        [but addTarget:self action:@selector(imgViewButClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if(i == _photoArr.count - 1) {
            
            maxY = CGRectGetMaxY(but.frame);
        }
    }
    
//    // 订单图片
//    CGFloat photoImgViewW = kWidth - jiange1 * 2;
//    CGFloat photoImgViewH = kHeight * 0.2344;
//    CGFloat photoImgViewX = jiange1;
//    CGFloat photoImgViewY = CGRectGetMaxY(self.numberLab.frame) + jianjv2;
//    self.photoImgView = [[CLImageView alloc] initWithFrame:CGRectMake(photoImgViewX, photoImgViewY, photoImgViewW, photoImgViewH)];
//    self.photoImgView.image = [UIImage imageNamed:@"orderImage.png"];
////    self.photoImgView.backgroundColor = [UIColor greenColor];
//    self.photoImgView.contentMode = UIViewContentModeScaleAspectFit;
//    [baseView addSubview:self.photoImgView];
////    NSLog(@"%f,,%f,,%f,,%f", photoImgViewX, photoImgViewY, photoImgViewW, photoImgViewH);
//    NSURL *imgUrl = [NSURL URLWithString:self.model.photo];
//    [self.photoImgView sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"orderImage.png"]];
    
    
    // 边线
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(jiange1, maxY - 1 + jianjv2, numberLabW, 1)];
    lineView2.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:lineView2];
    
    // 下单备注
    CGFloat baseView1W = kWidth - jiange1 * 2;
    CGFloat baseView1H = kHeight * 0.068;
    CGFloat baseView1X = jiange1;
    CGFloat baseView1Y = maxY + jianjv2;
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
    self.beizhuLab.text = beizhuStr;
    [baseView1 addSubview:self.beizhuLab];
    baseView1.frame = CGRectMake(baseView1X, baseView1Y, baseView1W, beizhuRect.size.height - xiadanLabH + baseView1H);
    
    // 边线
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(jiange1, CGRectGetMaxY(baseView1.frame), numberLabW, 1)];
    lineView3.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:lineView3];
    
    // 订单类型
    CGFloat indTypeLabW = baseView1W;
    CGFloat indTypeLabH = baseView1H;
    CGFloat indTypeLabX = baseView1X;
    CGFloat indTypeLabY = CGRectGetMaxY(lineView3.frame);
    self.indTypeLab = [[UILabel alloc] initWithFrame:CGRectMake(indTypeLabX, indTypeLabY, indTypeLabW, indTypeLabH)];
    self.indTypeLab.text = [NSString stringWithFormat:@"订单类型：%@", _model.typeName];
    self.indTypeLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    [baseView addSubview:self.indTypeLab];
    
    // 边线
    UIView *lineView8 = [[UIView alloc] initWithFrame:CGRectMake(jiange1, CGRectGetMaxY(self.indTypeLab.frame), numberLabW, 1)];
    lineView8.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:lineView8];

    
    // 商户名称
    CGFloat baseView2W = baseView1W;
    CGFloat baseView2H = baseView1H;
    CGFloat baseView2X = baseView1X;
    CGFloat baseView2Y = CGRectGetMaxY(self.indTypeLab.frame);
    UIView *baseView2 = [[UIView alloc] initWithFrame:CGRectMake(baseView2X, baseView2Y, baseView2W, baseView2H)];
    [baseView addSubview:baseView2];
    // "商户名称"
    CGFloat shigongLabW = kWidth * 0.21;
    CGFloat shigongLabH = baseView2H * 0.462;
    CGFloat shigongLabX = 0;
    CGFloat shigongLabY = baseView2H * 0.269;
    UILabel *shigongLab = [[UILabel alloc] initWithFrame:CGRectMake(shigongLabX, shigongLabY, shigongLabW, shigongLabH)];
    shigongLab.text = @"商户名称：";
    shigongLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    [baseView2 addSubview:shigongLab];
    NSString *buweiStr = self.model.coopName;
    NSMutableDictionary *buweiDic = [[NSMutableDictionary alloc] init];
    buweiDic[NSFontAttributeName] = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    buweiDic[NSForegroundColorAttributeName] = [UIColor blackColor];
//    NSLog(@"--商户名称：---%@", buweiStr);
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
    
// 收藏按钮
    UIButton *collectButton = [[UIButton alloc]init];
    [collectButton setTitle:@"收藏" forState:UIControlStateNormal];
    [collectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [baseView2 addSubview:collectButton];
    collectButton.frame = CGRectMake(baseView1W - 50, 10, 50, kHeight * 0.068 - 20 );
    [collectButton addTarget:self action:@selector(collectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    collectButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    
    [collectButton setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    collectButton.layer.borderWidth = 1;
    collectButton.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    collectButton.layer.cornerRadius = 3;
    
    
    
    // 边线
    UIView *lineView7 = [[UIView alloc] initWithFrame:CGRectMake(jiange1, CGRectGetMaxY(baseView2.frame), numberLabW, 1)];
    lineView7.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:lineView7];

    
    // 联系方式
    CGFloat phoneLabW = baseView1W;
    CGFloat phoneLabH = baseView1H;
    CGFloat phoneLabX = baseView1X;
    CGFloat phoneLabY = CGRectGetMaxY(baseView2.frame);
    UILabel *phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(phoneLabX, phoneLabY, phoneLabW, phoneLabH)];
    phoneLab.text = [NSString stringWithFormat:@"联系方式：%@", _model.contactPhone];
    phoneLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    [baseView addSubview:phoneLab];
    
    // 边线
    UIView *lineView5 = [[UIView alloc] initWithFrame:CGRectMake(jiange1, CGRectGetMaxY(phoneLab.frame), numberLabW, 1)];
    lineView5.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:lineView5];
    
    
    UIButton *phoneButton = [[UIButton alloc]init];
    [phoneButton setImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
    [_scrollView addSubview:phoneButton];
    [phoneButton addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    phoneButton.frame = CGRectMake(self.view.frame.size.width - baseView1H *2 , phoneLabY , baseView1H *2 , baseView1H);
    
    
    
    // 施工人员
    CGFloat workerLabW = baseView1W;
    CGFloat workerLabH = baseView1H;
    CGFloat workerLabX = baseView1X;
    CGFloat workerLabY = CGRectGetMaxY(lineView5.frame);
    self.workerLab = [[UILabel alloc] initWithFrame:CGRectMake(workerLabX, workerLabY, workerLabW, workerLabH)];
    self.workerLab.text = [NSString stringWithFormat:@"施工人员：%@", _model.jishiAllName];
    self.workerLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    [baseView addSubview:self.workerLab];
    
    // 边线
    UIView *lineView6 = [[UIView alloc] initWithFrame:CGRectMake(jiange1, CGRectGetMaxY(self.workerLab.frame), numberLabW, 1)];
    lineView6.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:lineView6];

    
    
    // 施工时间
    CGFloat workDayLabW = baseView1W;
    CGFloat workDayLabH = baseView1H;
    CGFloat workDayLabX = baseView1X;
    CGFloat workDayLabY = CGRectGetMaxY(self.workerLab.frame);
    self.workDayLab = [[UILabel alloc] initWithFrame:CGRectMake(workDayLabX, workDayLabY, workDayLabW, workDayLabH)];
    self.workDayLab.text = [NSString stringWithFormat:@"施工时间：%@", _model.startTime];
    self.workDayLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
    [baseView addSubview:self.workDayLab];
//    self.workDayLab.backgroundColor = [UIColor redColor];
    
//    NSLog(@"-----%@－－－－",_model.orderStatus);
    // 判断订单是否结算
    /*
    if ([_model.payStatus isEqualToString:@"FINISHED"]||[_model.payStatus isEqualToString:@"COMMENTED"]) {
        // 是否结算
        NSInteger jisuanNum = (NSInteger)[_model.payStatus integerValue];
        if(jisuanNum == 0 || jisuanNum == 1) {
            _tipLabel.text = @"未结算";
        }else {
            _tipLabel.text = @"已结算";
        }
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.model.startTime floatValue]/1000];
        self.workDayLab.text = [NSString stringWithFormat:@"施工时间：%@", [formatter stringFromDate:date]];
    }else if([_model.payStatus isEqualToString:@"CANCELED"]){
        _tipLabel.text = @"已撤消";
        self.carPlaceLab.text = @"无";
        self.workDayLab.text = @"施工时间：无";
    }else if([_model.payStatus isEqualToString:@"GIVEN_UP"]){
        _tipLabel.text = @"已放弃";
        self.carPlaceLab.text = @"无";
        self.workDayLab.text = @"施工时间：无";
    }else if([_model.payStatus isEqualToString:@"EXPIRED"]){
        _tipLabel.text = @"已超时";
        self.carPlaceLab.text = @"无";
        self.workDayLab.text = @"施工时间：无";
    }
    */
    
    
    
    // 边线
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(jiange1, CGRectGetMaxY(self.workDayLab.frame), numberLabW, 1)];
    lineView4.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:lineView4];
    
    
//    // 施工耗时
//    CGFloat workTimeLabW = workDayLabW;
//    CGFloat workTimeLabH = workDayLabH;
//    CGFloat workTimeLabX = workDayLabX;
//    CGFloat workTimeLabY = CGRectGetMaxY(self.workDayLab.frame);
//    self.workTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(workTimeLabX, workTimeLabY, workTimeLabW, workTimeLabH)];
//    self.workTimeLab.text = [NSString stringWithFormat:@"施工耗时："];
//    self.workTimeLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
//    [baseView addSubview:self.workTimeLab];
//    
//    // 边线
//    UIView *lineView9 = [[UIView alloc] initWithFrame:CGRectMake(jiange1, CGRectGetMaxY(self.workTimeLab.frame), numberLabW, 1)];
//    lineView9.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
//    [baseView addSubview:lineView9];
    
    // 查看施工详情
    UIButton *chakanBut = [UIButton buttonWithType:UIButtonTypeCustom];
    chakanBut.frame = CGRectMake(0, CGRectGetMaxY(lineView4.frame), [UIScreen mainScreen].bounds.size.width, workDayLabH);
    chakanBut.titleLabel.font = [UIFont systemFontOfSize:14];
    [chakanBut setTitle:@"查看施工详情" forState:UIControlStateNormal];
    [chakanBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [baseView addSubview:chakanBut];
    [chakanBut addTarget:self action:@selector(chakanButClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 边线
    UIView *lineView99 = [[UIView alloc] initWithFrame:CGRectMake(jiange1, CGRectGetMaxY(chakanBut.frame), numberLabW, 1)];
    lineView99.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [baseView addSubview:lineView99];
    
    
    if (![self.model.beforePhotos isEqualToString:@"无"] && ![self.model.afterPhotos isEqualToString:@"无"]) {
        // 施工前照片
        CGFloat beforeLabW = workDayLabW;
        CGFloat beforeLabH = workDayLabH;
        CGFloat beforeLabX = workDayLabX;
        CGFloat beforeLabY = CGRectGetMaxY(lineView99.frame);
        UILabel *beforeLab = [[UILabel alloc] initWithFrame:CGRectMake(beforeLabX, beforeLabY, beforeLabW, beforeLabH)];
        beforeLab.text = @"施工前照片";
        beforeLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
        [baseView addSubview:beforeLab];
        
        NSString *bePhotoStr = self.model.beforePhotos;
//        NSLog(@"--111---bePhotoStr---%@---",bePhotoStr);
        if (bePhotoStr == nil ||[bePhotoStr isKindOfClass:[NSNull class]]) {
            bePhotoStr = nil;
        }
//        NSLog(@"--222---bePhotoStr---%@---",bePhotoStr);
        NSArray *bePhotoArr = [bePhotoStr componentsSeparatedByString:@","];
        
        NSInteger num = bePhotoArr.count;
        beforeImageArray = [[NSMutableArray alloc]init];
        for(int i=0; i<num; i++) {
            
//            [self addBeforImgView:[NSString stringWithFormat:@"%@%@", URLHOST, bePhotoArr[i]] withPhotoIndex:i + 1 withFirstY:CGRectGetMaxY(beforeLab.frame) showInView:baseView];
            [self addBeforImgView:[NSString stringWithFormat:@"%@%@", BaseHttp,bePhotoArr[i]] withPhotoIndex:i + 1 withFirstY:CGRectGetMaxY(beforeLab.frame) showInView:baseView];
        }
        
        // 边线
        UIView *lineView10 = [[UIView alloc] initWithFrame:CGRectMake(jiange1, beMaxY + 10 / 568.0 * kHeight, numberLabW, 1)];
        lineView10.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [baseView addSubview:lineView10];
        
        // 施工后照片
        CGFloat afPhotoLabW = beforeLabW;
        CGFloat afPhotoLabH = beforeLabH;
        CGFloat afPhotoLabX = beforeLabX;
        CGFloat afPhotoLabY = CGRectGetMaxY(lineView10.frame);
        UILabel *afPhotoLab = [[UILabel alloc] initWithFrame:CGRectMake(afPhotoLabX, afPhotoLabY, afPhotoLabW, afPhotoLabH)];
        afPhotoLab.text = @"施工后照片";
        afPhotoLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
        [baseView addSubview:afPhotoLab];
        //照片
        NSString *afPhotoStr = nil;
        if ([self.model.afterPhotos isKindOfClass:[NSNull class]]||self.model.afterPhotos == nil) {
            
        }else{
            afPhotoStr = self.model.afterPhotos;
        }
        
//        NSLog(@"----afPhotoStr-----%@---",afPhotoStr);
        NSArray *afPhotoArr = [afPhotoStr componentsSeparatedByString:@","];
        NSInteger sum = afPhotoArr.count;
        afterImageArray = [[NSMutableArray alloc]init];
        for(int i=0; i<sum; i++) {
            
            [self addAfterImgView:[NSString stringWithFormat:@"%@%@",BaseHttp ,afPhotoArr[i]] withPhotoIndex:i + 1 withFirstY:CGRectGetMaxY(afPhotoLab.frame) showInView:baseView];
            
            
        }
        
        
        
        // 设置baseView的最终尺寸
        //    baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, numberLabH + jianjv2 * 2 + photoImgViewH + beizhuRect.size.height - xiadanLabH + baseView1H + workDayLabH + workTimeLabH + carPlaceLabH - shigongLabH + baseView2H + jianjv1 + indTypeLabH + workerLabH + beforeLabH + (kWidth - jianjv1 * 4) / 3.0 + afPhotoLabH + 10 / 568.0 * kHeight);
        baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, afMaxY + 10 / 568.0 * kHeight);
        
        // 边线
        UIView *lineView6 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(baseView.frame), numberLabW + jiange1 * 2, 1)];
        lineView6.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [baseView addSubview:lineView6];
        
        //    baseView.backgroundColor = [UIColor redColor];
        
        
    }else{
         baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, CGRectGetMaxY(lineView99.frame)+10);
    }
    
    upBaseViewH = baseView.frame.size.height;
   
//    NSLog(@"=upBaseViewH===%f", upBaseViewH);
}

#pragma mark 收藏按钮响应方法
- (void)collectBtnClick{
    
    
    [GFHttpTool favoriteCooperatorPostWithParameters:@{@"cooperatorId":_model.coopId} success:^(id responseObject) {
        NSLog(@"responseObject---%@--",responseObject);
        if ([responseObject[@"result"] integerValue] == 1) {
            [self addAlertView:@"收藏商户成功"];
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"error--%@--",error);
    }];
    
    
    
}


- (void)chakanButClick {
    
    GFShigongDDViewController *vc = [[GFShigongDDViewController alloc] init];
    vc.model = _model;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:vc animated:YES completion:nil];
}

// 添加前照片
- (void)addBeforImgView:(NSString *)imgUrl withPhotoIndex:(NSInteger)index withFirstY:(CGFloat)Y showInView:(UIView *)showView{
    
    NSInteger hang = (index - 1) / 3;
    NSInteger lie = index % 3;
    
    if(lie == 0) {
        lie = 3;
    }
    
    CGFloat beforImgViewW = (kWidth - jianjv1 * 4) / 3.0;
    CGFloat beforImgViewH = beforImgViewW;
    CGFloat beforImgViewX = jianjv1 * lie + beforImgViewW * (lie - 1);
    CGFloat beforImgViewY = Y + beforImgViewH * hang + jianjv1 * hang;
//    MYImageView *beforImgView = [[MYImageView alloc] init];
//    beforImgView.frame = CGRectMake(beforImgViewX, beforImgViewY, beforImgViewW, beforImgViewH);
////    beforImgView.backgroundColor = [UIColor redColor];
//    [showView addSubview:beforImgView];
//    beforImgView.tag = beforeImageArray.count;
//    [beforeImageArray addObject:beforImgView];
//    beforImgView.imageArray = beforeImageArray;
    
    NSURL *imgURL = [NSURL URLWithString:imgUrl];
//    [beforImgView sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"orderImage.png"]];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(beforImgViewX, beforImgViewY, beforImgViewW, beforImgViewH);
    [showView addSubview:but];
    [but sd_setBackgroundImageWithURL:imgURL forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"orderImage.png"]];
    [but addTarget:self action:@selector(imgViewButClick:) forControlEvents:UIControlEventTouchUpInside];
    but.tag = index;
    [but setTitle:@"施工前" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
   
    beMaxY = CGRectGetMaxY(but.frame);
}
// 添加后照片
- (void)addAfterImgView:(NSString *)imgUrl withPhotoIndex:(NSInteger)index withFirstY:(CGFloat)Y showInView:(UIView *)showView{
    
    NSInteger hang = (index - 1) / 3;
    NSInteger lie = index % 3;
    
    if(lie == 0) {
        lie = 3;
    }
    
    CGFloat beforImgViewW = (kWidth - jianjv1 * 4) / 3.0;
    CGFloat beforImgViewH = beforImgViewW;
    CGFloat beforImgViewX = jianjv1 * lie + beforImgViewW * (lie - 1);
    CGFloat beforImgViewY = Y + beforImgViewH * hang + jianjv1 * hang;
//    MYImageView *beforImgView = [[MYImageView alloc] init];
//    beforImgView.frame = CGRectMake(beforImgViewX, beforImgViewY, beforImgViewW, beforImgViewH);
////    beforImgView.backgroundColor = [UIColor redColor];
//    [showView addSubview:beforImgView];
//    beforImgView.tag = afterImageArray.count;
//    [afterImageArray addObject:beforImgView];
//    beforImgView.imageArray = afterImageArray;
    
    
    NSURL *imgURL = [NSURL URLWithString:imgUrl];
//    [beforImgView sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"orderImage.png"]];
    
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(beforImgViewX, beforImgViewY, beforImgViewW, beforImgViewH);
    [showView addSubview:but];
    [but sd_setBackgroundImageWithURL:imgURL forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"orderImage.png"]];
    [but addTarget:self action:@selector(imgViewButClick:) forControlEvents:UIControlEventTouchUpInside];
    but.tag = index;
    [but setTitle:@"施工后" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    
    afMaxY = CGRectGetMaxY(but.frame);
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
//    NSLog(@"==暂无评价==%@", _model.commentStr);
    if ([_model.commentStr isEqualToString:@"无"]) {
        // 其他意见和建议
        
        UILabel *otherLabel = [[UILabel alloc]init];
        otherLabel.text = @"暂无评价";
        otherLabel.frame = CGRectMake(0, lineView.frame.origin.y + 5, self.view.frame.size.width, 40);
        otherLabel.textAlignment = NSTextAlignmentCenter;
        
        downBaseViewH = CGRectGetMaxY(otherLabel.frame) + jianjv4;
        baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewH, downBaseViewH);
        [baseView addSubview:otherLabel];
        
        
        self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(baseView.frame)+30);
        
//        NSLog(@"为评论的滚动高度：%f", CGRectGetMaxY(baseView.frame)+30);
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
        
        for(int i=0; i<[_model.comment[@"star"] integerValue]; i++) {
            
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
        UIView *daodaView = [self messageButView:@"准时到达" withSelected:[_model.comment[@"arriveOnTime"] integerValue] withX:jiange2 withY:CGRectGetMaxY(baseView_1.frame) + jianjv3 * 2 + jianjv4 + (kWidth - kWidth * 0.25 * 2) / 5.0 - 4 / 320.0 * kWidth];
        [baseView addSubview:daodaView];
        
        // 准时完工
        UIView *wangongView = [self messageButView:@"准时完工" withSelected:[_model.comment[@"completeOnTime"] integerValue] withX:kWidth * 0.676 withY:CGRectGetMaxY(baseView_1.frame) + jianjv3 * 2 + jianjv4 + (kWidth - kWidth * 0.25 * 2) / 5.0 - 4 / 320.0 * kWidth];
        [baseView addSubview:wangongView];
        
        // 技术专业
        UIView *zhuanyeView = [self messageButView:@"技术专业" withSelected:[_model.comment[@"professional"] integerValue] withX:jiange2 withY:CGRectGetMaxY(wangongView.frame) + jianjv4];
        [baseView addSubview:zhuanyeView];
        
        // 着装整洁
        UIView *zhengjieView = [self messageButView:@"着装整洁" withSelected:[_model.comment[@"dressNeatly"] integerValue] withX:kWidth * 0.676 withY:CGRectGetMaxY(wangongView.frame) + jianjv4];
        [baseView addSubview:zhengjieView];
        
        // 车辆保护超级棒
        UIView *bangView = [self messageButView:@"车辆保护超级棒" withSelected:[_model.comment[@"carProtect"] integerValue] withX:jiange2 withY:CGRectGetMaxY(zhengjieView.frame) + jianjv4];
        [baseView addSubview:bangView];
        
        // 态度好
        UIView *haoView = [self messageButView:@"态度好" withSelected:[_model.comment[@"goodAttitude"] integerValue] withX:kWidth * 0.676 withY:CGRectGetMaxY(zhengjieView.frame) + jianjv4];
        [baseView addSubview:haoView];
        
        // 边线
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(jiange1, CGRectGetMaxY(haoView.frame) - 1 + jianjv3, kWidth - jiange1 * 2, 1)];
        lineView2.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [baseView addSubview:lineView2];
        
        // 其他意见和建议
        NSString *fenStr = _model.comment[@"advice"];
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
        
//        NSLog(@"为评论的滚动高度：%f", CGRectGetMaxY(baseView.frame)+30);
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

- (void)phoneBtnClick{
    [ACETelPrompt callPhoneNumber:_model.contactPhone call:^(NSTimeInterval duration) {
        
    } cancel:^{
        
    }];
}


- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
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
