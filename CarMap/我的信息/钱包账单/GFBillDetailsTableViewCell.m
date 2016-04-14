//
//  GFBillDetailsTableViewCell.m
//  CarMap
//
//  Created by 陈光法 on 16/2/25.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFBillDetailsTableViewCell.h"

@implementation GFBillDetailsTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat jiange = kWidth * 0.033;
    CGFloat jiange1 = kWidth * 0.056;

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    if(self != nil) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
        
        // 基础视图
        CGFloat baseViewW = kWidth;
        CGFloat baseViewH = kHeight * 0.464;
        CGFloat baseViewX = 0;
        CGFloat baseViewY = kHeight * 0.0183;
        self.baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        self.baseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.baseView];
        
        // 订单编号
        CGFloat numberLabW = kWidth - jiange * 2;
        CGFloat numberLabH = kHeight * 0.078125;
        CGFloat numberLabX = jiange;
        CGFloat numberLabY = 0;
        self.numberLab = [[UILabel alloc] initWithFrame:CGRectMake(numberLabX, numberLabY, numberLabW, numberLabH)];
        self.numberLab.text = @"订单编号sdjfhashdfgs";
        self.numberLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
        [self.baseView addSubview:self.numberLab];
        
        // 金额
        CGFloat moneyLabW = 200;
        CGFloat moneyLabH = numberLabH;
        CGFloat moneyLabX = kWidth - jiange - moneyLabW;
        CGFloat moneyLabY = numberLabY;
        self.moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(moneyLabX, moneyLabY, moneyLabW, moneyLabH)];
        self.moneyLab.text = @"￥200";
        self.moneyLab.textAlignment = NSTextAlignmentRight;
        self.moneyLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        self.moneyLab.font = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
        [self.baseView addSubview:self.moneyLab];
        
        // 订单图片
        CGFloat photoImgViewW = kWidth - jiange * 2;
        CGFloat photoImgViewH = kHeight * 0.2344;
        CGFloat photoImgViewX = jiange;
        CGFloat photoImgViewY = CGRectGetMaxY(self.numberLab.frame) + kHeight * 0.013;
        self.photoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(photoImgViewX, photoImgViewY, photoImgViewW, photoImgViewH)];
        self.photoImgView.contentMode = UIViewContentModeScaleAspectFit;
        self.photoImgView.image = [UIImage imageNamed:@"orderImage.png"];
        [self.baseView addSubview:self.photoImgView];
        
        // 施工时间
        CGFloat timeLabW = kWidth - jiange1 * 2;
        CGFloat timeLabH = (baseViewH - numberLabH - photoImgViewH - kHeight * 0.013 * 2) /2.0;
        CGFloat timeLabX = jiange1;
        CGFloat timeLabY = CGRectGetMaxY(self.photoImgView.frame) + kHeight * 0.013;
        self.timeLab = [[UILabel alloc] initWithFrame:CGRectMake(timeLabX, timeLabY, timeLabW, timeLabH)];
        self.timeLab.text = @"施工时间：公元前1993年";
        self.timeLab.font = [UIFont systemFontOfSize:13 /320.0 * kWidth];
        [self.baseView addSubview:self.timeLab];
        

        // 施工部位
        CGFloat labppW = kWidth * 0.21;
        CGFloat labppH = timeLabH;
        CGFloat labppX = timeLabX;
        CGFloat labppY = CGRectGetMaxY(self.timeLab.frame);
        UILabel *labpp = [[UILabel alloc] initWithFrame:CGRectMake(labppX, labppY, labppW, labppH)];
        labpp.text = @"施工部位：";
        labpp.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
        [self.baseView addSubview:labpp];
        
        CGFloat placeLabW = timeLabW - labppW;
        CGFloat placeLabH = timeLabH;
        CGFloat placeLabX = CGRectGetMaxX(labpp.frame);
        CGFloat placeLabY = CGRectGetMaxY(self.timeLab.frame) + 10.5 / 568.0 * kHeight;
        self.placeLab = [[UILabel alloc] initWithFrame:CGRectMake(placeLabX, placeLabY, placeLabW, placeLabH)];
        self.placeLab.text = @"脑袋";
        self.placeLab.font = [UIFont systemFontOfSize:13 /320.0 * kWidth];
        self.placeLab.numberOfLines = 0;
        [self.baseView addSubview:self.placeLab];
        
        self.placeLabX = placeLabX;
        self.placeLabY = placeLabY;
        self.placeLabW = placeLabW;
        self.placeLabH = placeLabH;
        
        // 边线
        UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 1)];
        upLine.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [self.baseView addSubview:upLine];
        
        self.downLine = [[UIView alloc] initWithFrame:CGRectMake(0, baseViewH - 1, kWidth, 1)];
        self.downLine.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [self.baseView addSubview:self.downLine];
        
        UIView *line_1 = [[UIView alloc] initWithFrame:CGRectMake(photoImgViewX, CGRectGetMaxY(self.numberLab.frame), photoImgViewW, 1)];
        line_1.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [self.baseView addSubview:line_1];
        
        UIView *line_2 = [[UIView alloc] initWithFrame:CGRectMake(photoImgViewX, CGRectGetMinY(self.timeLab.frame), photoImgViewW, 1)];
        line_2.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [self.baseView addSubview:line_2];
        
        UIView *line_3 = [[UIView alloc] initWithFrame:CGRectMake(photoImgViewX, CGRectGetMaxY(self.timeLab.frame), photoImgViewW, 1)];
        line_3.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [self.baseView addSubview:line_3];
    
    }
    
    return self;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
