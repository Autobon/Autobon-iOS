//
//  GFFangqiViewController.m
//  CarMap
//
//  Created by 陈光法 on 16/12/6.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFFangqiViewController.h"
#import "GFNavigationView.h"
#import "CLHomeOrderViewController.h"
#import "GFHttpTool.h"
#import "GFTipView.h"
#import "CLHomeOrderCellModel.h"

@interface GFFangqiViewController () <UITextViewDelegate>

@property (nonatomic, copy) NSString *liyouStr;

@property (nonatomic, strong) UIButton *selectBut;

@property (nonatomic, strong) UITextView *txtview;

@property (nonatomic, copy) NSString *reasonStr;

@property (nonatomic, strong) GFNavigationView *navView;

@end

@implementation GFFangqiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigation];
    
    _liyouStr = @"";
    
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [but1 setTitle:@"抢错单了。" forState:UIControlStateNormal];
    [but1 setImage:[UIImage imageNamed:@"over"] forState:UIControlStateNormal];
    [but1 setImage:[UIImage imageNamed:@"overClick"] forState:UIControlStateSelected];
    [but1 addTarget:self action:@selector(liyouButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but1];
    [but1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navView.mas_bottom).offset(10);
        make.height.mas_offset(45);
    }];
    but1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [but1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    but1.layer.borderWidth = 1;
    but1.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    but1.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    but1.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    but1.tag = 1;
    
    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [but2 setTitle:@"临时有事。" forState:UIControlStateNormal];
    [but2 setImage:[UIImage imageNamed:@"over"] forState:UIControlStateNormal];
    [but2 setImage:[UIImage imageNamed:@"overClick"] forState:UIControlStateSelected];
    [but2 addTarget:self action:@selector(liyouButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but2];
    [but2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(but1.mas_bottom).offset(10);
        make.height.mas_offset(45);
    }];
    but2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [but2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    but2.layer.borderWidth = 1;
    but2.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    but2.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    but2.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    but2.tag = 2;
    
    UIButton *but3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [but3 setTitle:@"其他" forState:UIControlStateNormal];
    [but3 setImage:[UIImage imageNamed:@"over"] forState:UIControlStateNormal];
    [but3 setImage:[UIImage imageNamed:@"overClick"] forState:UIControlStateSelected];
    [but3 addTarget:self action:@selector(liyouButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but3];
    [but3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(but2.mas_bottom).offset(10);
        make.height.mas_offset(45);
    }];
    but3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [but3 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    but3.layer.borderWidth = 1;
    but3.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    but3.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    but3.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    but3.tag = 3;
    
    self.txtview = [[UITextView alloc] init];
    self.txtview.font = [UIFont systemFontOfSize:15];
    self.txtview.textColor = [UIColor darkGrayColor];
    self.txtview.layer.borderWidth = 1;
    self.txtview.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.txtview.hidden = YES;
    self.txtview.text = @"请输入其他理由";
    self.txtview.delegate = self;
    [self.view addSubview:self.txtview];
    [self.txtview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(but3.mas_bottom).offset(10);
        make.height.mas_offset(60);
    }];
    
    
    UIButton *workButton = [[UIButton alloc]init];
    [workButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    workButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    [self.view addSubview:workButton];
    [workButton addTarget:self action:@selector(butClick) forControlEvents:UIControlEventTouchUpInside];
    [workButton setTitle:@"提交" forState:UIControlStateNormal];
    workButton.layer.cornerRadius = 7.5;
    [workButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(but3.mas_bottom).offset(100);
        make.height.mas_offset(60);
    }];
}
- (void)textViewDidBeginEditing:(UITextView *)textView {

    self.txtview.text = @"";
}
- (void)textViewDidEndEditing:(UITextView *)textView {

    if([textView.text isEqualToString:@""]) {
    
        self.txtview.text = @"请输入其他原因";
    }
    
    
    if (textView.text.length > 50){
    
        UIAlertView *tt = [[UIAlertView alloc] initWithTitle:@"注意" message:@"少说点，不能超过50个字！！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [tt show];
        
        self.txtview.text = @"";
    }
    
    _liyouStr = textView.text;
    
}

- (void)liyouButClick:(UIButton *)sender {
    
    
    if(sender.tag != self.selectBut.tag) {
    
        sender.selected = YES;
        self.selectBut.selected = NO;
        
        self.selectBut = sender;
        self.selectBut.selected = sender.selected;
        
        _liyouStr = sender.titleLabel.text;
//        NSLog(@"-----%@====%@", _liyouStr, sender);
        
        if(sender.tag == 3) {
            
            self.txtview.hidden = NO;
            [self.txtview becomeFirstResponder];
        }else {
            
            self.txtview.hidden = YES;
        }
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)butClick {
    
    [self.view endEditing:YES];
    
    if([_liyouStr isEqualToString:@"请输入其他原因"]) {
    
        UIAlertView *tt = [[UIAlertView alloc] initWithTitle:@"注意" message:@"请填写理由！！！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [tt show];
    }else if([_liyouStr isEqualToString:@""]) {
    
        UIAlertView *tt = [[UIAlertView alloc] initWithTitle:@"注意" message:@"请选择理由！！！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [tt show];
    }else {
    
        NSString *str = [NSString stringWithFormat:@"%@,?reason=%@", _model.orderId, _liyouStr];
        
//        NSLog(@"=====%@", str);
        
        [GFHttpTool postCancelOrder:str Success:^(id responseObject) {
            
//            NSLog(@"--放弃订单--%@", responseObject);
            if ([responseObject[@"status"] integerValue] == 1) {
                
                [GFTipView tipViewWithNormalHeightWithMessage:responseObject[@"message"] withShowTimw:1.5];
                [self performSelector:@selector(removeOrderSuccess) withObject:nil afterDelay:1.5];
            }else{
                
                [GFTipView tipViewWithNormalHeightWithMessage:responseObject[@"message"] withShowTimw:1.5];
                
            }
            
        } failure:^(NSError *error) {
            
            //       NSLog(@"放弃订单失败----%@---",error);
            
        }];
        
        
    }
    
}

- (void)removeOrderSuccess{
    CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
    [homeOrder headRefresh];
    [self.navigationController popToRootViewControllerAnimated:YES];
}







// 添加导航
- (void)setNavigation{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [_navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
}



- (void)backBtnClick{
//    if (_isAdd) {
//        CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
//        [homeOrder headRefresh];
//    }
    [self.navigationController popViewControllerAnimated:YES];
    
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
