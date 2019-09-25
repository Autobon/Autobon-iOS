//
//  CLLineTextFieldView.m
//  CarMapB
//
//  Created by inCar on 2018/6/14.
//  Copyright © 2018年 mll. All rights reserved.
//

#import "CLLineTextFieldView.h"
#import "Masonry.h"

@implementation CLLineTextFieldView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/





- (instancetype)initWithTitle:(NSString *)titleString width:(int )width{
    self = [super init];
    if (self){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = titleString;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.left.equalTo(self).offset(20);
            make.bottom.equalTo(self).offset(-5);
            make.width.mas_offset(width);
        }];
        
        _textField = [[UITextField alloc]init];
        _textField.font = [UIFont systemFontOfSize:15];
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.left.equalTo(_titleLabel.mas_right).offset(10);
            make.bottom.equalTo(self).offset(-5);
            make.right.equalTo(self).offset(-10);
        }];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.left.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(-1);
            make.right.equalTo(self).offset(0);
        }];
    }
    return self;
}






@end
