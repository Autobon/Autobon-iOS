//
//  CLCollectTableViewCell.m
//  CarMapB
//
//  Created by inCar on 17/5/19.
//  Copyright © 2017年 mll. All rights reserved.
//

#import "CLCollectTableViewCell.h"

@implementation CLCollectTableViewCell






- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat jiange = kWidth * 0.033;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self != nil) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
        
        // 基础视图
        CGFloat baseViewW = kWidth;
        CGFloat baseViewH = 85;
        CGFloat baseViewX = 0;
        CGFloat baseViewY = 5;
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        baseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:baseView];
        
        
        CGFloat numberLabW = kWidth - jiange * 2;
        CGFloat numberLabH = 25;
        CGFloat numberLabX = jiange;
        CGFloat numberLabY = 10;
        UILabel *numberLab = [[UILabel alloc] initWithFrame:CGRectMake(numberLabX, numberLabY-5, numberLabW, numberLabH)];
        numberLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
        numberLab.text = @"商户名称：测试商户";
        [baseView addSubview:numberLab];
        
        // 工作内容
        CGFloat tipLabW = 240 / 375.0 * kWidth;
        CGFloat tipLabH = 25;
        CGFloat tipLabX = jiange;
        CGFloat tipLabY = CGRectGetMaxY(numberLab.frame);
        UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(tipLabX, tipLabY, tipLabW, tipLabH)];
//        timeLab.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        timeLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        timeLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
        timeLab.text = @"商户法人：王老板";
        [baseView addSubview:timeLab];
        
        // 预约时间
        CGFloat timeLabW = numberLabW;
        CGFloat timeLabH = 25;
        CGFloat timeLabX = numberLabX;
        CGFloat timeLabY = CGRectGetMaxY(timeLab.frame);
        UILabel *yuyueTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(timeLabX, timeLabY, timeLabW, timeLabH)];
        yuyueTimeLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
        yuyueTimeLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        yuyueTimeLab.text = @"联系方式：18672944895";
        [baseView addSubview:yuyueTimeLab];
        
        
        // 移除
        UIButton *pingjiaBut = [UIButton buttonWithType:UIButtonTypeCustom];
        pingjiaBut.frame = CGRectMake(kWidth - jiange - kWidth * 0.185, 15, kWidth * 0.185, kHeight * 0.044);
        pingjiaBut.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
        pingjiaBut.layer.borderWidth = 1;
        pingjiaBut.layer.cornerRadius = 5;
        [pingjiaBut setTitle:@"移除" forState:UIControlStateNormal];
        pingjiaBut.titleLabel.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
        [pingjiaBut setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
        [baseView addSubview:pingjiaBut];
//        [pingjiaBut addTarget:self action:@selector(pingjiaButClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        // 边线
        UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 1)];
        upLine.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [baseView addSubview:upLine];
        
        UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, baseView.frame.size.height - 1, kWidth, 1)];
        downLine.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
        [baseView addSubview:downLine];
        
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
