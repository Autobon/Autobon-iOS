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
    UIView *_lastBaseView;
    
    NSMutableArray *beforeImageArray;
    NSMutableArray *afterImageArray;
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *photoArr;

@property (nonatomic, strong) NSMutableArray *allPhotoUrlArr;
@property (nonatomic, strong) NSArray *curPhoto;;
@property (nonatomic, strong) UIView *contentView;

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
    
    
    _contentView = [[UIView alloc]init];
    [_scrollView addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_scrollView);
        make.edges.equalTo(_scrollView);
    }];
    
    

    
    // 订单编号
    self.numberLab = [[UILabel alloc] init];
    self.numberLab.text = [NSString stringWithFormat:@"订单编号：%@", self.model.orderNum];
    self.numberLab.font = [UIFont systemFontOfSize:14];
    [_contentView addSubview:self.numberLab];
    [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(45);
    }];
    
    // 金额
//    self.moneyLab = [[UILabel alloc] init];
//    self.moneyLab.text = [NSString stringWithFormat:@"￥%0.1f", [self.model.payment floatValue]];
//    self.moneyLab.textAlignment = NSTextAlignmentRight;
//    self.moneyLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
//    self.moneyLab.font = [UIFont systemFontOfSize:14];
//    [_contentView addSubview:self.moneyLab];
//    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.contentView).offset(-10);
//        make.bottom.equalTo(self.numberLab.mas_centerY).offset(-2);
//    }];
    
    // 结算按钮
    self.tipLabel = [[UILabel alloc]init];
//    [self.tipBut setTitle:@"未结算" forState:UIControlStateNormal];
//    [self.tipBut setTitle:@"已结算" forState:UIControlStateSelected];
//    [self.tipBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.tipBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateSelected];
    self.tipLabel.font = [UIFont systemFontOfSize:14];
    self.tipLabel.textAlignment = NSTextAlignmentRight;
    [_contentView addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
//        make.top.equalTo(self.numberLab.mas_centerY).offset(2);
        make.centerY.equalTo(self.numberLab);
    }];
//    if([_model.payStatus integerValue] == 1) {
//
//        self.tipLabel.text = @"未结算";
//        self.tipLabel.textColor = [UIColor lightGrayColor];
//        self.moneyLab.text = [NSString stringWithFormat:@"￥ %@", _model.payment];
//    }else if(([_model.payment integerValue] == 0)){
//
//        self.tipLabel.text = @"待计算";
//        self.tipLabel.textColor = [UIColor lightGrayColor];
//        self.moneyLab.text = @"无";
//    }else {
//
//        self.tipLabel.text = @"已结算";
//        self.tipLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
//        self.moneyLab.text = [NSString stringWithFormat:@"￥ %@", _model.payment];
//    }
    
    
    // 边线
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [_contentView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(1);
        make.top.equalTo(self.numberLab.mas_bottom);
    }];
    
    // 订单图片
    _photoArr = [_model.photo componentsSeparatedByString:@","];
    CGFloat butW = ([UIScreen mainScreen].bounds.size.width - 40) / 3.0;
    CGFloat butH = butW;
    for(int i=0; i<_photoArr.count; i++) {
        
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        [but sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseHttp, _photoArr[i]]] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            ICLog(@"error---%@--", error);
            if(error){
                ICLog(@"图片加载失败");
                [but setImage:[UIImage imageNamed:@"load_image_failed"] forState:UIControlStateNormal];
            }
        }];
        but.clipsToBounds = YES;
        but.tag = i + 1;
        [but setTitle:@"订单" forState:UIControlStateNormal];
        [but setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [self.contentView addSubview:but];
        [but addTarget:self action:@selector(imgViewButClick:) forControlEvents:UIControlEventTouchUpInside];
        [but mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10 + (butW + 10) * (i % 3));
            make.top.equalTo(lineView1.mas_bottom).offset(10 + (butH + 10) * (i / 3));
            make.width.mas_offset(butW);
            make.height.mas_offset(butH);
        }];
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
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [self.contentView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(lineView1.mas_bottom).offset(10 + (butH + 10) * (( _photoArr.count - 1)/3 + 1));
        make.height.mas_offset(1);
    }];
    
    
    // 车牌号

    UILabel *licenseLabel = [[UILabel alloc] init];
    licenseLabel.text = [NSString stringWithFormat:@"车牌号：%@", _model.license];
    licenseLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:licenseLabel];
    [licenseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(45);
        make.top.equalTo(lineView2.mas_bottom);
    }];
    // 边线
    UIView *lineViewLicense = [[UIView alloc] init];
    lineViewLicense.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [self.contentView addSubview:lineViewLicense];
    [lineViewLicense mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(1);
        make.top.equalTo(licenseLabel.mas_bottom);
    }];
    
    // 车架号
    UILabel *vinLabel = [[UILabel alloc] init];
    vinLabel.text = [NSString stringWithFormat:@"车架号：%@", _model.vin];
    vinLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:vinLabel];
    [vinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(45);
        make.top.equalTo(lineViewLicense.mas_bottom);
    }];
    
    
    // 边线
    UIView *lineViewVin = [[UIView alloc] init];
    lineViewVin.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [self.contentView addSubview:lineViewVin];
    [lineViewVin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(1);
        make.top.equalTo(vinLabel.mas_bottom);
    }];
    
    
    // 下单备注
    
    UILabel *xiadanLab = [[UILabel alloc] init];
    xiadanLab.text = @"下单备注：";
    xiadanLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:xiadanLab];
    [xiadanLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(lineViewVin.mas_bottom).offset(0);
        make.height.mas_offset(45);
    }];
    NSString *beizhuStr = [NSString stringWithFormat:@"%@", self.model.remark];
    NSMutableDictionary *bezhuDic = [[NSMutableDictionary alloc] init];
    bezhuDic[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    bezhuDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect beizhuRect = [beizhuStr boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 105, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:bezhuDic context:nil];
    self.beizhuLab = [[UILabel alloc] init];
    self.beizhuLab.numberOfLines = 0;
    self.beizhuLab.font = [UIFont systemFontOfSize:14];
    self.beizhuLab.text = beizhuStr;
    [self.contentView addSubview:self.beizhuLab];
    [self.beizhuLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(80);
        make.top.equalTo(lineViewVin.mas_bottom).offset(12);
        make.right.equalTo(self.contentView).offset(-25);
        make.height.mas_offset(beizhuRect.size.height + 5);
    }];
    
    // 边线
    UIView *lineView3 = [[UIView alloc] init];
    lineView3.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [self.contentView addSubview:lineView3];
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(1);
        make.top.equalTo(self.beizhuLab.mas_bottom).offset(12);
    }];
    // 订单类型
    self.indTypeLab = [[UILabel alloc] init];
    self.indTypeLab.text = [NSString stringWithFormat:@"订单类型：%@", _model.typeName];
    self.indTypeLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.indTypeLab];
    [self.indTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(45);
        make.top.equalTo(lineView3.mas_bottom).offset(0);
    }];
    
    // 边线
    UIView *lineView8 = [[UIView alloc] init];
    lineView8.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [self.contentView addSubview:lineView8];
    [lineView8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(1);
        make.top.equalTo(self.indTypeLab.mas_bottom).offset(0);
    }];
    
    _lastBaseView = lineView8;
