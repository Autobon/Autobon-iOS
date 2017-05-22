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
        
// 商户名称
        CGFloat nameLabW = kWidth - jiange * 2;
        CGFloat nameLabH = 25;
        CGFloat nameLabX = jiange;
        CGFloat nameLabY = 10;
        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(nameLabX, nameLabY-5, nameLabW, nameLabH)];
        _nameLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
//        _nameLab.text = @"商户名称：测试商户";
        [baseView addSubview:_nameLab];
        
// 商户法人
        CGFloat peopleLabW = 240 / 375.0 * kWidth;
        CGFloat peopleLabH = 25;
        CGFloat peopleLabX = jiange;
        CGFloat peopleLabY = CGRectGetMaxY(_nameLab.frame);
        _peopleLab = [[UILabel alloc] initWithFrame:CGRectMake(peopleLabX, peopleLabY, peopleLabW, peopleLabH)];
        _peopleLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        _peopleLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
//        _peopleLab.text = @"商户法人：王老板";
        [baseView addSubview:_peopleLab];
        
// 联系方式
        CGFloat phoneLabW = nameLabW;
        CGFloat phoneLabH = 25;
        CGFloat phoneLabX = nameLabX;
        CGFloat phoneLabY = CGRectGetMaxY(_peopleLab.frame);
        _phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(phoneLabX, phoneLabY, phoneLabW, phoneLabH)];
        _phoneLab.font = [UIFont systemFontOfSize:13 / 320.0 * kWidth];
        _phoneLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
//        _phoneLab.text = @"联系方式：18672944895";
        [baseView addSubview:_phoneLab];
        
        
        // 移除
        _removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _removeButton.frame = CGRectMake(kWidth - jiange - kWidth * 0.185, 15, kWidth * 0.185, kHeight * 0.044);
        _removeButton.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
        _removeButton.layer.borderWidth = 1;
        _removeButton.layer.cornerRadius = 5;
        [_removeButton setTitle:@"移除" forState:UIControlStateNormal];
        _removeButton.titleLabel.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
        [_removeButton setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
        [baseView addSubview:_removeButton];
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


- (void)setModel:(CLCooperatorModel *)model{
    _nameLab.text = [NSString stringWithFormat:@"商户名称：%@",model.fullname];
    _peopleLab.text = [NSString stringWithFormat:@"商户法人：%@",model.corporationName];
    _phoneLab.text = [NSString stringWithFormat:@"联系方式：%@",model.contactPhone];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
