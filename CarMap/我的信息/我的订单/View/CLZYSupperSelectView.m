//
//  CLZYSupperSelectView.m
//  CarMapB
//
//  Created by inCar on 2018/6/14.
//  Copyright © 2018年 mll. All rights reserved.
//

#import "CLZYSupperSelectView.h"
#import "Masonry.h"


@implementation CLZYSupperSelectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithTitle:(NSString *)titleString itemArray:(NSArray *)itemArray{
    self = [super init];
    if(self){
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        UIButton *curButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        for (int i = 0; i < itemArray.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:itemArray[itemArray.count - 1 -i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor whiteColor];
            btn.tag = itemArray.count - i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            if(i == 0){
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_offset(40);
                    make.left.equalTo(self).offset(0);
                    make.bottom.equalTo(self).offset(0);
                    make.right.equalTo(self).offset(0);
                }];
            }else{
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_offset(40);
                    make.left.equalTo(self).offset(0);
                    make.bottom.equalTo(curButton.mas_top).offset(0);
                    make.right.equalTo(self).offset(0);
                }];
            }
            
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = [[UIColor alloc]initWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
            [btn addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(1);
                make.left.equalTo(self).offset(0);
                make.bottom.equalTo(btn.mas_bottom).offset(-0.5);
                make.right.equalTo(self).offset(0);
            }];
            
            
            if(i == itemArray.count - 1){
                UILabel *label = [[UILabel alloc]init];
                label.text = titleString;
                label.textAlignment = NSTextAlignmentCenter;
                label.backgroundColor = [UIColor whiteColor];
                label.font = [UIFont systemFontOfSize:16];
                label.textColor = [UIColor darkGrayColor];
                [self addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_offset(45);
                    make.left.equalTo(self).offset(0);
                    make.bottom.equalTo(btn.mas_top).offset(0);
                    make.right.equalTo(self).offset(0);
                }];
                
                UIView *lineView1 = [[UIView alloc]init];
                lineView1.backgroundColor = [[UIColor alloc]initWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
                [self addSubview:lineView1];
                [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_offset(1);
                    make.left.equalTo(self).offset(0);
                    make.bottom.equalTo(label.mas_bottom).offset(-1);
                    make.right.equalTo(self).offset(0);
                }];
            }
            
            curButton = btn;
        }
        
        
    }
    return self;
}


- (void)btnClick:(UIButton *)button{
    _nameString = button.titleLabel.text;
    [_delegate didAcceptSomething:_nameString];
    [self removeFromSuperview];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}



@end