#pragma mark - 报价产品
    if (self.model.productOfferArray.count > 0){
        UIView *titleBaseView = [[UIView alloc]init];
        titleBaseView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
        [self.contentView addSubview:titleBaseView];
        [titleBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(_lastBaseView.mas_bottom);
            make.height.mas_offset(45);
        }];
        
        
        UIView *leftLittleView = [[UIView alloc]init];
        leftLittleView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        [titleBaseView addSubview:leftLittleView];
        [leftLittleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleBaseView);
            make.centerY.mas_offset(16);
            make.width.mas_offset(6);
        }];
        
        
        UILabel *menusTitleLab = [[UILabel alloc] init];
        menusTitleLab.textColor = [UIColor darkGrayColor];
        menusTitleLab.font = [UIFont systemFontOfSize:14];
        menusTitleLab.text = [NSString stringWithFormat:@"报价产品"];
        [titleBaseView addSubview:menusTitleLab];
        [menusTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleBaseView).offset(20);
            make.centerY.equalTo(titleBaseView);
            make.right.equalTo(titleBaseView).offset(-20);
            make.height.mas_offset(30);
        }];
        
        UIView *titleImageBaseView = [[UIView alloc]init];
        titleImageBaseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:titleImageBaseView];
        [titleImageBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(titleBaseView.mas_bottom);
            make.height.mas_offset(40);
        }];
        
        
        UIImageView *titleImageView = [[UIImageView alloc]init];
        titleImageView.image = [UIImage imageNamed:@"cpin"];
        [titleImageBaseView addSubview:titleImageView];
        titleImageView.frame = CGRectMake(20, 12, 15, 15);
        
        UILabel *titleImageLabel = [[UILabel alloc]init];
        titleImageLabel.text = @"型号+部位";
        titleImageLabel.font = [UIFont boldSystemFontOfSize:14];
        [titleImageBaseView addSubview:titleImageLabel];
        titleImageLabel.frame = CGRectMake(40, 5, [UIScreen mainScreen].bounds.size.width - 60, 30);
        
        UIView *titleLineView = [[UIView alloc]init];
        titleLineView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
        [titleImageBaseView addSubview:titleLineView];
        titleLineView.frame = CGRectMake(15, 39, [UIScreen mainScreen].bounds.size.width - 30, 1);
        
        _lastBaseView = titleImageBaseView;
        for (int i = 0; i < self.model.productOfferArray.count; i++) {
            
            UIView *titleBaseView = [[UIView alloc]init];
            titleBaseView.backgroundColor = [UIColor whiteColor];
            [self.contentView addSubview:titleBaseView];
            [titleBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contentView);
                make.top.equalTo(_lastBaseView.mas_bottom);
                make.height.mas_offset(40);
            }];
            _lastBaseView = titleBaseView;
            
            
            NSDictionary *productDict = self.model.productOfferArray[i];
            UILabel *menusNameLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, [UIScreen mainScreen].bounds.size.width - 60, 30)];
            menusNameLab.textColor = [UIColor darkGrayColor];
            menusNameLab.font = [UIFont systemFontOfSize:14];
            menusNameLab.text = [NSString stringWithFormat:@"%@--%@", productDict[@"model"], productDict[@"constructionPositionName"]];
            [titleBaseView addSubview:menusNameLab];
            
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
            [titleBaseView addSubview:lineView];
            lineView.frame = CGRectMake(15, 39, [UIScreen mainScreen].bounds.size.width - 30, 1);
        }
    }
    
    
    
