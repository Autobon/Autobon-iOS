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
        UIView *baseView = [[UIView alloc] init];
        baseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:baseView];
        [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(5);
            make.bottom.equalTo(self).offset(-5);
        }];
// 商户名称
        _nameLab = [[UILabel alloc] init];
        _nameLab.font = [UIFont systemFontOfSize:14];
        _nameLab.text = @"商户名称：";
        [baseView addSubview:_nameLab];
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView).offset(10);
            make.width.mas_offset(75);
            make.top.equalTo(baseView).offset(15);
        }];
        
        _nameValueLab = [[UILabel alloc] init];
        _nameValueLab.font = [UIFont systemFontOfSize:14];
        _nameValueLab.numberOfLines = 0;
        _nameValueLab.text = @" ";
        [baseView addSubview:_nameValueLab];
        [_nameValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLab.mas_right).offset(-5);
            make.right.equalTo(baseView).offset(-70);
            make.top.equalTo(_nameLab).offset(0);
        }];
        
        
        
        
// 商户法人
        _peopleLab = [[UILabel alloc] init];
        _peopleLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        _peopleLab.font = [UIFont systemFontOfSize:14];
//        _peopleLab.text = @"商户法人：王老板";
        [baseView addSubview:_peopleLab];
        [_peopleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView).offset(10);
            make.right.equalTo(baseView).offset(-60);
            make.top.equalTo(_nameValueLab.mas_bottom).offset(10);
            make.height.mas_offset(20);
        }];
// 联系方式
        _phoneLab = [[UILabel alloc] init];
        _phoneLab.font = [UIFont systemFontOfSize:14];
        _phoneLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
//        _phoneLab.text = @"联系方式：18672944895";
        [baseView addSubview:_phoneLab];
        [_phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView).offset(10);
            make.right.equalTo(baseView).offset(-60);
            make.top.equalTo(_peopleLab.mas_bottom).offset(10);
            make.height.mas_offset(20);
        }];
        
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
    _nameValueLab.text = [NSString stringWithFormat:@"%@",model.fullname];
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
