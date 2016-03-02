//
//  GFAlertView.m
//  CarMap
//
//  Created by 陈光法 on 16/2/17.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFAlertView.h"

@implementation GFAlertView


- (instancetype)initWithTipName:(NSString *)tipName withTipMessage:(NSString *)tipMessageStr withButtonNameArray:(NSArray *)buttonArray {

    self = [super init];
    
    if(self != nil) {
        
        CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        // 基础View
        CGFloat baseViewW = kWidth - 2 * kWidth * 0.1;
        CGFloat baseViewH = 300;
        CGFloat baseViewX = kWidth * 0.1;
        CGFloat baseViewY = 130 / 568.0 * kHeight;
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:baseView];
        baseView.layer.cornerRadius = 7.5;
        baseView.clipsToBounds = YES;
        
        // 提示标题
        CGFloat tipLabW = baseViewW;
        CGFloat tipLabH = 40 / 568.0 * kHeight;
        CGFloat tipLabX = 0;
        CGFloat tipLabY = 0;
        UILabel *tipLab = [[UILabel alloc] initWithFrame:CGRectMake(tipLabX, tipLabY, tipLabW, tipLabH)];
        tipLab.backgroundColor = [UIColor whiteColor];
        tipLab.text = tipName;
        tipLab.textAlignment = NSTextAlignmentCenter;
        tipLab.font = [UIFont systemFontOfSize:17 / 320.0 * kWidth];
        [baseView addSubview:tipLab];
        tipLab.layer.cornerRadius = 7.5;
//        tipLab.clipsToBounds = YES;
        
        
        // 分界线
        CGFloat lineViewW = baseViewW;
        CGFloat lineViewH = 1;
        CGFloat lineViewX = 0;
        CGFloat lineViewY = CGRectGetMaxY(tipLab.frame);
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH)];
        lineView.backgroundColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        [baseView addSubview:lineView];
        
        
        // 提示文本
        NSString *fenStr = tipMessageStr;
        NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
        fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake(baseViewW - 50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
        CGFloat msgLabW = baseViewW - 40;
        CGFloat msgLabH = fenRect.size.height + 6;
        CGFloat msgLabX = 20;
        CGFloat msgLabY = CGRectGetMaxY(tipLab.frame) + 20;
        UILabel *msgLab = [[UILabel alloc] initWithFrame:CGRectMake(msgLabX, msgLabY, msgLabW, msgLabH)];
        msgLab.numberOfLines = 0;
        msgLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        msgLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        msgLab.textAlignment = NSTextAlignmentCenter;
        // 设置行距
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:tipMessageStr];
        NSMutableParagraphStyle *paStyle = [[NSMutableParagraphStyle alloc] init];
        paStyle.lineSpacing = 2;
        [attStr addAttribute:NSParagraphStyleAttributeName value:paStyle range:NSMakeRange(0, [tipMessageStr length])];
        msgLab.attributedText = attStr;
//        [msgLab sizeToFit]; // 这个是自适应
        [baseView addSubview:msgLab];
        
        // 下方按钮
        CGFloat okButW = baseViewW;
        CGFloat okButH = tipLabH;
        CGFloat okButX = 0;
        CGFloat okButY= CGRectGetMaxY(msgLab.frame) + 20;
        _okBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBut.frame = CGRectMake(okButX, okButY, okButW, okButH);
        [baseView addSubview:_okBut];
        CGFloat okLabW = 60;
        CGFloat okLabH = 30;
        CGFloat okLabX = (baseViewW - okLabW) / 2.0;
        CGFloat okLabY = (okButH - okLabH) / 2.0;
        UILabel *okLab = [[UILabel alloc] initWithFrame:CGRectMake(okLabX, okLabY, okLabW, okLabH)];
        okLab.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        okLab.textColor = [UIColor whiteColor];
        okLab.text = buttonArray[0];
        okLab.textAlignment = NSTextAlignmentCenter;
        okLab.layer.cornerRadius = 7.5;
        okLab.clipsToBounds = YES;
        [_okBut addSubview:okLab];
//        _okBut.layer.cornerRadius = 7.5;
//        _okBut.clipsToBounds = YES;
    
        [_okBut addTarget:self action:@selector(okButClick) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat baseViewH2 = CGRectGetMaxY(_okBut.frame);
        baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH2);
        
    }

    return self;
}