#pragma mark - 施工套餐
    
    if (self.model.setMenusArray.count > 0){
        
        UIView *titleBaseView = [[UIView alloc]init];
        titleBaseView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
        [self.contentView addSubview:titleBaseView];
        [titleBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(_lastBaseView.mas_bottom);
            make.height.mas_offset(45);
        }];
        
        UIView *leftLittleView = [[UIView alloc]init];
        leftLittleView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        [titleBaseView addSubview:leftLittleView];
        [leftLittleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleBaseView);
            make.centerY.equalTo(titleBaseView);
            make.height.mas_offset(16);
            make.width.mas_offset(6);
        }];
        
        UILabel *menusTitleLab = [[UILabel alloc] init];
        menusTitleLab.textColor = [UIColor darkGrayColor];
        menusTitleLab.font = [UIFont systemFontOfSize:14];
        menusTitleLab.text = [NSString stringWithFormat:@"组合套餐"];
        [titleBaseView addSubview:menusTitleLab];
        [menusTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleBaseView).offset(20);
            make.centerY.equalTo(titleBaseView);
            make.right.equalTo(titleBaseView).offset(-20);
            make.height.mas_offset(30);
        }];
        
        UIView *titleImageBaseView = [[UIView alloc]init];
        titleImageBaseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:titleImageBaseView];
        [titleImageBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(titleBaseView.mas_bottom);
            make.height.mas_offset(40);
        }];
        
        UIImageView *titleImageView = [[UIImageView alloc]init];
        titleImageView.image = [UIImage imageNamed:@"tchan"];
        [titleImageBaseView addSubview:titleImageView];
        titleImageView.frame = CGRectMake(20, 12, 15, 15);
        
        UILabel *titleImageLabel = [[UILabel alloc]init];
        titleImageLabel.text = @"套餐名称";
        titleImageLabel.font = [UIFont boldSystemFontOfSize:14];
        [titleImageBaseView addSubview:titleImageLabel];
        titleImageLabel.frame = CGRectMake(40, 5, [UIScreen mainScreen].bounds.size.width - 60, 30);
        
        UIView *titleLineView = [[UIView alloc]init];
        titleLineView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
        [titleImageBaseView addSubview:titleLineView];
        titleLineView.frame = CGRectMake(15, 39, [UIScreen mainScreen].bounds.size.width - 30, 1);
        
        _lastBaseView = titleImageBaseView;
        
        for (int i = 0; i < self.model.setMenusArray.count; i++) {
            
            UIView *titleBaseView = [[UIView alloc]init];
            titleBaseView.backgroundColor = [UIColor whiteColor];
            [self.contentView addSubview:titleBaseView];
            [titleBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.contentView);
                make.top.equalTo(_lastBaseView.mas_bottom);
                make.height.mas_offset(40);
            }];
            _lastBaseView = titleBaseView;
            
            
            NSDictionary *menusDict = self.model.setMenusArray[i];
            UILabel *menusNameLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, [UIScreen mainScreen].bounds.size.width - 60, 30)];
            menusNameLab.textColor = [UIColor darkGrayColor];
            menusNameLab.font = [UIFont systemFontOfSize:14];
            menusNameLab.text = [NSString stringWithFormat:@"%@", menusDict[@"name"]];
            [titleBaseView addSubview:menusNameLab];
            
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
            [titleBaseView addSubview:lineView];
            lineView.frame = CGRectMake(15, 39, [UIScreen mainScreen].bounds.size.width - 30, 1);
            
        }
    }
    
    
    
    // "商户名称"
    UILabel *shigongLab = [[UILabel alloc] init];
    shigongLab.text = @"商户名称：";
    shigongLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:shigongLab];
    [shigongLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(_lastBaseView.mas_bottom).offset(0);
        make.height.mas_offset(45);
    }];
    
    NSString *buweiStr = self.model.coopName;
