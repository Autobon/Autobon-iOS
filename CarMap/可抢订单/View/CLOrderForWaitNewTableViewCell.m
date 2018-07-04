//
//  CLOrderForWaitNewTableViewCell.m
//  CarMap
//
//  Created by inCar on 2018/7/3.
//  Copyright © 2018年 mll. All rights reserved.
//

#import "CLOrderForWaitNewTableViewCell.h"
#import "GFHttpTool.h"
#import "CLAddOrderSuccessViewController.h"
#import "GFTipView.h"
#import "GFMapViewController.h"
#import "AppDelegate.h"

@implementation CLOrderForWaitNewTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        
        UIView *baseView = [[UIView alloc]init];
        baseView.backgroundColor = [UIColor whiteColor];
//        baseView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
//        baseView.backgroundColor = [UIColor redColor];
        [self addSubview:baseView];
        
        
        _detailLabel = [[UILabel alloc]init];
//        _detailLabel.text = @"施工项目：隐形车衣 施工项目：隐形车衣 施工项目：隐形车衣 施工项目：隐形车衣 施工项目：隐形车衣 施工项目：隐形车衣 施工项目：隐形车衣 施工项目：隐形车衣 施工项目：隐形车衣 施工项目：隐形车衣 施工项目：隐形车衣 施工项目：隐形车衣 ";
        _detailLabel.numberOfLines = 0;
        _detailLabel.font = [UIFont systemFontOfSize:14];
        [baseView addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView).offset(10);
            make.top.equalTo(baseView).offset(10);
            make.right.equalTo(baseView).offset(-90);
        }];
        
        [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.top.equalTo(self).offset(5);
            make.right.equalTo(self).offset(0);
            make.bottom.equalTo(_detailLabel).offset(10);
        }];
        
        // 进入订单按钮
        _orderButton = [UIButton buttonWithType:UIButtonTypeSystem];
//        _orderButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 80, 15, 70, 28);
        [_orderButton setTitle:@"抢单" forState:UIControlStateNormal];
        _orderButton.layer.borderColor = [[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] CGColor];
        _orderButton.layer.borderWidth = 1.0f;
        _orderButton.layer.cornerRadius = 5;
        [_orderButton setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
        [baseView addSubview:_orderButton];
        [_orderButton addTarget:self action:@selector(qiangdanButClick:) forControlEvents:UIControlEventTouchUpInside];
        [_orderButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(baseView);
            make.right.equalTo(baseView).offset(-10);
            make.width.mas_offset(70);
            make.height.mas_offset(28);
        }];
        
    }
    return self;
}

- (void)setModel:(CLHomeOrderCellModel *)model {
    
    _model = model;
    
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    float myLocationLat = [appDelegate.locationDictionary[@"lat"] floatValue];
    float myLocationLng = [appDelegate.locationDictionary[@"lng"] floatValue];
    float coorLocationLat = [model.customerLat floatValue];
    float coorLocationLng = [model.customerLon floatValue];
    
    
    
    CLLocationCoordinate2D myLocation = CLLocationCoordinate2DMake(myLocationLat, myLocationLng);
    CLLocationCoordinate2D coorLocation = CLLocationCoordinate2DMake(coorLocationLat, coorLocationLng);
    
    double distance = [GFMapViewController calculatorWithCoordinate1:myLocation withCoordinate2:coorLocation];
    
    
    
    
    _detailLabel.text = [NSString stringWithFormat:@"施工项目：%@，商户名称：%@，地址：%@，距离%0.1f公里，预约施工时间：%@，最迟交车时间：%@。",model.orderType,model.cooperatorFullname,model.address,distance/1000.0,model.orderTime,model.agreedEndTime];
    
    if (myLocationLat == 0 || myLocationLng == 0 || coorLocationLat == 0 || coorLocationLng == 0){
        distance = 0;
        _detailLabel.text = [NSString stringWithFormat:@"施工项目：%@，商户名称：%@，地址：%@，距离%@，预约施工时间：%@，最迟交车时间：%@。",model.orderType,model.cooperatorFullname,model.address,@"--",model.orderTime,model.agreedEndTime];
    }
    
    CGRect Rect =[_detailLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    model.cellHeight = 20 + Rect.size.height;
    
    
}


- (void)qiangdanButClick:(UIButton *)sender {
    
    [GFHttpTool postOrderId:[_model.orderId integerValue] Success:^(NSDictionary *responseObject) {
        
        //        NSLog(@"----抢单结果--%@--",responseObject);
        if ([responseObject[@"status"]integerValue] == 1) {
            
            CLAddOrderSuccessViewController *addSuccess = [[CLAddOrderSuccessViewController alloc]init];
            addSuccess.model = _model;
            
            [[self viewController].navigationController pushViewController:addSuccess animated:NO];
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        //        NSLog(@"----抢单结果-222-%@--",error);
        //        [self addAlertView:@"请求失败"];
    }];
}

//获取view的controller
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
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
