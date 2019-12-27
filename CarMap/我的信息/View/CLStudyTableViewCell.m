//
//  CLStudyTableViewCell.m
//  CarMap
//
//  Created by inCar on 2018/6/19.
//  Copyright © 2018年 mll. All rights reserved.
//

#import "CLStudyTableViewCell.h"
#import "Masonry.h"


@implementation CLStudyTableViewCell






- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *baseView = [[UIView alloc]init];
        baseView.backgroundColor = [UIColor whiteColor];
        baseView.layer.borderWidth = 0.5;
        baseView.layer.borderColor = [UIColor blackColor].CGColor;
        [self addSubview:baseView];
        [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(5);
            make.top.equalTo(self).offset(3);
            make.right.equalTo(self).offset(-5);
            make.bottom.equalTo(self).offset(-3);
        }];
        
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"贴膜前检查事项";
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [baseView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(baseView).offset(8);
            make.left.equalTo(baseView).offset(15);
            make.height.mas_equalTo(20);
            make.right.equalTo(baseView).offset(-15);
        }];
        
        _typeLabel = [[UILabel alloc]init];
        _typeLabel.text = @"培训资料";
        _typeLabel.font = [UIFont systemFontOfSize:14];
        [baseView addSubview:_typeLabel];
        [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(5);
            make.left.equalTo(baseView).offset(15);
            make.height.mas_equalTo(20);
            make.right.equalTo(baseView).offset(-15);
        }];
        
        _remarkLabel = [[UILabel alloc]init];
        _remarkLabel.text = @"备注：";
        _remarkLabel.font = [UIFont systemFontOfSize:14];
        [baseView addSubview:_remarkLabel];
        [_remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_typeLabel.mas_bottom).offset(8);
            make.left.equalTo(baseView).offset(15);
            make.width.mas_offset(50);
            
        }];
        
        _remarkDetailLabel = [[UILabel alloc]init];
        _remarkDetailLabel.text = @" ";
        _remarkDetailLabel.font = [UIFont systemFontOfSize:14];
        _remarkDetailLabel.numberOfLines = 0;
        [baseView addSubview:_remarkDetailLabel];
        [_remarkDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_typeLabel.mas_bottom).offset(8);
            make.left.equalTo(baseView).offset(58);
            make.right.equalTo(baseView).offset(-15);
        }];
        
    }
    
    return self;
}



- (void)setDataForStudyModel:(CLStudyModel *)studyModel{
    _titleLabel.text = [NSString stringWithFormat:@"名称：%@", studyModel.fileName];
    _typeLabel.text = [NSString stringWithFormat:@"类型：%@", studyModel.typeString];
    _remarkDetailLabel.text = studyModel.remark;
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