//    buweiStr = @"这是一条商户名称这是一条商户名称这是一条商户名称这是一条商户名称这是一条商户名称这是一条商户名称这是一条商户名称这是一条商户名称这是一条商户名称";
    NSMutableDictionary *buweiDic = [[NSMutableDictionary alloc] init];
    buweiDic[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    buweiDic[NSForegroundColorAttributeName] = [UIColor blackColor];
//    NSLog(@"--商户名称：---%@", buweiStr);
    CGRect buweiRect = [buweiStr boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 155, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:buweiDic context:nil];
    self.carPlaceLab = [[UILabel alloc] init];
    self.carPlaceLab.numberOfLines = 0;
    self.carPlaceLab.font = [UIFont systemFontOfSize:14];
    self.carPlaceLab.text = buweiStr;
    [self.contentView addSubview:self.carPlaceLab];
    [self.carPlaceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(80);
        make.top.equalTo(_lastBaseView.mas_bottom).offset(12);
        make.right.equalTo(self.contentView).offset(-75);
        make.height.mas_offset(buweiRect.size.height + 5);
    }];
// 收藏按钮
    UIButton *collectButton = [[UIButton alloc]init];
    [collectButton setTitle:@"收藏" forState:UIControlStateNormal];
    [collectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:collectButton];
    [collectButton addTarget:self action:@selector(collectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    collectButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    
    [collectButton setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
    collectButton.layer.borderWidth = 1;
    collectButton.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
    collectButton.layer.cornerRadius = 3;
    [collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shigongLab);
        make.right.equalTo(self.contentView).offset(-10);
        make.width.mas_offset(50);
        make.height.mas_offset(20);
    }];
    
    
    // 边线
    UIView *lineView7 = [[UIView alloc] init];
    lineView7.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [self.contentView addSubview:lineView7];
    [lineView7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(1);
        make.top.equalTo(self.carPlaceLab.mas_bottom).offset(12);
    }];
    
    // 联系方式
    UILabel *phoneLab = [[UILabel alloc] init];
    phoneLab.text = [NSString stringWithFormat:@"联系方式：%@", _model.contactPhone];
    phoneLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:phoneLab];
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(45);
        make.top.equalTo(lineView7.mas_bottom).offset(0);
    }];
    
    
    // 边线
    UIView *lineView5 = [[UIView alloc] init];
    lineView5.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [self.contentView addSubview:lineView5];
    [lineView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(1);
        make.top.equalTo(phoneLab.mas_bottom).offset(0);
    }];
    
    UIButton *phoneButton = [[UIButton alloc]init];
    [phoneButton setImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
    [self.contentView addSubview:phoneButton];
    [phoneButton addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    phoneButton.frame = CGRectMake(self.view.frame.size.width - baseView1H *2 , phoneLabY , baseView1H *2 , baseView1H);
    [phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(phoneLab);
        make.width.mas_offset(60);
        make.height.mas_offset(30);
    }];
    
    // 商户位置
    UILabel *addressLab = [[UILabel alloc] init];
    addressLab.text = [NSString stringWithFormat:@"商户位置：%@", _model.address];
    addressLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:addressLab];
    [addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(45);
        make.top.equalTo(lineView5.mas_bottom).offset(0);
    }];
    // 边线
    UIView *lineView6 = [[UIView alloc] init];
    lineView6.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [self.contentView addSubview:lineView6];
    [lineView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(1);
        make.top.equalTo(addressLab.mas_bottom).offset(0);
    }];
    
    
    
    // 施工人员
    self.workerLab = [[UILabel alloc] init];
    self.workerLab.text = [NSString stringWithFormat:@"施工人员：%@", _model.jishiAllName];
    self.workerLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.workerLab];
    [self.workerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(45);
        make.top.equalTo(lineView6.mas_bottom).offset(0);
    }];
    // 边线
    UIView *lineView9 = [[UIView alloc] init];
    lineView9.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [self.contentView addSubview:lineView9];
    [lineView9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(1);
        make.top.equalTo(self.workerLab.mas_bottom).offset(0);
    }];
    
    
    // 预约施工时间
    self.workDayLab = [[UILabel alloc] init];
    self.workDayLab.text = [NSString stringWithFormat:@"预约施工时间：%@", _model.agreedStartTime];
    self.workDayLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.workDayLab];
    [self.workDayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(45);
        make.top.equalTo(lineView9.mas_bottom).offset(0);
    }];
    
    // 边线
    UIView *lineView4 = [[UIView alloc] init];
    lineView4.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [self.contentView addSubview:lineView4];
    [lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(1);
        make.top.equalTo(self.workDayLab.mas_bottom).offset(0);
    }];
    
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
    
    
    
    
    
    // 开始施工时间
    UILabel *workerBeginTimeLab = [[UILabel alloc] init];
    workerBeginTimeLab.text = [NSString stringWithFormat:@"开始施工时间：%@", _model.startTime];
    workerBeginTimeLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:workerBeginTimeLab];
    [workerBeginTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(45);
        make.top.equalTo(lineView4.mas_bottom).offset(0);
    }];
    // 边线
    UIView *lineView10 = [[UIView alloc] init];
    lineView10.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [self.contentView addSubview:lineView10];
    [lineView10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(1);
        make.top.equalTo(workerBeginTimeLab.mas_bottom).offset(0);
    }];
    
    // 预约交车时间
    UILabel *workerPlanEndTimeLab = [[UILabel alloc] init];
    workerPlanEndTimeLab.text = [NSString stringWithFormat:@"预约交车时间：%@", _model.agreedEndTime];
    workerPlanEndTimeLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:workerPlanEndTimeLab];
    [workerPlanEndTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(45);
        make.top.equalTo(lineView10.mas_bottom).offset(0);
    }];
    // 边线
    UIView *lineView11 = [[UIView alloc] init];
    lineView11.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [self.contentView addSubview:lineView11];
    [lineView11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(1);
        make.top.equalTo(workerPlanEndTimeLab.mas_bottom).offset(0);
    }];
    // 施工完成时间
    UILabel *workerOverTimeLab = [[UILabel alloc] init];
    workerOverTimeLab.text = [NSString stringWithFormat:@"施工完成时间：%@", _model.endTime];
    workerOverTimeLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:workerOverTimeLab];
    [workerOverTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(45);
        make.top.equalTo(lineView11.mas_bottom).offset(0);
    }];
    
    // 边线
    UIView *lineView12 = [[UIView alloc] init];
    lineView12.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [self.contentView addSubview:lineView12];
    [lineView12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(1);
        make.top.equalTo(workerOverTimeLab.mas_bottom).offset(0);
    }];
    
    UIView *_payBaseView = [[UIView alloc]init];
    [self.contentView addSubview:_payBaseView];
    [_payBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(lineView12.mas_bottom).offset(0);
        make.height.mas_offset(45);
    }];
    
    
    
    UILabel *mLab = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 10 - 120, self.workTimeLab.frame.origin.y, 120, 25)];
    mLab.text = [NSString stringWithFormat:@"合计：¥%0.1f", [self.model.payment floatValue]];
    mLab.textAlignment = NSTextAlignmentRight;
    //        self.mLab.textColor = [UIColor lightGrayColor];
    mLab.font = [UIFont systemFontOfSize:13];
    [_payBaseView addSubview:mLab];
    [mLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_payBaseView.mas_right).offset(-10);
        make.centerY.equalTo(_payBaseView);
    }];
    
    
    //施工提成
    UILabel *royaltyLabel = [[UILabel alloc] init];
    royaltyLabel.text = [NSString stringWithFormat:@"施工提成:¥%@", self.model.royalty];
    royaltyLabel.textAlignment = NSTextAlignmentRight;
    royaltyLabel.textColor = [UIColor lightGrayColor];
    royaltyLabel.font = [UIFont systemFontOfSize:13];
    [_payBaseView addSubview:royaltyLabel];
    [royaltyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_payBaseView).offset(10);
        make.centerY.equalTo(_payBaseView);
    }];
    
    //报废扣除
    UILabel *totalCostLabel = [[UILabel alloc] init];
    totalCostLabel.text = [NSString stringWithFormat:@"报废扣除:¥%@", self.model.totalCost];
    totalCostLabel.textAlignment = NSTextAlignmentRight;
    totalCostLabel.textColor = [UIColor lightGrayColor];
    totalCostLabel.font = [UIFont systemFontOfSize:13];
    [_payBaseView addSubview:totalCostLabel];
    [totalCostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(royaltyLabel.mas_right).offset(15);
        make.centerY.equalTo(_payBaseView);
    }];
    
    
    if([_model.payStatus integerValue] == 1) {
        
        self.tipLabel.text = @"未结算";
        self.tipLabel.textColor = [UIColor lightGrayColor];
        mLab.text = [NSString stringWithFormat:@"合计：¥%0.1f", [self.model.payment floatValue]];
        royaltyLabel.text = [NSString stringWithFormat:@"施工提成:¥%@", self.model.royalty];
        totalCostLabel.text = [NSString stringWithFormat:@"报废扣除:¥%@", self.model.totalCost];
        
    }else if(([_model.payment integerValue] == 0)){
        
        self.tipLabel.text = @"待计算";
        self.tipLabel.textColor = [UIColor lightGrayColor];
        _payBaseView.hidden = YES;
        [_payBaseView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(0);
        }];
    }else {
        
        self.tipLabel.text = @"已结算";
        self.tipLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        mLab.text = [NSString stringWithFormat:@"合计：¥%0.1f", [self.model.payment floatValue]];
        royaltyLabel.text = [NSString stringWithFormat:@"施工提成:¥%@", self.model.royalty];
        totalCostLabel.text = [NSString stringWithFormat:@"报废扣除:¥%@", self.model.totalCost];
        
    }
    
    
    
