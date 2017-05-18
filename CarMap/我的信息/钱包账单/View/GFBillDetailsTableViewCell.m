//
//  GFBillDetailsTableViewCell.m
//  CarMap
//
//  Created by 陈光法 on 16/2/25.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFBillDetailsTableViewCell.h"
#import "CLImageView.h"

@interface GFBillDetailsTableViewCell()

@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UILabel *lab4;

@end


@implementation GFBillDetailsTableViewCell

- (void)setPlaceText:(NSString *)placeText {

    _placeText = placeText;
    
    self.lab1.hidden = NO;
    self.lab2.hidden = NO;
    self.lab3.hidden = NO;
    self.lab4.hidden = NO;
    
    
    if([placeText isEqualToString:@"无"]) {
    
        self.lab1.hidden = YES;
        self.lab2.hidden = YES;
        self.lab3.hidden = YES;
        self.lab4.hidden = YES;
    }else {
    
        NSArray *arr = [placeText componentsSeparatedByString:@","];
        if(arr.count == 1) {
            self.lab1.text = arr[0];
            
            self.lab2.hidden = YES;
            self.lab3.hidden = YES;
            self.lab4.hidden = YES;
        }else if(arr.count == 2){
            
            self.lab1.text = arr[0];
            self.lab2.text = arr[1];
            
            self.lab3.hidden = YES;
            self.lab4.hidden = YES;
        }else if(arr.count == 3){
            
            self.lab1.text = arr[0];
            self.lab2.text = arr[1];
            self.lab3.text = arr[2];
            
            self.lab4.hidden = YES;
        }else if(arr.count == 4){
            
            self.lab1.text = arr[0];
            self.lab2.text = arr[1];
            self.lab3.text = arr[2];
            self.lab4.text = arr[3];
        }
    }
    
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
//    CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat jiange = kWidth * 0.033;
//    CGFloat jiange1 = kWidth * 0.056;

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    if(self != nil) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
        
        // 基础视图
        CGFloat baseViewW = kWidth;
        CGFloat baseViewH = 130;
        CGFloat baseViewX = 0;
        CGFloat baseViewY = 10;
        self.baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        self.baseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.baseView];
        
        // 订单编号
        CGFloat numberLabW = kWidth - jiange * 2;
        CGFloat numberLabH = 25;
        CGFloat numberLabX = 10;
        CGFloat numberLabY = 0;
        self.numberLab = [[UILabel alloc] initWithFrame:CGRectMake(numberLabX, numberLabY, numberLabW, numberLabH)];
        self.numberLab.text = @"订单编号：sdjfhashdfgs";
        self.numberLab.font = [UIFont systemFontOfSize:14];
        [self.baseView addSubview:self.numberLab];
        
        
