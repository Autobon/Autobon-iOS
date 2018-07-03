//
//  CLAUTouchView.m
//  CarMap
//
//  Created by inCar on 2018/7/2.
//  Copyright © 2018年 mll. All rights reserved.
//

#import "CLAUTouchView.h"

@implementation CLAUTouchView


- (void)setChooseViewWithTitleArray:(NSArray *)titleArray{
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    UIView *buttonView = [[UIView alloc]init];
    _buttonArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < titleArray.count; i++) {
        NSInteger X = i%2 * [UIScreen mainScreen].bounds.size.width/2 + 15;
        NSInteger Y = i/2 * 40 + 15;
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(X, Y, [UIScreen mainScreen].bounds.size.width/2 - 20, 40);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.contentVerticalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:236/255.0 green:136/255.0 blue:12/255.0 alpha:1.0] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.tag = i + 1;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:button];
        [_buttonArray addObject:button];
        
    }
    
    [self addSubview:buttonView];
    buttonView.backgroundColor = [UIColor whiteColor];
    [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.width.equalTo(self);
        float buttonRow = ceilf(titleArray.count/2);
        float rowHeight = 40 * buttonRow + 15;
        make.height.mas_equalTo(rowHeight);
    }];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.backgroundColor = [UIColor whiteColor];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelButton.layer.borderWidth = 1.0;
    cancelButton.layer.borderColor = [UIColor colorWithRed:230/255.0 green:233/255.0 blue:241/255.0 alpha:1.0].CGColor;
    [cancelButton addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonView.mas_bottom);
        make.left.equalTo(self);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width/2);
        make.height.mas_equalTo(40);
    }];
    
    _trueButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _trueButton.backgroundColor = [UIColor colorWithRed:39/255.0 green:67/255.0 blue:57/255.0 alpha:1.0];
    [_trueButton setTitle:@"确定" forState:UIControlStateNormal];
    [_trueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_trueButton];
    [_trueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonView.mas_bottom);
        make.right.equalTo(self);
        make.width.mas_offset([UIScreen mainScreen].bounds.size.width/2);
        make.height.mas_offset(40);
    }];
    
    
}

- (void)btnClick:(UIButton *)button{
    for (int i = 0; i < _buttonArray.count; i++) {
        UIButton *btn = _buttonArray[i];
        btn.selected = NO;
    }
    button.selected = YES;
    ICLog(@"button.tag-----%ld--",button.tag);
    _trueButton.tag = button.tag;
}

- (void)cancelBtnClick{
    [self removeFromSuperview];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