//    // 施工耗时
//    CGFloat workTimeLabW = workDayLabW;
//    CGFloat workTimeLabH = workDayLabH;
//    CGFloat workTimeLabX = workDayLabX;
//    CGFloat workTimeLabY = CGRectGetMaxY(self.workDayLab.frame);
//    self.workTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(workTimeLabX, workTimeLabY, workTimeLabW, workTimeLabH)];
//    self.workTimeLab.text = [NSString stringWithFormat:@"施工耗时："];
//    self.workTimeLab.font = [UIFont systemFontOfSize:14];
//    [baseView addSubview:self.workTimeLab];
//    
//    // 边线
//    UIView *lineView9 = [[UIView alloc] initWithFrame:CGRectMake(jiange1, CGRectGetMaxY(self.workTimeLab.frame), numberLabW, 1)];
//    lineView9.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
//    [baseView addSubview:lineView9];
    
    // 查看施工详情
    UIButton *chakanBut = [UIButton buttonWithType:UIButtonTypeCustom];
    chakanBut.titleLabel.font = [UIFont systemFontOfSize:14];
    [chakanBut setTitle:@"查看施工详情" forState:UIControlStateNormal];
    [chakanBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.contentView addSubview:chakanBut];
    [chakanBut addTarget:self action:@selector(chakanButClick) forControlEvents:UIControlEventTouchUpInside];
    [chakanBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.height.mas_offset(45);
        make.top.equalTo(_payBaseView.mas_bottom).offset(0);
    }];
    
    // 边线
    UIView *lineView99 = [[UIView alloc] init];
    lineView99.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [self.contentView addSubview:lineView99];
    [lineView99 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(1);
        make.top.equalTo(chakanBut.mas_bottom).offset(0);
    }];
    
    if (![self.model.beforePhotos isEqualToString:@"无"] && ![self.model.afterPhotos isEqualToString:@"无"]) {
        // 施工前照片
        UILabel *beforeLab = [[UILabel alloc] init];
        beforeLab.text = @"施工前照片";
        beforeLab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:beforeLab];
        [beforeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(0);
            make.height.mas_offset(45);
            make.top.equalTo(lineView99.mas_bottom).offset(0);
        }];
        
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
            [self addBeforImgView:[NSString stringWithFormat:@"%@%@", BaseHttp,bePhotoArr[i]] withPhotoIndex:i + 1 withLastView:beforeLab];
        }
        
        // 边线
        UIView *lineView10 = [[UIView alloc] init];
        lineView10.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [self.contentView addSubview:lineView10];
        [lineView10 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.mas_offset(1);
            make.top.equalTo(beforeLab.mas_bottom).offset(0 + (((num - 1)/3 + 1) * (self.view.frame.size.width/3 + 10)) + 10);
        }];
        
        
        
        // 施工后照片
        UILabel *afPhotoLab = [[UILabel alloc] init];
        afPhotoLab.text = @"施工后照片";
        afPhotoLab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:afPhotoLab];
        [afPhotoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.mas_offset(45);
            make.top.equalTo(lineView10.mas_bottom).offset(0);
        }];
        
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
            [self addAfterImgView:[NSString stringWithFormat:@"%@%@",BaseHttp ,afPhotoArr[i]] withPhotoIndex:i + 1 withLastView:afPhotoLab];
        }
        
        
        
        // 设置baseView的最终尺寸
        //    baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, numberLabH + jianjv2 * 2 + photoImgViewH + beizhuRect.size.height - xiadanLabH + baseView1H + workDayLabH + workTimeLabH + carPlaceLabH - shigongLabH + baseView2H + jianjv1 + indTypeLabH + workerLabH + beforeLabH + (kWidth - jianjv1 * 4) / 3.0 + afPhotoLabH + 10 / 568.0 * kHeight);
        
        // 边线
        UIView *lineView6 = [[UIView alloc] init];
        lineView6.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [self.contentView addSubview:lineView6];
        [lineView6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.mas_offset(1);
            make.top.equalTo(afPhotoLab.mas_bottom).offset(0 + (((sum - 1)/3 + 1) * (self.view.frame.size.width/3 + 10)) + 10);
        }];
        
        _lastBaseView = lineView6;
        
    }else{
        _lastBaseView = lineView99;
    }
    
