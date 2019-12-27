//
//  GFIndentTableViewCell.m
//  CarMap
//
//  Created by 陈光法 on 16/2/25.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFIndentTableViewCell.h"
#import "GFIndentModel.h"
#import "GFNewOrderModel.h"

@interface GFIndentTableViewCell()



@property (nonatomic, strong) UILabel *orderLab;
@property (nonatomic, strong) UILabel *vinLab;
@property (nonatomic, strong) UILabel *proLab;
@property (nonatomic, strong) UILabel *workTimeLab;

@property (nonatomic, strong) UILabel *mLab;
@property (nonatomic, strong) UILabel *statusLab;

@property (nonatomic, strong) NSMutableArray *labArr;

@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UILabel *lab4;
@end

@implementation GFIndentTableViewCell



- (void)setModel:(GFNewOrderModel *)model {
    
//    NSLog(@"++++=====++++");
    
    _model = model;
    
    self.mLab.hidden = NO;
    if([model.payStatus integerValue] == 1) {
        
        self.statusLab.text = @"未结算";
        self.statusLab.textColor = [UIColor lightGrayColor];
        self.mLab.text = [NSString stringWithFormat:@"合计：¥%0.1f", [model.payment floatValue]];
    }else if(([model.payment integerValue] == 0)){
    
        self.statusLab.text = @"待计算";
        self.statusLab.textColor = [UIColor lightGrayColor];
        self.mLab.hidden = YES;
    }else {
        
        self.statusLab.text = @"已结算";
        self.statusLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        self.mLab.text = [NSString stringWithFormat:@"合计：%@", model.payment];
    }
    
    self.orderLab.text = [NSString stringWithFormat:@"车牌号：%@", model.license];
    self.vinLab.text = [NSString stringWithFormat:@"车架号：%@", model.vin];
    
    self.workTimeLab.text = [NSString stringWithFormat:@"施工时间：%@", model.startTime];
    
    
    self.lab1.hidden = NO;
    self.lab2.hidden = NO;
    self.lab3.hidden = NO;
    self.lab4.hidden = NO;

    
    NSArray *arr = [model.typeName componentsSeparatedByString:@","];
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
//    for(int i=0; i<arr.count; i++) {
//        UILabel *lab = (UILabel *)self.labArr[i];
//        lab.text = arr[i];
//        lab.frame = CGRectMake(11 + 72 * i, 40, 65, 30);
//        lab.hidden = NO;
//    }
//    self.mLab.text = [NSString stringWithFormat:@"%@", model.payment];
//    self.statusLab.text = [NSString stringWithFormat:@"%@", model.payStatus];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

//    CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
//    CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
//    CGFloat jiange = kWidth * 0.033;
//    CGFloat jiange1 = kWidth * 0.056;
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    if(self != nil) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
        
        UIView *vv = [[UIView alloc] init];
        vv.backgroundColor = [UIColor whiteColor];
        vv.frame = CGRectMake(-1, 10, [UIScreen mainScreen].bounds.size.width + 2, 160);
        vv.layer.borderColor = [[UIColor colorWithRed:217 / 255.0 green:217 / 255.0 blue:217 / 255.0 alpha:1] CGColor];
        vv.layer.borderWidth = 1;
        [self.contentView addSubview:vv];
        
        self.orderLab = [[UILabel alloc] initWithFrame:CGRectMake(11, 7, 250, 25)];
        self.orderLab.text = @"订单编号：999999999999999";
        self.orderLab.textColor = [UIColor darkGrayColor];
        self.orderLab.font = [UIFont systemFontOfSize:14];
        [vv addSubview:self.orderLab];
        
        
        self.vinLab = [[UILabel alloc] initWithFrame:CGRectMake(11, 37, 250, 25)];
        self.vinLab.text = @"车架号：999999999999999";
        self.vinLab.textColor = [UIColor darkGrayColor];
        self.vinLab.font = [UIFont systemFontOfSize:14];
        [vv addSubview:self.vinLab];
        
        
        
        
//        self.orderLab.backgroundColor = [UIColor redColor];
        
        for(int i=0; i<4; i++) {
        
            UILabel *lab = [[UILabel alloc] init];
            lab.frame = CGRectMake(11 + 72 * i, 70, 65, 30);
//            lab.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:0.9];
            lab.backgroundColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1];
            lab.font = [UIFont systemFontOfSize:13];
//            lab.textColor = [UIColor whiteColor];
            lab.textColor = [UIColor darkGrayColor];
            lab.layer.cornerRadius = 7;
            lab.clipsToBounds = YES;
            lab.textAlignment = NSTextAlignmentCenter;
            lab.text = @"美容清洁";
            [vv addSubview:lab];
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
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(11, 115, [UIScreen mainScreen].bounds.size.width - 22, 1)];
        lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
        [vv addSubview:lineView];
        
        self.workTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(11, CGRectGetMaxY(lineView.frame) + 10, 300, 25)];
        self.workTimeLab.text = @"施工时间：2016-12-02 17:31";
        self.workTimeLab.textColor = [UIColor lightGrayColor];
        self.workTimeLab.font = [UIFont systemFontOfSize:13.5];
        [vv addSubview:self.workTimeLab];
        
        
