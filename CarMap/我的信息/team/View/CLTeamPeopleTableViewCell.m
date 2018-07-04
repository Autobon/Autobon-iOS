//
//  CLTeamPeopleTableViewCell.m
//  CarMap
//
//  Created by inCar on 2018/7/4.
//  Copyright © 2018年 mll. All rights reserved.
//

#import "CLTeamPeopleTableViewCell.h"

@implementation CLTeamPeopleTableViewCell




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
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        [baseView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView).offset(22);
            make.top.equalTo(baseView).offset(10);
            make.height.mas_offset(20);
            make.width.mas_offset(80);
        }];
        
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.font = [UIFont systemFontOfSize:14];
        [baseView addSubview:_phoneLabel];
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLabel.mas_right).offset(5);
            make.top.equalTo(baseView).offset(10);
            make.height.mas_offset(20);
            make.width.mas_offset(120);
        }];
        
        _statusLabel = [[UILabel alloc]init];
        _statusLabel.font = [UIFont systemFontOfSize:15];
        _statusLabel.textAlignment = NSTextAlignmentRight;
        _statusLabel.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        [baseView addSubview:_statusLabel];
        [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(baseView).offset(-20);
            make.top.equalTo(baseView).offset(10);
            make.height.mas_offset(20);
            make.width.mas_offset(120);
        }];
        
        
        //隔热膜
        _filmLevelLabel = [[UILabel alloc]init];
        _filmLevelLabel.font = [UIFont systemFontOfSize:14];
        [baseView addSubview:_filmLevelLabel];
        [_filmLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView).offset(22);
            make.top.equalTo(_nameLabel.mas_bottom).offset(10);
            make.height.mas_offset(20);
            make.right.equalTo(baseView.mas_centerX);
        }];
        
        //隐形车衣
        _carCoverLevelLabel = [[UILabel alloc]init];
        _carCoverLevelLabel.font = [UIFont systemFontOfSize:14];
        _carCoverLevelLabel.textAlignment = NSTextAlignmentRight;
        [baseView addSubview:_carCoverLevelLabel];
        [_carCoverLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView.mas_centerX);
            make.top.equalTo(_nameLabel.mas_bottom).offset(10);
            make.height.mas_offset(20);
            make.right.equalTo(baseView).offset(-20);
        }];
        
        //车身改色
        _colorModifyLevelLabel = [[UILabel alloc]init];
        _colorModifyLevelLabel.font = [UIFont systemFontOfSize:14];
        [baseView addSubview:_colorModifyLevelLabel];
        [_colorModifyLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView).offset(22);
            make.top.equalTo(_filmLevelLabel.mas_bottom).offset(10);
            make.height.mas_offset(20);
            make.right.equalTo(baseView.mas_centerX);
        }];
        
        //美容清洁
        _beautyLevelLabel = [[UILabel alloc]init];
        _beautyLevelLabel.font = [UIFont systemFontOfSize:14];
        _beautyLevelLabel.textAlignment = NSTextAlignmentRight;
        [baseView addSubview:_beautyLevelLabel];
        [_beautyLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView.mas_centerX);
            make.top.equalTo(_filmLevelLabel.mas_bottom).offset(10);
            make.height.mas_offset(20);
            make.right.equalTo(baseView).offset(-20);
        }];
        
    }
    return self;
}


- (void)setTeamPeopleModel:(CLTeamPeopleModel *)teamPeopleModel{
    _nameLabel.text = teamPeopleModel.name;
    _phoneLabel.text = teamPeopleModel.phone;
    _statusLabel.text = teamPeopleModel.workStatusString;
    _filmLevelLabel.text = [NSString stringWithFormat:@"隔热膜：%@星",teamPeopleModel.filmLevel];
    _carCoverLevelLabel.text = [NSString stringWithFormat:@"隐形车衣：%@星",teamPeopleModel.carCoverLevel];
    _colorModifyLevelLabel.text = [NSString stringWithFormat:@"车身改色：%@星",teamPeopleModel.colorModifyLevel];
    _beautyLevelLabel.text = [NSString stringWithFormat:@"美容清洁：%@星",teamPeopleModel.beautyLevel];
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
