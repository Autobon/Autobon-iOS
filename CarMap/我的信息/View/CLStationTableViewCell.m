//
//  CLStationTableViewCell.m
//  CarMap
//
//  Created by inCarL on 2019/12/16.
//  Copyright © 2019 mll. All rights reserved.
//

#import "CLStationTableViewCell.h"

@implementation CLStationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
        
        UIView *baseView = [[UIView alloc]init];
        baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:baseView];
        [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(5);
            make.bottom.equalTo(self).offset(-5);
        }];
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"商户名称：";
        [baseView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView).offset(15);
            make.right.equalTo(baseView).offset(-15);
            make.top.equalTo(baseView).offset(5);
            make.height.mas_offset(40);
        }];
        
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.text = @"商户位置：";
        [baseView addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView).offset(15);
            make.right.equalTo(baseView).offset(-15);
            make.top.equalTo(_nameLabel.mas_bottom).offset(5);
            make.height.mas_offset(40);
        }];
        
        
        
    }
    return self;
}



@end