- (instancetype)initWithTipName:(NSString *)tipName withTipMessage:(NSString *)tipMessageStr withButtonNameArray:(NSArray *)buttonArray withRightUpButtonNormalImage:(UIImage *)butNorImg withRightUpButtonHightImage:(UIImage *)butHigImg {

    self = [super init];
    
    if(self != nil) {
        
        CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        // 基础View
        CGFloat baseViewW = kWidth - 2 * kWidth * 0.1;
        CGFloat baseViewH = 300;
        CGFloat baseViewX = kWidth * 0.1;
        CGFloat baseViewY = 130 / 568.0 * kHeight;
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:baseView];
        baseView.layer.cornerRadius = 7.5;
        baseView.clipsToBounds = YES;
        
        // 提示栏View
        CGFloat topViewW = baseViewW;
        CGFloat topViewH = 55 / 568.0 * kHeight;
        CGFloat topViewX = 0;
        CGFloat topViewY = 0;
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(topViewX, topViewY, topViewW, topViewH)];
        topView.backgroundColor = [UIColor whiteColor];
        [baseView addSubview:topView];
        
        // 提示标题
        CGFloat tipLabW = baseViewW - 20;
        CGFloat tipLabH = 40 / 568.0 * kHeight;
        CGFloat tipLabX = 10;
        CGFloat tipLabY = 15 / 568.0 * kHeight;
        UILabel *tipLab = [[UILabel alloc] initWithFrame:CGRectMake(tipLabX, tipLabY, tipLabW, tipLabH)];
        tipLab.backgroundColor = [UIColor whiteColor];
        tipLab.text = tipName;
        tipLab.textAlignment = NSTextAlignmentLeft;
        tipLab.font = [UIFont systemFontOfSize:17 / 320.0 * kWidth];
        [topView addSubview:tipLab];
        tipLab.layer.cornerRadius = 7.5;
//        tipLab.clipsToBounds = YES;
        
        // 右上方按钮
        CGFloat rightUpButW = topViewW - 7.5 / 568 * kHeight;
        CGFloat rightUpButH = 40 / 568.0 * kHeight;
        CGFloat rightUpButX = 0;
        CGFloat rightUpButY = 0;
        UIButton *rightUpBut = [UIButton buttonWithType:UIButtonTypeCustom];
        rightUpBut.frame = CGRectMake(rightUpButX, rightUpButY, rightUpButW, rightUpButH);
        [rightUpBut setImage:butNorImg forState:UIControlStateNormal];
        [rightUpBut setImage:butHigImg forState:UIControlStateHighlighted];
        rightUpBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [topView addSubview:rightUpBut];
        [rightUpBut addTarget:self action:@selector(okButClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        // 分界线
        CGFloat lineViewW = baseViewW;
        CGFloat lineViewH = 1;
        CGFloat lineViewX = 0;
        CGFloat lineViewY = CGRectGetMaxY(topView.frame);
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH)];
        lineView.backgroundColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        [baseView addSubview:lineView];
        
        
        // 提示文本
        NSString *fenStr = tipMessageStr;
        NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
        fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake(baseViewW - 50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
        CGFloat msgLabW = baseViewW - 40;
        CGFloat msgLabH = fenRect.size.height + 6;
        CGFloat msgLabX = 20;
        CGFloat msgLabY = CGRectGetMaxY(tipLab.frame) + 20;
        UILabel *msgLab = [[UILabel alloc] initWithFrame:CGRectMake(msgLabX, msgLabY, msgLabW, msgLabH)];
        msgLab.numberOfLines = 0;
        msgLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        msgLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        msgLab.textAlignment = NSTextAlignmentCenter;
        // 设置行距
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:tipMessageStr];
        NSMutableParagraphStyle *paStyle = [[NSMutableParagraphStyle alloc] init];
        paStyle.lineSpacing = 2;
        [attStr addAttribute:NSParagraphStyleAttributeName value:paStyle range:NSMakeRange(0, [tipMessageStr length])];
        msgLab.attributedText = attStr;
        //        [msgLab sizeToFit]; // 这个是自适应
        [baseView addSubview:msgLab];
        
        // 下方按钮
        NSString *nameStr = buttonArray[0];
        NSMutableDictionary *attDic = [[NSMutableDictionary alloc] init];
        attDic[NSFontAttributeName] = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
        attDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
        CGRect strRect = [nameStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
        CGFloat okButW = baseViewW;
        CGFloat okButH = tipLabH;
        CGFloat okButX = 0;
        CGFloat okButY= CGRectGetMaxY(msgLab.frame) + 20;
        _okBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBut.frame = CGRectMake(okButX, okButY, okButW, okButH);
        [baseView addSubview:_okBut];
        CGFloat okLabW = strRect.size.width + 20;
        CGFloat okLabH = 30;
        CGFloat okLabX = (baseViewW - okLabW) / 2.0;
        CGFloat okLabY = (okButH - okLabH) / 2.0;
        UILabel *okLab = [[UILabel alloc] initWithFrame:CGRectMake(okLabX, okLabY, okLabW, okLabH)];
        okLab.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        okLab.textColor = [UIColor whiteColor];
        okLab.text = nameStr;
        okLab.font = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
        okLab.textAlignment = NSTextAlignmentCenter;
        okLab.layer.cornerRadius = 7.5;
        okLab.clipsToBounds = YES;
        [_okBut addSubview:okLab];
        _okBut.layer.cornerRadius = 7.5;
        
        [_okBut addTarget:self action:@selector(okButClick) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat baseViewH2 = CGRectGetMaxY(_okBut.frame);
        baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH2);
        
    }
    
    return self;
}