//        self.proLab = [[UILabel alloc] initWithFrame:CGRectMake(11, CGRectGetMaxY(self.workTimeLab.frame), 300, 25)];
//        self.proLab.text = @"隔热膜，隐形车衣，车身改色，美容清洁";
//        self.proLab.textColor = [UIColor orangeColor];
//        self.proLab.font = [UIFont systemFontOfSize:15];
//        [vv addSubview:self.proLab];
        
        self.statusLab = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 10 - 120, self.orderLab.frame.origin.y, 120, 25)];
        self.statusLab.text = @"已结算";
        self.statusLab.textAlignment = NSTextAlignmentRight;
        self.statusLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        self.statusLab.font = [UIFont systemFontOfSize:14];
        [vv addSubview:self.statusLab];
        
        self.mLab = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 10 - 120, self.workTimeLab.frame.origin.y, 120, 25)];
        self.mLab.text = @"合计:¥ 2000";
        self.mLab.textAlignment = NSTextAlignmentRight;
        self.mLab.textColor = [UIColor lightGrayColor];
        self.mLab.font = [UIFont systemFontOfSize:14.5];
        [vv addSubview:self.mLab];
        
//        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.orderLab.frame) - 50, 7, 25, 25)];
//        imgView.image = [UIImage imageNamed:@"jingbao"];
//        [vv addSubview:imgView];
        
        
        
        /*
        // 基础视图
        CGFloat baseViewW = kWidth;
        CGFloat baseViewH = kHeight * 0.464  - kHeight * 0.2344;
        CGFloat baseViewX = 0;
        CGFloat baseViewY = kHeight * 0.0183;
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        baseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:baseView];
        
        // 订单编号
        CGFloat numberLabW = kWidth - jiange * 2;
        CGFloat numberLabH = kHeight * 0.078125;
        CGFloat numberLabX = jiange;
        CGFloat numberLabY = 0;
        self.numberLab = [[UILabel alloc] initWithFrame:CGRectMake(numberLabX, numberLabY, numberLabW, numberLabH)];
        self.numberLab.text = @"订单编号sdjfhashdfgs";
        self.numberLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
        [baseView addSubview:self.numberLab];
        
        // 竖条
        UIView *shuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4 / 320.0 * kWidth, numberLabH)];
        shuView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        [baseView addSubview:shuView];
        
        // 金额
        CGFloat moneyLabW = 200;
        CGFloat moneyLabH = numberLabH / 2.0;
        CGFloat moneyLabX = kWidth - jiange - moneyLabW;
        CGFloat moneyLabY = numberLabY + 3   / 568.0 * kHeight;
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
        self.tipLabel = [[UILabel alloc]init];
        self.tipLabel.frame = CGRectMake(tipButX, tipButY, tipButW, tipButH);
//        [self.tipBut setTitle:@"未结算" forState:UIControlStateNormal];
//        [self.tipBut setTitle:@"已结算" forState:UIControlStateSelected];
//        [self.tipLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self.tipBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateSelected];
        self.tipLabel.font = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
//        self.tipBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.tipLabel.textAlignment = NSTextAlignmentRight;
        [baseView addSubview:self.tipLabel];
        
//        // 订单图片
//        CGFloat photoImgViewW = kWidth - jiange * 2;
//        CGFloat photoImgViewH = kHeight * 0.2344;
//        CGFloat photoImgViewX = jiange;
//        CGFloat photoImgViewY = CGRectGetMaxY(self.numberLab.frame) + kHeight * 0.013;
//        self.photoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(photoImgViewX, photoImgViewY, photoImgViewW, photoImgViewH)];
//        _photoImgView.contentMode = UIViewContentModeScaleAspectFit;
//        self.photoImgView.image = [UIImage imageNamed:@"orderImage.png"];
//        [baseView addSubview:self.photoImgView];
        
        // 施工时间
        CGFloat timeLabW = kWidth - jiange1 * 2;
        CGFloat timeLabH = (baseViewH - numberLabH - kHeight * 0.013 * 2) /2.0;
        CGFloat timeLabX = jiange1;
        CGFloat timeLabY = CGRectGetMaxY(self.numberLab.frame) + kHeight * 0.013;
        self.timeLab = [[UILabel alloc] initWithFrame:CGRectMake(timeLabX, timeLabY, timeLabW, timeLabH)];
        self.timeLab.text = @"施工时间：公元前1993年";
        self.timeLab.font = [UIFont systemFontOfSize:13 /320.0 * kWidth];
        [baseView addSubview:self.timeLab];
        
        // 施工部位
        CGFloat placeLabW = timeLabW;
        CGFloat placeLabH = timeLabH;
        CGFloat placeLabX = timeLabX;
        CGFloat placeLabY = CGRectGetMaxY(self.timeLab.frame);
        self.placeLab = [[UILabel alloc] initWithFrame:CGRectMake(placeLabX, placeLabY, placeLabW, placeLabH)];
        self.placeLab.text = @"施工部位：脑袋";
        self.placeLab.font = [UIFont systemFontOfSize:13 /320.0 * kWidth];
        [baseView addSubview:self.placeLab];
        
        // 边线
        UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 1)];
        upLine.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [baseView addSubview:upLine];
        
        UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, baseViewH - 1, kWidth, 1)];
        downLine.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [baseView addSubview:downLine];
        
//        UIView *line_1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.numberLab.frame), kWidth, 1)];
//        line_1.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
//        [baseView addSubview:line_1];
//        
//        UIView *line_2 = [[UIView alloc] initWithFrame:CGRectMake(photoImgViewX, CGRectGetMinY(self.timeLab.frame), photoImgViewW, 1)];
//        line_2.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
//        [baseView addSubview:line_2];
//        
//        UIView *line_3 = [[UIView alloc] initWithFrame:CGRectMake(photoImgViewX, CGRectGetMaxY(self.timeLab.frame), photoImgViewW, 1)];
//        line_3.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
//        [baseView addSubview:line_3];
         
         */
        
    }
    
    return self;

}

- (void)setWorkItems:(NSString *)workItems {
    
    self.workItems = workItems;

    if(workItems != nil) {
        
        
        
    }
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