//    upBaseViewH = baseView.frame.size.height;
   
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
- (void)addBeforImgView:(NSString *)imgUrl withPhotoIndex:(NSInteger)index withLastView:(UIView *)lastView{
    
    NSInteger hang = (index - 1) / 3;
    NSInteger lie = index % 3;
    
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
    [self.contentView addSubview:but];
    [but sd_setBackgroundImageWithURL:imgURL forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"orderImage.png"]];
    [but addTarget:self action:@selector(imgViewButClick:) forControlEvents:UIControlEventTouchUpInside];
    but.tag = index;
    [but setTitle:@"施工前" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastView.mas_bottom).offset(10 + (self.view.frame.size.width - 10)/3 * hang);
        make.left.equalTo(self.contentView).offset(10 + (self.view.frame.size.width - 10)/3 * lie);
        make.width.mas_offset((self.view.frame.size.width - 40)/3);
        make.height.mas_offset((self.view.frame.size.width - 40)/3);
    }];
}
// 添加后照片
- (void)addAfterImgView:(NSString *)imgUrl withPhotoIndex:(NSInteger)index withLastView:(UIView *)lastView{
    
    NSInteger hang = (index - 1) / 3;
    NSInteger lie = index % 3;
    
    
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
    [self.contentView addSubview:but];
    [but sd_setBackgroundImageWithURL:imgURL forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"orderImage.png"]];
    [but addTarget:self action:@selector(imgViewButClick:) forControlEvents:UIControlEventTouchUpInside];
    but.tag = index;
    [but setTitle:@"施工后" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastView.mas_bottom).offset(10 + (self.view.frame.size.width - 10)/3 * hang);
        make.left.equalTo(self.contentView).offset(10 + (self.view.frame.size.width - 10)/3 * lie);
        make.width.mas_offset((self.view.frame.size.width - 40)/3);
        make.height.mas_offset((self.view.frame.size.width - 40)/3);
    }];
}