- (instancetype)initWithHeadImageURL:(NSString *)imageURL name:(NSString *)name mark:(float )mark orderNumber:(NSInteger )orderNumber goodNumber:(float)good order:(NSString *)order{
    self = [super init];
    if (self) {
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        
        // 基础View
        CGFloat baseViewW = [UIScreen mainScreen].bounds.size.width - 2 * [UIScreen mainScreen].bounds.size.width * 0.1;
        CGFloat baseViewH = 300;
        CGFloat baseViewX = [UIScreen mainScreen].bounds.size.width * 0.1;
        CGFloat baseViewY = 130 / 568.0 * [UIScreen mainScreen].bounds.size.height;
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:baseView];
        baseView.layer.cornerRadius = 7.5;
        baseView.clipsToBounds = YES;
        
        
        
        CGFloat msgRightButH = 40;
        CGFloat kWidth = baseView.frame.size.width;
        CGFloat kHeight = baseView.frame.size.height;
        CGFloat jianjv1 = kWidth * 0.028;
        CGFloat jianjv2 = kWidth * 0.042;
        
        
        // 左边头像
        CGFloat iconImgViewW = kWidth * 0.176;
        CGFloat iconImgViewH = iconImgViewW;
        CGFloat iconImgViewX = jianjv2;
        CGFloat iconImgViewY = (msgRightButH - iconImgViewH) / 2.0+40;
        UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iconImgViewX, iconImgViewY, iconImgViewW, iconImgViewH)];
        iconImgView.layer.cornerRadius = iconImgViewW / 2.0;
        iconImgView.clipsToBounds = YES;
        iconImgView.contentMode = UIViewContentModeScaleAspectFill;
        iconImgView.image = [UIImage imageNamed:@"11.png"];
        [baseView addSubview:iconImgView];
        // 姓名
        NSString *nameStr = @"陈光法";
        NSMutableDictionary *attDic = [[NSMutableDictionary alloc] init];
        attDic[NSFontAttributeName] = [UIFont systemFontOfSize:16 / 320.0 * kWidth];
        attDic[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect strRect = [nameStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
        CGFloat nameLabW = strRect.size.width + jianjv1;
        CGFloat nameLabH = iconImgViewH / 2.0;
        CGFloat nameLabX = CGRectGetMaxX(iconImgView.frame) + jianjv2;
        CGFloat nameLabY = iconImgViewY + 2;
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, nameLabY, nameLabW, nameLabH)];
        nameLab.font = [UIFont systemFontOfSize:16.5 / 320.0 * kWidth];
        nameLab.text = nameStr;
        [baseView addSubview:nameLab];
        // 星星
        for(int i=0; i<5; i++) {
            
            CGFloat starImgViewW = strRect.size.height;
            CGFloat starImgViewH = starImgViewW;
            CGFloat starImgViewX = CGRectGetMaxX(nameLab.frame) + starImgViewW * i;
            CGFloat starImgViewY = nameLabY + 3.5 / 568 * kHeight;
            UIImageView *starImgView = [[UIImageView alloc] initWithFrame:CGRectMake(starImgViewX, starImgViewY, starImgViewW, starImgViewH)];
            starImgView.contentMode = UIViewContentModeScaleAspectFit;
            starImgView.image = [UIImage imageNamed:@"detailsStarDark.png"];
            [baseView addSubview:starImgView];
        }
        for(int i=0; i<3; i++) {
            
            CGFloat starImgViewW = strRect.size.height;
            CGFloat starImgViewH = starImgViewW;
            CGFloat starImgViewX = CGRectGetMaxX(nameLab.frame) + starImgViewW * i;
            CGFloat starImgViewY = nameLabY + 3.5 / 568 * kHeight;
            UIImageView *starImgView = [[UIImageView alloc] initWithFrame:CGRectMake(starImgViewX, starImgViewY, starImgViewW, starImgViewH)];
            starImgView.contentMode = UIViewContentModeScaleAspectFit;
            starImgView.image = [UIImage imageNamed:@"information.png"];
            [baseView addSubview:starImgView];
        }
        // 评分
        NSString *fenStr = @"2.7";
        NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
        fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
        CGFloat fenLabW = fenRect.size.width + 10;
        CGFloat fenLabH = strRect.size.height;
        CGFloat fenLabX = CGRectGetMaxX(nameLab.frame) + strRect.size.height * 5 + jianjv1;
        CGFloat fenLabY = nameLabY + 3.5 / 568 * kHeight;
        UILabel *fenLab = [[UILabel alloc] initWithFrame:CGRectMake(fenLabX, fenLabY, fenLabW, fenLabH)];
        fenLab.textColor = [UIColor whiteColor];
        fenLab.textAlignment = NSTextAlignmentCenter;
        fenLab.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        fenLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        fenLab.text = fenStr;
        fenLab.layer.cornerRadius = 7.5;
        fenLab.clipsToBounds = YES;
        [baseView addSubview:fenLab];
        // 订单数
        CGFloat indentLabW = kWidth * 0.16;
        CGFloat indentLabH = nameLabH;
        CGFloat indentLabX = nameLabX;
        CGFloat indentLabY = CGRectGetMaxY(nameLab.frame);
        UILabel *indentLab = [[UILabel alloc] initWithFrame:CGRectMake(indentLabX, indentLabY, indentLabW, indentLabH)];
        indentLab.text = @"订单数";
        indentLab.font = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
        [baseView addSubview:indentLab];
        NSString *numStr = @"999";
        NSMutableDictionary *numDic = [[NSMutableDictionary alloc] init];
        numDic[NSFontAttributeName] = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
        numDic[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect numRect = [numStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:numDic context:nil];
        CGFloat numLabW = numRect.size.width;
        CGFloat numLabH = indentLabH;
        CGFloat numLabX = CGRectGetMaxX(indentLab.frame) - 3;
        CGFloat numLabY = indentLabY;
        UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(numLabX, numLabY, numLabW, numLabH)];
        numLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        numLab.font = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
        numLab.text = numStr;
        [baseView addSubview:numLab];
        //好评率
        CGFloat goodLabW = indentLabW;
        CGFloat goodLabH = indentLabH;
        CGFloat goodLabX = CGRectGetMaxX(numLab.frame) + jianjv1;
        CGFloat goodLabY = indentLabY;
        UILabel *goodLab = [[UILabel alloc] initWithFrame:CGRectMake(goodLabX, goodLabY, goodLabW, goodLabH)];
        goodLab.text = @"好评率";
        goodLab.font = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
        [baseView addSubview:goodLab];
        NSString *proStr = @"99.99%";
        NSMutableDictionary *proDic = [[NSMutableDictionary alloc] init];
        proDic[NSFontAttributeName] = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
        proDic[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect proRect = [proStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:proDic context:nil];
        CGFloat proLabW = proRect.size.width;
        CGFloat proLabH = goodLabH;
        CGFloat proLabX = CGRectGetMaxX(goodLab.frame) - 3;
        CGFloat proLabY = goodLabY;
        UILabel *proLab = [[UILabel alloc] initWithFrame:CGRectMake(proLabX, proLabY, proLabW, proLabH)];
        proLab.text = proStr;
        proLab.font = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
        proLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        [baseView addSubview:proLab];
        
        
        // 右上方按钮
       
        UIButton *rightUpBut = [UIButton buttonWithType:UIButtonTypeCustom];
        rightUpBut.frame = CGRectMake(baseView.frame.size.width-40, 5, 30, 30);
        [rightUpBut setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [rightUpBut setImage:[UIImage imageNamed:@"deleteClick"] forState:UIControlStateHighlighted];
        rightUpBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [baseView addSubview:rightUpBut];
        [rightUpBut addTarget:self action:@selector(okButClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        
        
        
        
        // 分界线
        CGFloat lineViewW = baseViewW;
        CGFloat lineViewH = 1;
        CGFloat lineViewX = 0;
        CGFloat lineViewY = CGRectGetMaxY(iconImgView.frame);
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineViewX, lineViewY+10, lineViewW, lineViewH)];
        lineView.backgroundColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1];
        [baseView addSubview:lineView];
        
        
        // 提示文本
        NSString *fenStr2 = [NSString stringWithFormat:@"邀请你参与%@的订单，订单123eweq125erqe23154qe213编号%@",@"美容清洁",order];
        NSMutableDictionary *fenDic2 = [[NSMutableDictionary alloc] init];
        fenDic2[NSFontAttributeName] = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        fenDic2[NSForegroundColorAttributeName] = [UIColor blackColor];
        CGRect fenRect2 = [fenStr2 boundingRectWithSize:CGSizeMake(baseViewW - 50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic2 context:nil];
        CGFloat msgLabW = baseViewW - 40;
        CGFloat msgLabH = fenRect2.size.height + 6;
        CGFloat msgLabX = 20;
        CGFloat msgLabY = CGRectGetMaxY(lineView.frame) + 10;
        UILabel *msgLab = [[UILabel alloc] initWithFrame:CGRectMake(msgLabX, msgLabY, msgLabW, msgLabH)];
        msgLab.numberOfLines = 0;
        msgLab.font = [UIFont systemFontOfSize:15 / 320.0 * kWidth];
        msgLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        msgLab.textAlignment = NSTextAlignmentCenter;
        // 设置行距
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:fenStr2];
        NSMutableParagraphStyle *paStyle = [[NSMutableParagraphStyle alloc] init];
        paStyle.lineSpacing = 2;
        [attStr addAttribute:NSParagraphStyleAttributeName value:paStyle range:NSMakeRange(0, [fenStr2 length])];
        msgLab.attributedText = attStr;
        //        [msgLab sizeToFit]; // 这个是自适应
        [baseView addSubview:msgLab];
        
        // 下方按钮
        NSString *nameStr2 = @"查看订单";
        NSMutableDictionary *attDic2 = [[NSMutableDictionary alloc] init];
        attDic2[NSFontAttributeName] = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
        attDic2[NSForegroundColorAttributeName] = [UIColor whiteColor];
        CGRect strRect2 = [nameStr2 boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
        CGFloat okButW = baseViewW;
        CGFloat okButH = 30;
        CGFloat okButX = 0;
        CGFloat okButY= CGRectGetMaxY(msgLab.frame) + 10;
        _okBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBut.frame = CGRectMake(okButX, okButY, okButW, okButH);
        [baseView addSubview:_okBut];
        CGFloat okLabW = strRect2.size.width + 20;
        CGFloat okLabH = 30;
        CGFloat okLabX = (baseViewW - okLabW) / 2.0;
        CGFloat okLabY = (okButH - okLabH) / 2.0;
        UILabel *okLab = [[UILabel alloc] initWithFrame:CGRectMake(okLabX, okLabY, okLabW, okLabH)];
        okLab.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        okLab.textColor = [UIColor whiteColor];
        okLab.text = nameStr;
        okLab.font = [UIFont systemFontOfSize:14.5 / 320.0 * kWidth];
        okLab.textAlignment = NSTextAlignmentCenter;
        okLab.layer.cornerRadius = 7.5;
        okLab.clipsToBounds = YES;
        [_okBut addSubview:okLab];
        _okBut.layer.cornerRadius = 7.5;
        
        [_okBut addTarget:self action:@selector(okButClick) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat baseViewH2 = CGRectGetMaxY(_okBut.frame);
        baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH2+10);
        
        
        
        
        
        
        
        
        
    }
    
    return self;
}


- (void)okButClick {

    [self removeFromSuperview];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
