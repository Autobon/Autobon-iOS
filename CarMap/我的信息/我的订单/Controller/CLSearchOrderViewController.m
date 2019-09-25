//
//  CLSearchOrderViewController.m
//  CarMapB
//
//  Created by inCar on 2018/6/14.
//  Copyright © 2018年 mll. All rights reserved.
//

#import "CLSearchOrderViewController.h"
#import "GFNavigationView.h"
#import "CLLineTextFieldView.h"
#import "CLZYSupperSelectView.h"
#import "CLChooseView.h"
#import "Commom.h"


@interface CLSearchOrderViewController ()<UITextFieldDelegate,CLZYSuperSelectViewDelegate>
{
    CGFloat kWidth;
    CGFloat kHeight;
    
    CLChooseView *_dateChooseView;
    
    
    CLLineTextFieldView *_statusTextFieldView;
    CLLineTextFieldView *_timeTextFieldView;
    CLLineTextFieldView *_carJiaHaoTextFieldView;
    CLLineTextFieldView *_phoneTextFieldView;
    CLLineTextFieldView *_carNumberTextFieldView;
    
    
    
}


@property (nonatomic, strong) GFNavigationView *navView;

@end

@implementation CLSearchOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [self _setBase];
    
    [self setViewUI];
    
}


- (void)setViewUI{
    /*
    _statusTextFieldView = [[CLLineTextFieldView alloc]initWithTitle:@"状态" width:100];
    _statusTextFieldView.backgroundColor = [UIColor clearColor];
    _statusTextFieldView.titleLabel.textColor = [UIColor blackColor];
    _statusTextFieldView.textField.delegate = self;
    _statusTextFieldView.textField.tag = 1;
    [self.view addSubview:_statusTextFieldView];
    [_statusTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).offset(7);
        make.left.equalTo(self.view).offset(0);
        make.height.mas_offset(45);
        make.right.equalTo(self.view).offset(0);
    }];

    _timeTextFieldView = [[CLLineTextFieldView alloc]initWithTitle:@"预约施工时间" width:100];
    _timeTextFieldView.backgroundColor = [UIColor clearColor];
    _timeTextFieldView.titleLabel.textColor = [UIColor blackColor];
    _timeTextFieldView.textField.delegate = self;
    _timeTextFieldView.textField.tag = 2;
    [self.view addSubview:_timeTextFieldView];
    [_timeTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_statusTextFieldView.mas_bottom).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.height.mas_offset(45);
        make.right.equalTo(self.view).offset(0);
    }];
*/
    _carNumberTextFieldView = [[CLLineTextFieldView alloc]initWithTitle:@"车牌号" width:100];
    _carNumberTextFieldView.backgroundColor = [UIColor clearColor];
    _carNumberTextFieldView.titleLabel.textColor = [UIColor blackColor];
    _carNumberTextFieldView.textField.delegate = self;
    _carNumberTextFieldView.textField.tag = 3;
    [self.view addSubview:_carNumberTextFieldView];
    [_carNumberTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).offset(7);
        make.left.equalTo(self.view).offset(0);
        make.height.mas_offset(45);
        make.right.equalTo(self.view).offset(0);
    }];
    
    
    
    
    _carJiaHaoTextFieldView = [[CLLineTextFieldView alloc]initWithTitle:@"车架号" width:100];
    _carJiaHaoTextFieldView.backgroundColor = [UIColor clearColor];
    _carJiaHaoTextFieldView.titleLabel.textColor = [UIColor blackColor];
    _carJiaHaoTextFieldView.textField.keyboardType = UIKeyboardTypeNumberPad;
    _carJiaHaoTextFieldView.textField.delegate = self;
    _carJiaHaoTextFieldView.textField.tag = 4;
    [self.view addSubview:_carJiaHaoTextFieldView];
    [_carJiaHaoTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_carNumberTextFieldView.mas_bottom).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.height.mas_offset(45);
        make.right.equalTo(self.view).offset(0);
    }];
    /*
    _phoneTextFieldView = [[CLLineTextFieldView alloc]initWithTitle:@"下单人手机号" width:100];
    _phoneTextFieldView.backgroundColor = [UIColor clearColor];
    _phoneTextFieldView.titleLabel.textColor = [UIColor blackColor];
    _phoneTextFieldView.textField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextFieldView.textField.delegate = self;
    _phoneTextFieldView.textField.tag = 5;
    [self.view addSubview:_phoneTextFieldView];
    [_phoneTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.navView.mas_bottom).offset(7);
        make.top.equalTo(_carJiaHaoTextFieldView.mas_bottom).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.height.mas_offset(45);
        make.right.equalTo(self.view).offset(0);
    }];
    */
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    searchButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    searchButton.layer.cornerRadius = 5;
    [searchButton setTitle:@"查询" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:searchButton];
    [searchButton addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(_carJiaHaoTextFieldView.mas_bottom).offset(30);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_offset(40);
    }];
    
    
}