//        // 订单图片
//        CGFloat photoImgViewW = kWidth - jiange * 2;
//        CGFloat photoImgViewH = kHeight * 0.2344;
//        CGFloat photoImgViewX = jiange;
//        CGFloat photoImgViewY = CGRectGetMaxY(self.numberLab.frame) + kHeight * 0.013;
//        self.photoImgView = [[CLImageView alloc] initWithFrame:CGRectMake(photoImgViewX, photoImgViewY, photoImgViewW, photoImgViewH)];
//        self.photoImgView.contentMode = UIViewContentModeScaleAspectFit;
//        self.photoImgView.image = [UIImage imageNamed:@"orderImage.png"];
//        [self.baseView addSubview:self.photoImgView];
        
        for(int i=0; i<4; i++) {
            
            UILabel *lab = [[UILabel alloc] init];
            lab.frame = CGRectMake(11 + 72 * i, 40, 65, 30);
            //            lab.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:0.9];
            lab.backgroundColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1];
            lab.font = [UIFont systemFontOfSize:13];
            //            lab.textColor = [UIColor whiteColor];
            lab.textColor = [UIColor darkGrayColor];
            lab.layer.cornerRadius = 7;
            lab.clipsToBounds = YES;
            lab.textAlignment = NSTextAlignmentCenter;
            lab.text = @"美容清洁";
            [self.baseView addSubview:lab];
            //            lab.hidden = YES;
            //            [self.labArr addObject:lab];
            if(i == 0) {
                self.lab1 = lab;
            }
            if(i == 1) {
                self.lab2 = lab;
            }
            if(i == 2) {
                self.lab3 = lab;
            }
            if(i == 3) {
                self.lab4 = lab;
            }
        }
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(11, 85, [UIScreen mainScreen].bounds.size.width - 22, 1)];
        lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
        [self.baseView addSubview:lineView];
        
        
        // 施工时间
        CGFloat timeLabW = kWidth - 10 * 2;
        CGFloat timeLabH = 25;
        CGFloat timeLabX = 10;
        CGFloat timeLabY = CGRectGetMaxY(lineView.frame) + 10;
        self.timeLab = [[UILabel alloc] initWithFrame:CGRectMake(timeLabX, timeLabY, timeLabW, timeLabH)];
        self.timeLab.text = @"完成时间：公元前1993年";
        self.timeLab.font = [UIFont systemFontOfSize:13 /320.0 * kWidth];
        [self.baseView addSubview:self.timeLab];
        // 金额
        CGFloat moneyLabW = 120;
        CGFloat moneyLabH = 25;
        CGFloat moneyLabX = [UIScreen mainScreen].bounds.size.width - 10 - 120;
        CGFloat moneyLabY = self.timeLab.frame.origin.y;
        self.moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(moneyLabX, moneyLabY, moneyLabW, moneyLabH)];
        self.moneyLab.text = @"￥200";
        self.moneyLab.textAlignment = NSTextAlignmentRight;
        self.moneyLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        self.moneyLab.font = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
        [self.baseView addSubview:self.moneyLab];


//        // 施工部位
//        CGFloat labppW = kWidth * 0.21;
//        CGFloat labppH = timeLabH;
//        CGFloat labppX = timeLabX;
//        CGFloat labppY = CGRectGetMaxY(self.timeLab.frame);
//        UILabel *labpp = [[UILabel alloc] initWithFrame:CGRectMake(labppX, labppY, labppW, labppH)];
//        labpp.text = @"施工部位：";
//        labpp.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
//        [self.baseView addSubview:labpp];
//        
//        CGFloat placeLabW = timeLabW - labppW;
//        CGFloat placeLabH = timeLabH;
//        CGFloat placeLabX = CGRectGetMaxX(labpp.frame);
//        CGFloat placeLabY = CGRectGetMaxY(self.timeLab.frame) + 10.5 / 568.0 * kHeight;
//        self.placeLab = [[UILabel alloc] initWithFrame:CGRectMake(placeLabX, placeLabY, placeLabW, placeLabH)];
//        self.placeLab.text = @"脑袋";
//        self.placeLab.font = [UIFont systemFontOfSize:13 /320.0 * kWidth];
//        self.placeLab.numberOfLines = 0;
//        [self.baseView addSubview:self.placeLab];
//        
//        self.placeLabX = placeLabX;
//        self.placeLabY = placeLabY;
//        self.placeLabW = placeLabW;
//        self.placeLabH = placeLabH;
//        
//        // 边线
//        UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 1)];
//        upLine.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
//        [self.baseView addSubview:upLine];
//        
//        self.downLine = [[UIView alloc] initWithFrame:CGRectMake(0, baseViewH - 1, kWidth, 1)];
//        self.downLine.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
//        [self.baseView addSubview:self.downLine];
//        
//        UIView *line_1 = [[UIView alloc] initWithFrame:CGRectMake(photoImgViewX, CGRectGetMaxY(self.numberLab.frame), photoImgViewW, 1)];
//        line_1.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
//        [self.baseView addSubview:line_1];
//        
//        UIView *line_2 = [[UIView alloc] initWithFrame:CGRectMake(photoImgViewX, CGRectGetMinY(self.timeLab.frame), photoImgViewW, 1)];
//        line_2.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
//        [self.baseView addSubview:line_2];
//        
//        UIView *line_3 = [[UIView alloc] initWithFrame:CGRectMake(photoImgViewX, CGRectGetMaxY(self.timeLab.frame), photoImgViewW, 1)];
//        line_3.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
//        [self.baseView addSubview:line_3];
    
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