- (void)_setPingjiaMessage {

    
    
    // 评价
    UIView *baseView_1 = [[UIView alloc] init];
    [self.contentView addSubview:baseView_1];
    [baseView_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(_lastBaseView.mas_bottom);
        make.height.mas_offset(45);
    }];
    
    
    // 竖条
    UIView *shuView = [[UIView alloc] init];
    shuView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [baseView_1 addSubview:shuView];
    [shuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(baseView_1);
        make.centerY.equalTo(baseView_1);
        make.height.mas_offset(35);
        make.width.mas_offset(3.5);
    }];
    // “评价”
    UILabel *pingjiaLab = [[UILabel alloc] init];
    pingjiaLab.text = @"评价";
    pingjiaLab.font = [UIFont systemFontOfSize:14];
    [baseView_1 addSubview:pingjiaLab];
    [pingjiaLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(baseView_1).offset(20);
        make.centerY.equalTo(baseView_1);
    }];
    // 边线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(baseView_1.frame) - 1, kWidth, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(baseView_1.mas_bottom);
        make.height.mas_offset(1);
    }];
//    NSLog(@"==暂无评价==%@", _model.commentStr);
    if ([_model.commentStr isEqualToString:@"无"]) {
        // 其他意见和建议
        
        UILabel *otherLabel = [[UILabel alloc]init];
        otherLabel.text = @"暂无评价";
        otherLabel.frame = CGRectMake(0, lineView.frame.origin.y + 5, self.view.frame.size.width, 40);
        otherLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:otherLabel];
        [otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(lineView.mas_bottom).offset(5);
            make.height.mas_offset(45);
            
            make.bottom.equalTo(self.contentView).offset(-40);
        }];
        
        
//        self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(baseView.frame)+30);
        
