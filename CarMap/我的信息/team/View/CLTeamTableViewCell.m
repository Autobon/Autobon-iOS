//
//  CLTeamTableViewCell.m
//  CarMap
//
//  Created by inCar on 2018/7/3.
//  Copyright © 2018年 mll. All rights reserved.
//

#import "CLTeamTableViewCell.h"

@implementation CLTeamTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *baseView = [[UIView alloc]init];
        baseView.backgroundColor = [UIColor whiteColor];
        baseView.layer.borderWidth = 1;
        baseView.layer.borderColor = [UIColor blackColor].CGColor;
        [self addSubview:baseView];
        [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.left.equalTo(self).offset(-2);
            make.bottom.equalTo(self).offset(-5);
            make.right.equalTo(self).offset(2);
        }];
        
        _teamNameLabel = [[UILabel alloc]init];
        _teamNameLabel.font = [UIFont systemFontOfSize:14];
        [baseView addSubview:_teamNameLabel];
        [_teamNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView).offset(22);
            make.top.equalTo(baseView).offset(10);
            make.height.mas_offset(20);
            make.right.equalTo(baseView).offset(-20);
        }];
        
        
        _managerNameLabel = [[UILabel alloc]init];
        _managerNameLabel.font = [UIFont systemFontOfSize:14];
        [baseView addSubview:_managerNameLabel];
        [_managerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView).offset(22);
            make.top.equalTo(_teamNameLabel.mas_bottom).offset(10);
            make.height.mas_offset(20);
            make.right.equalTo(baseView).offset(-20);
        }];
        
        _managerPhoneLabel = [[UILabel alloc]init];
        _managerPhoneLabel.font = [UIFont systemFontOfSize:14];
        [baseView addSubview:_managerPhoneLabel];
        [_managerPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView).offset(22);
            make.top.equalTo(_managerNameLabel.mas_bottom).offset(10);
            make.height.mas_offset(20);
            make.right.equalTo(baseView).offset(-20);
        }];
        
        
    }
    return self;
}



- (void)setTeamModel:(CLTeamModel *)teamModel{
    _teamNameLabel.text = [NSString stringWithFormat:@"团队名称：%@",teamModel.name];
    _managerNameLabel.text = [NSString stringWithFormat:@"队长姓名：%@",teamModel.managerName];
    _managerPhoneLabel.text = [NSString stringWithFormat:@"队长电话：%@",teamModel.managerPhone];
}





- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