- (void)searchBtnClick{
    
    ICLog(@"search button click");
    NSMutableDictionary *_dataDictionary = [[NSMutableDictionary alloc]init];
    
    if ([_statusTextFieldView.textField.text isEqualToString:@"未接单"]) {
        _dataDictionary[@"status"] = @"1";
    }else if([_statusTextFieldView.textField.text isEqualToString:@"施工中"]){
        _dataDictionary[@"status"] = @"2";
    }else if([_statusTextFieldView.textField.text isEqualToString:@"待评价"]){
        _dataDictionary[@"status"] = @"3";
    }else if([_statusTextFieldView.textField.text isEqualToString:@"已评价"]){
        _dataDictionary[@"status"] = @"4";
    }
    
    if(_timeTextFieldView.textField.text.length > 0){
        _dataDictionary[@"workDate"] = _timeTextFieldView.textField.text;
    }
    
    if(_carNumberTextFieldView.textField.text.length > 0){
        _dataDictionary[@"license"] = _carNumberTextFieldView.textField.text;
    }
    
    if(_carJiaHaoTextFieldView.textField.text.length > 0){
        _dataDictionary[@"vin"] = _carJiaHaoTextFieldView.textField.text;
    }
    
    if(_phoneTextFieldView.textField.text.length > 0){
        _dataDictionary[@"phone"] = _phoneTextFieldView.textField.text;
    }
    
    
    
    
    
    [_delegate searchOrderForDictionary:_dataDictionary];
    [self.navigationController popViewControllerAnimated:YES];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    ICLog(@"----textField----%ld--",(long)textField.tag);
    if(textField.tag == 1){
        NSArray *titleArray = @[@"未接单",@"施工中",@"待评价",@"已评价"];
        [self setSelectViewWithTitle:@"选择运单状态" titleArray:titleArray];
        
        
        return NO;
    }else if(textField.tag == 2){
        [self chooseDate];
        
        return NO;
    }
    return YES;
}



- (void)setSelectViewWithTitle:(NSString *)titleString titleArray:(NSArray *)titleArray{
    
    CLZYSupperSelectView *chooseItemView = [[CLZYSupperSelectView alloc] initWithTitle:titleString itemArray:titleArray];
    chooseItemView.delegate = self;
    [self.view addSubview:chooseItemView];
    [chooseItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
    
}


- (void)didAcceptSomething:(NSString *)someoneName{
//    ICLog(@"----someoneName---%@--",someoneName);
    
    _statusTextFieldView.textField.text = someoneName;
    
}


- (void)chooseDate{
    
    _dateChooseView = [[CLChooseView alloc]init];
    [_dateChooseView setDateView];
    [self.view addSubview:_dateChooseView];
    _dateChooseView.frame = self.view.frame;
    [_dateChooseView.trueButton addTarget:self action:@selector(dateTrueBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)dateTrueBtnClick{
//    ICLog(@"--_dateChooseView.datePickerView.date--%@--",_dateChooseView.datePickerView.date);
//    _timeTextFieldView.textField.text = [Commom dateToStringWithDate:_dateChooseView.datePickerView.date];
//    [_dateChooseView removeFromSuperview];
//    _dateChooseView = nil;
    
    
}



- (void)_setBase {
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"订单查询" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}



- (void)leftButClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