//        NSLog(@"为评论的滚动高度：%f", CGRectGetMaxY(baseView.frame)+30);
    }else{
        // 星星
        for(int i=0; i<5; i++) {
            UIImageView *imgView = [[UIImageView alloc] init];
            [self.contentView addSubview:imgView];
            imgView.image = [UIImage imageNamed:@"detailsStarDark.png"];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(60 + 35 * i);
                make.top.equalTo(baseView_1.mas_bottom).offset(20);
                make.height.mas_offset(30);
                make.width.mas_offset(30);
            }];
        }
        
        for(int i=0; i<[_model.comment[@"star"] integerValue]; i++) {
            UIImageView *imgView = [[UIImageView alloc] init];
            [self.contentView addSubview:imgView];
            imgView.image = [UIImage imageNamed:@"information.png"];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(60 + 35 * i);
                make.top.equalTo(baseView_1.mas_bottom).offset(20);
                make.height.mas_offset(30);
                make.width.mas_offset(30);
            }];
        }
        
        // 准时到达
        UIView *daodaView = [self messageButView:@"准时到达" withSelected:[_model.comment[@"arriveOnTime"] integerValue]];
        [daodaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(baseView_1.mas_bottom).offset(80);
            make.height.mas_offset(30);
            make.right.equalTo(self.contentView.mas_centerX);
        }];
        // 准时完工
        UIView *wangongView = [self messageButView:@"准时完工" withSelected:[_model.comment[@"completeOnTime"] integerValue]];
        [wangongView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(0);
            make.top.equalTo(baseView_1.mas_bottom).offset(80);
            make.height.mas_offset(30);
            make.left.equalTo(self.contentView.mas_centerX).offset(10);
        }];
        // 技术专业
        UIView *zhuanyeView = [self messageButView:@"技术专业" withSelected:[_model.comment[@"professional"] integerValue]];
        [zhuanyeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(daodaView.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.right.equalTo(self.contentView.mas_centerX);
        }];
        // 着装整洁
        UIView *zhengjieView = [self messageButView:@"着装整洁" withSelected:[_model.comment[@"dressNeatly"] integerValue]];
        [zhengjieView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(0);
            make.top.equalTo(daodaView.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.left.equalTo(self.contentView.mas_centerX).offset(10);
        }];
        // 车辆保护超级棒
        UIView *bangView = [self messageButView:@"车辆保护超级棒" withSelected:[_model.comment[@"carProtect"] integerValue]];
        [bangView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(zhuanyeView.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.right.equalTo(self.contentView.mas_centerX);
        }];
        // 态度好
        UIView *haoView = [self messageButView:@"态度好" withSelected:[_model.comment[@"goodAttitude"] integerValue]];
        [haoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(0);
            make.top.equalTo(zhuanyeView.mas_bottom).offset(0);
            make.height.mas_offset(30);
            make.left.equalTo(self.contentView.mas_centerX).offset(10);
        }];
        
        // 边线
        UIView *lineView2 = [[UIView alloc] init];
        lineView2.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [self.contentView addSubview:lineView2];
        [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(haoView.mas_bottom).offset(10);
            make.height.mas_offset(1);
        }];
        
        // 其他意见和建议
        NSString *fenStr = _model.comment[@"advice"];
//        NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
//        fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:15];
//        fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
//        CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake(kWidth - jiange2 * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
//        CGFloat otherLabW = kWidth - jiange2 * 2;
//        CGFloat otherLabH = fenRect.size.height;
//        CGFloat otherLabX = jiange2;
//        CGFloat otherLabY = CGRectGetMaxY(lineView2.frame) + jianjv4;
        UILabel *otherLab = [[UILabel alloc] init];
        otherLab.font = [UIFont systemFontOfSize:15];
        otherLab.text = fenStr;
        otherLab.numberOfLines = 0;
        //    otherLab.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:otherLab];
        [otherLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(lineView2.mas_bottom).offset(10);
            
            
            make.bottom.equalTo(self.contentView).offset(-40);
        }];
        
//        downBaseViewH = CGRectGetMaxY(otherLab.frame) + jianjv4;
//        baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewH, downBaseViewH);
//
//        self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(baseView.frame)+30);
        
//        NSLog(@"为评论的滚动高度：%f", CGRectGetMaxY(baseView.frame)+30);
    }
    
    
}

- (UIView *)messageButView:(NSString *)messageStr withSelected:(BOOL)select{
    
    UIButton *imgBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [imgBut setImage:[UIImage imageNamed:@"over.png"] forState:UIControlStateNormal];
    [imgBut setImage:[UIImage imageNamed:@"overClick.png"] forState:UIControlStateSelected];
    imgBut.selected = select;
    
//    NSString *fenStr = messageStr;
//    NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
//    fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:15];
//    fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
//    CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.font = [UIFont systemFontOfSize:15];
    lab.text = messageStr;
    
    UIView *baseView = [[UIView alloc] init];
    [self.contentView addSubview:baseView];
    
    
    
    [baseView addSubview:imgBut];
    [imgBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(baseView).offset(10);
        make.centerY.equalTo(baseView);
        make.width.mas_offset(16);
        make.height.mas_offset(16);
    }];
    
    [baseView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgBut.mas_right).offset(10);
        make.centerY.equalTo(baseView);
    }];

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
