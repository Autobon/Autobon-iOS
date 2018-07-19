//
//  GFProjectView.m
//  施工项目按钮
//
//  Created by 陈光法 on 16/11/1.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFProjectView.h"

@interface GFProjectView()


@property (nonatomic, strong) NSMutableArray *selArr;

@property (nonatomic, strong) NSMutableArray *butArr;

@property (nonatomic, strong) UILabel *nameLab;

@end


@implementation GFProjectView

- (void)setName:(NSString *)name {
    
    _name = name;
    
    _nameLab.text = name;
}


- (void)setPrArr:(NSArray *)prArr {
    
    _prArr = prArr;
    
    CGFloat vvH = 30;
    UILabel *vv = [[UILabel alloc] init];
    vv.font = [UIFont systemFontOfSize:15];
    vv.backgroundColor = [UIColor whiteColor];
    vv.textColor = [UIColor darkGrayColor];
    vv.frame = CGRectMake(15, 0, [UIScreen mainScreen].bounds.size.width - 15, vvH);
    [self addSubview:vv];
    _nameLab = vv;
    
    
    int rowButtonNumber = 4;
    if([_proName isEqualToString:@"美容清洁"]){
        rowButtonNumber = 2;
    }
    
    
    CGFloat w = ([UIScreen mainScreen].bounds.size.width - 10 * (rowButtonNumber + 1)) / rowButtonNumber;
    CGFloat h = 30;
    CGFloat y = 10;
    
    NSInteger allNum = prArr.count;
    
    _butArr = [[NSMutableArray alloc] init];
    
    _disableArr = [[NSMutableArray alloc] init];
    
    for(int i=0; i<prArr.count; i++) {
        
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.tag = i + 1;
        but.titleLabel.font = [UIFont systemFontOfSize:10];
        [but setTitle:prArr[i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [but setBackgroundImage:[UIImage imageNamed:@"but_normal"] forState:UIControlStateNormal];
        [but setBackgroundImage:[UIImage imageNamed:@"but_selected"] forState:UIControlStateSelected];
        [but setBackgroundImage:[UIImage imageNamed:@"but_disable"] forState:UIControlStateDisabled];
        but.frame = CGRectMake((10 + w) * (i % rowButtonNumber) + 10, y + (i / rowButtonNumber) * (h + y) + vvH, w, h);
        [self addSubview:but];
        [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_butArr addObject:but];
        [_disableArr addObject:@"YES"];
    }
    
    if(allNum % rowButtonNumber == 0) {
    
        _vvHeight = y + (prArr.count / rowButtonNumber) * (h + y) + vvH;
    }else {
    
        _vvHeight = y + (prArr.count / rowButtonNumber + 1) * (h + y) + vvH;
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _vvHeight, [UIScreen mainScreen].bounds.size.width, 1)];
    lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [self addSubview:lineView];
    
    _vvHeight = _vvHeight + 2;
}

- (NSMutableArray *)selArr {
    
    if(_selArr == nil) {
        
        _selArr = [[NSMutableArray alloc] init];
        for(int i=0; i<_prArr.count; i++) {
        
            [_selArr addObject:@"name"];
        }
    }
    
    return _selArr;
}

- (NSMutableArray *)idArr {
    
    _idArr = [[NSMutableArray alloc] init];

    for(NSString *idStr in self.selArr) {
    
//        NSLog(@"====%@", self.selArr);
        NSString *str = [NSString stringWithFormat:@"%@", idStr];
        if(![str isEqualToString:@"name"]) {
            
            [_idArr addObject:str];
        }
    }

//    NSLog(@"--ididididdidid---%@", _idArr);
    
    return _idArr;
}


- (void)setDisableArr:(NSMutableArray *)disableArr {
    
    _disableArr = disableArr;
    
    for(int i=0; i<disableArr.count; i++) {
    
        UIButton *but = (UIButton *)self.butArr[i];
        BOOL bb = [disableArr[i] boolValue];
        if(but.selected != YES) {
        
            but.enabled = bb;
        }
    }
    
}



- (void)butClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
//    NSLog(@"=====%@", self.selArr);
    if(sender.selected) {
    
//        self.selArr[sender.tag - 1] = self.prArr[sender.tag - 1];
        self.selArr[sender.tag - 1] = self.buweiIdArr[sender.tag - 1];
        self.disableArr[sender.tag - 1] = @"NO";
    }else {
        
        self.selArr[sender.tag - 1] = @"name";
        self.disableArr[sender.tag - 1] = @"YES";
    }
    
    [_delegate GFProjectView:self];
    
//    NSLog(@"=======---%@", self.selArr);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
