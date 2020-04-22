//
//  GFFCertifyViewController.m
//  CarMap
//
//  Created by 陈光法 on 16/11/29.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFFCertifyViewController.h"
#import "GFNavigationView.h"
#import "UIButton+WebCache.h"
#import "CLTitleView.h"

#import "GFPingfenView.h"
#import "GFButtonRight.h"

#import "CLTouchScrollView.h"
#import "CLDelegateViewController.h"

#import "CLTouchView.h"
#import "GFHttpTool.h"
#import "GFTipView.h"

#import "CLAutobonViewController.h"

#import "CLCertifyingViewController.h"
#import "GFSignInViewController.h"
#import "GFCertifyModel.h"
#import "GFButtonRight.h"

@interface GFFCertifyViewController ()<UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

{
    GFNavigationView *_navView;
}

@property (nonatomic, strong) CLTouchScrollView *scView;
@property (nonatomic, strong) UIButton *iconBut;    // 技师头像
@property (nonatomic, strong) UITextField *nameTxt;
@property (nonatomic, strong) UITextField *idCardTxt;
@property (nonatomic, strong) UITextField *tuijianrenTxt;

@property (nonatomic, strong) GFPingfenView *gereView;
@property (nonatomic, strong) GFButtonRight *gerebut;
@property (nonatomic, strong) GFPingfenView *yinxingView;
@property (nonatomic, strong) GFButtonRight *yinxingBut;
@property (nonatomic, strong) GFPingfenView *gaiseView;
@property (nonatomic, strong) GFButtonRight *gaiseBut;
@property (nonatomic, strong) GFPingfenView *meirongView;
@property (nonatomic, strong) GFButtonRight *meirongBut;
@property (nonatomic, strong) GFPingfenView *anQuanView;
@property (nonatomic, strong) GFButtonRight *anQuanBut;
@property (nonatomic, strong) GFPingfenView *qiTaView;
@property (nonatomic, strong) GFButtonRight *qiTaBut;


@property (nonatomic, strong) UITextView *txtView;

@property (nonatomic, strong) UIButton *idCardImgViewBut;
@property (nonatomic, strong) UIButton *cameraBut;

@property (nonatomic, strong) UITextField *yinhangMingTxt;
@property (nonatomic, strong) UITextField *kahaoTxt;
@property (nonatomic, strong) UITextField *dizhiTxt;

@property (nonatomic, strong) UIPickerView *timePickerView;
@property (nonatomic, strong) UIView *bbView;
@property (nonatomic, assign) NSInteger butTag;
@property (nonatomic, strong) GFButtonRight *selectBut;

@property (nonatomic, strong) CLTouchView *chooseView;

@property (nonatomic, assign) BOOL isHeadImage;
@property (nonatomic, assign) BOOL haveHeadImage;
@property (nonatomic, assign) BOOL haveIdentityImage;

@property (nonatomic, strong) NSMutableDictionary *dataDictionary;

@property (nonatomic, strong) UIView *ttView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *bankArray;

@property (nonatomic, copy) NSString *idPhoto;

@property (nonatomic, strong) UIButton *shuomingView;



@end

@implementation GFFCertifyViewController

- (UIButton *)shuomingView {
    
    if(_shuomingView == nil) {
        
        UIButton *vv = [[UIButton alloc] init];
        vv.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        vv.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self.view addSubview:vv];
        [vv addTarget:self action:@selector(vvbutClick:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *str = @"一星代表“初学”， 二星代表“生疏”， 三星代表“熟练”， 四星代表“优秀”， 五星代表“大神”。";
        CGRect strRect = [str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
        
        UILabel *lab = [[UILabel alloc] init];
        lab.frame = CGRectMake(20, 220, [UIScreen mainScreen].bounds.size.width - 40 , strRect.size.height + 10 + 30);
        lab.backgroundColor = [UIColor whiteColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = str;
        lab.font = [UIFont systemFontOfSize:16];
        lab.textColor = [UIColor darkGrayColor];
        [vv addSubview:lab];
        lab.numberOfLines = 0;
        lab.layer.cornerRadius = 5;
        lab.clipsToBounds = YES;
        
        
        
        _shuomingView = vv;
    }
    
    return _shuomingView;
}

- (void)vvbutClick:(UIButton *)sender {
    
    self.shuomingView.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.idPhoto = @"";
    
    [self setNavigation];
    
    [self _setView];
    _bankArray = @[@"农业银行",@"招商银行",@"建设银行",@"广发银行",@"中信银行",@"光大银行",@"民生银行",@"浦发银行",@"工商银行",@"中国银行",@"交通银行",@"邮政储蓄银行"];
    
    
    _ttView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _scView.contentSize.width, _scView.contentSize.height)];
    _ttView.hidden = YES;
//    _ttView.backgroundColor= [UIColor greenColor];
    [_scView addSubview:_ttView];
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture2:)];
    tapGesture2.numberOfTapsRequired = 1; //点击次数
    tapGesture2.numberOfTouchesRequired = 1; //点击手指数
    [_ttView addGestureRecognizer:tapGesture2];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(self.yinhangMingTxt.superview.frame), 160, 200)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_scView addSubview:_tableView];
    _tableView.backgroundColor = [UIColor lightGrayColor];
    _tableView.hidden = YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.bankArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.bankArray[indexPath.row];
    cell.backgroundColor = [UIColor lightGrayColor];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.yinhangMingTxt.text = self.bankArray[indexPath.row];
    
    
    _tableView.hidden = YES;
    _ttView.hidden = YES;
}

- (void)_setView {
    
    _dataDictionary = [[NSMutableDictionary alloc] init];
    
    _scView = [[CLTouchScrollView alloc] init];
    [self.view addSubview:_scView];
    
    [_scView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(_navView.mas_bottom);
    }];
    
    
    // 技师头像
    _iconBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _iconBut.frame = CGRectMake(10, 10, 90, 90);
    _iconBut.layer.cornerRadius = 45;
    _iconBut.tag = 1;
    _iconBut.clipsToBounds = YES;
    [_iconBut setBackgroundImage:[UIImage imageNamed:@"userHeadImage"] forState:UIControlStateNormal];
    [_scView addSubview:_iconBut];
    UIButton *ccBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [ccBut setBackgroundImage:[UIImage imageNamed:@"cameraHead"] forState:UIControlStateNormal];
    ccBut.frame = CGRectMake(CGRectGetMaxX(_iconBut.frame) - 24, CGRectGetMaxY(_iconBut.frame) - 24, 25, 25);
    ccBut.tag = 1;
    [_scView addSubview:ccBut];
    [_iconBut addTarget:self action:@selector(ccClick:) forControlEvents:UIControlEventTouchUpInside];
    [ccBut addTarget:self action:@selector(ccClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 姓名
    _nameTxt = [self setTextFieldWithTitle:@"姓名" withX:110 withY:10];
    // 身份证
    _idCardTxt = [self setTextFieldWithTitle:@"身份证号" withX:110 withY:40];
    // 推荐人
    _tuijianrenTxt = [self setTextFieldWithTitle:@"推荐人" withX:110 withY:70];
    _tuijianrenTxt.keyboardType = UIKeyboardTypePhonePad;

    
    // 技能项目
    CLTitleView *skillView = [[CLTitleView alloc]initWithFrame:CGRectMake(0, 110, self.view.frame.size.width, 45) Title:@"技能项目"];
    [_scView addSubview:skillView];
    
    // 查看技能等级说明
    GFButtonRight *shuomingBut = [GFButtonRight buttonWithType:UIButtonTypeCustom];
    shuomingBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 260, 0, 250, 45);
    [shuomingBut setTitle:@"查看技能等级规则" forState:UIControlStateNormal];
    [shuomingBut setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    shuomingBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [shuomingBut setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    shuomingBut.titleLabel.font = [UIFont systemFontOfSize:15];
    [skillView addSubview:shuomingBut];
    [shuomingBut addTarget:self action:@selector(shuomingButClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 隔热膜技能
    self.gerebut = [GFButtonRight buttonWithType:UIButtonTypeCustom];
    self.gerebut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 10 - 65, 0, 65, 25);
    _gereView = [self setJinengpingdingWithX:0 withY:CGRectGetMaxY(skillView.frame) + 15 withBut:self.gerebut withTitle:@"隔热膜"];
    self.gerebut.tag = 1;
    // 隐形车衣
    self.yinxingBut = [GFButtonRight buttonWithType:UIButtonTypeCustom];
    self.yinxingBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 10 - 65, 0, 65, 25);
    _yinxingView = [self setJinengpingdingWithX:0 withY:CGRectGetMaxY(skillView.frame) + 15 + 35 withBut:self.yinxingBut withTitle:@"隐形车衣"];
    self.yinxingBut.tag = 2;
    // 车身改色
    self.gaiseBut = [GFButtonRight buttonWithType:UIButtonTypeCustom];
    self.gaiseBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 10 - 65, 0, 65, 25);
    _gaiseView = [self setJinengpingdingWithX:0 withY:CGRectGetMaxY(skillView.frame) + 15 + 35 * 2 withBut:self.gaiseBut withTitle:@"车身改色"];
    self.gaiseBut.tag = 3;
    // 美容清洁
    self.meirongBut = [GFButtonRight buttonWithType:UIButtonTypeCustom];
    self.meirongBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 10 - 65, 0, 65, 25);
    _meirongView = [self setJinengpingdingWithX:0 withY:CGRectGetMaxY(skillView.frame) + 15 + 35 * 3 withBut:self.meirongBut withTitle:@"美容清洁"];
    self.meirongBut.tag = 4;
    
    // 安全膜
    self.anQuanBut = [GFButtonRight buttonWithType:UIButtonTypeCustom];
    self.anQuanBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 10 - 65, 0, 65, 25);
    _anQuanView = [self setJinengpingdingWithX:0 withY:CGRectGetMaxY(skillView.frame) + 15 + 35 * 4 withBut:self.anQuanBut withTitle:@"安全膜"];
    self.anQuanBut.tag = 5;
    // 其他
    self.qiTaBut = [GFButtonRight buttonWithType:UIButtonTypeCustom];
    self.qiTaBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 10 - 65, 0, 65, 25);
    _qiTaView = [self setJinengpingdingWithX:0 withY:CGRectGetMaxY(skillView.frame) + 15 + 35 * 5 withBut:self.qiTaBut withTitle:@"其他"];
    self.qiTaBut.tag = 6;
    
    
    
    // 横线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(skillView.frame) + 15 + 35 * 6, [UIScreen mainScreen].bounds.size.width, 1)];
    lineView1.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scView addSubview:lineView1];
    
    // 个人简介
    _txtView = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(skillView.frame) + 15 + 35 * 6 + 10, [UIScreen mainScreen].bounds.size.width - 40, 80)];
    _txtView.backgroundColor = [UIColor clearColor];
    _txtView.text = @"请介绍一下自己吧！（200字以内）";
    _txtView.textColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    _txtView.delegate = self;
    [_scView addSubview:_txtView];
    
    // 手持身份证正面照
    CLTitleView *idView = [[CLTitleView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_txtView.frame) + 15, self.view.frame.size.width, 45) Title:@"手持身份证正面照"];
    [_scView addSubview:idView];
    self.idCardImgViewBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.idCardImgViewBut.frame = CGRectMake(40 / 320.0 * [UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(idView.frame) + 15, [UIScreen mainScreen].bounds.size.width - 80, 140 / 568.0 * [UIScreen mainScreen].bounds.size.height);
    [self.idCardImgViewBut setBackgroundImage:[UIImage imageNamed:@"userImage"] forState:UIControlStateNormal];
    [_scView addSubview:self.idCardImgViewBut];
    self.cameraBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cameraBut.frame = CGRectMake(CGRectGetMaxX(self.idCardImgViewBut.frame) - 15, CGRectGetMaxY(self.idCardImgViewBut.frame) - 15, 30, 30);
    [self.cameraBut setBackgroundImage:[UIImage imageNamed:@"cameraUser"] forState:UIControlStateNormal];
    [self.cameraBut addTarget:self action:@selector(ccClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.idCardImgViewBut addTarget:self action:@selector(ccClick:) forControlEvents:UIControlEventTouchUpInside];
    self.idCardImgViewBut.tag = 2;
    self.cameraBut.tag = 2;
    [_scView addSubview:self.cameraBut];
    
    // 银行卡信息
    CLTitleView *yinhangView = [[CLTitleView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.idCardImgViewBut.frame) + 25, self.view.frame.size.width, 45) Title:@"银行卡信息"];
    [_scView addSubview:yinhangView];
    
    self.yinhangMingTxt = [self setYinhangWith:0 withY:CGRectGetMaxY(yinhangView.frame) withTitle:@"银行名称"];
    self.yinhangMingTxt.tag = 99;
    self.yinhangMingTxt.delegate = self;
    self.yinhangMingTxt.text = @"农业银行";
    // 横线
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(yinhangView.frame) + 40, [UIScreen mainScreen].bounds.size.width - 20, 1)];
    lineView2.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scView addSubview:lineView2];
    
    self.kahaoTxt = [self setYinhangWith:0 withY:CGRectGetMaxY(yinhangView.frame) + 40 withTitle:@"银行卡号"];
    self.kahaoTxt.delegate = self;
    
    // 横线
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(yinhangView.frame) + 40 + 40, [UIScreen mainScreen].bounds.size.width - 20, 1)];
    lineView3.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scView addSubview:lineView3];
    
    self.dizhiTxt = [self setYinhangWith:0 withY:CGRectGetMaxY(yinhangView.frame) + 40 + 40 withTitle:@"开户行地址"];
    self.dizhiTxt.delegate = self;
    
    // 横线
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(yinhangView.frame) + 40 + 40 + 40, [UIScreen mainScreen].bounds.size.width, 1)];
    lineView4.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scView addSubview:lineView4];
    
    // 提交按钮
    _submitBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitBut.frame = CGRectMake(40, CGRectGetMaxY(lineView4.frame) + 35, [UIScreen mainScreen].bounds.size.width - 80, 45);
    _submitBut.backgroundColor = [UIColor colorWithRed:233 / 255.0 green:96 / 255.0 blue:30 / 255.0 alpha:1];
    _submitBut.layer.cornerRadius = 5;
    if (self.isChange){
        [_submitBut setTitle:@"再次认证" forState:UIControlStateNormal];
    }else{
        [_submitBut setTitle:@"提交" forState:UIControlStateNormal];
    }
    [_scView addSubview:_submitBut];
    [_submitBut addTarget:self action:@selector(subButClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 技师认证协议
    UILabel *lab = [[UILabel alloc] init];
    lab.frame = CGRectMake(0, CGRectGetMaxY(_submitBut.frame) + 5, [UIScreen mainScreen].bounds.size.width * 0.6 - 6 / 320.0 * [UIScreen mainScreen].bounds.size.width, 20);
    lab.textColor = [UIColor lightGrayColor];
    [_scView addSubview:lab];
    lab.font = [UIFont systemFontOfSize:11];
    lab.textAlignment = NSTextAlignmentRight;
    lab.text = @"点击“提交”代表本人已阅读并同意";
    
    UIButton *bb = [UIButton buttonWithType:UIButtonTypeCustom];
    bb.frame = CGRectMake(CGRectGetMaxX(lab.frame), lab.frame.origin.y, [UIScreen mainScreen].bounds.size.width * 0.4 + 6 / 320.0 * [UIScreen mainScreen].bounds.size.width, 20);
    bb.titleLabel.font = [UIFont systemFontOfSize:11];
    [bb setTitleColor:[UIColor colorWithRed:233 / 255.0 green:96 / 255.0 blue:30 / 255.0 alpha:1] forState:UIControlStateNormal];
    [_scView addSubview:bb];
    bb.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [bb setTitle:@"《车邻邦技师认证协议》" forState:UIControlStateNormal];
    [bb addTarget:self action:@selector(xieyiBut) forControlEvents:UIControlEventTouchUpInside];
    
    
    _scView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(_submitBut.frame) + 60);
    
    // 时间选择器
    _bbView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _bbView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [self.view addSubview:_bbView];
    self.timePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 150)];
    self.timePickerView.dataSource = self;
    self.timePickerView.delegate = self;
    self.timePickerView.backgroundColor = [UIColor whiteColor];
    [_bbView addSubview:self.timePickerView];
    _bbView.hidden = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [_bbView addGestureRecognizer:tapGesture];
    
    
}

- (void)shuomingButClick {
    
    self.shuomingView.hidden = NO;
}

- (void)subButClick {
    
    [self.view endEditing:YES];
    
    _dataDictionary[@"name"] = self.nameTxt.text;
    _dataDictionary[@"idNo"] = self.idCardTxt.text;
    _dataDictionary[@"skill"] = @"";
    _dataDictionary[@"idPhoto"] = self.idPhoto;
    _dataDictionary[@"bank"] = self.yinhangMingTxt.text;
    _dataDictionary[@"bankCardNo"] = self.kahaoTxt.text;
    _dataDictionary[@"bankAddress"] = self.dizhiTxt.text;
    if(self.tuijianrenTxt.text.length > 0) {
        _dataDictionary[@"reference"] = self.tuijianrenTxt.text;
    }
    if(![self.txtView.text isEqualToString:@"请介绍一下自己吧！（200字以内）"]) {
        _dataDictionary[@"resume"] = self.txtView.text;
    }
    
//    NSLog(@"///////%@=====%@", self.selectBut.titleLabel.text, self.selectBut);
    
    NSString *skillStr = @"";
    // 隔热膜 1
    if((![self.gerebut.titleLabel.text isEqualToString:@"工作年限"]) && (![self.gerebut.titleLabel.text isEqualToString:@"0 年"]) && (![self.gereView.xingjiStr isEqualToString:@"0"])) {
        _dataDictionary[@"filmLevel"] = self.gereView.xingjiStr;
        NSRange rang = NSMakeRange(0, 1);
        _dataDictionary[@"filmWorkingSeniority"] = [self.gerebut.titleLabel.text substringWithRange:rang];
//        NSLog(@"\\\\\\\\\%@=====%@", _dataDictionary[@"filmWorkingSeniority"], self.gerebut);
        if([skillStr isEqualToString:@""]) {
        
            skillStr = @"1";
        }else {
            
            skillStr = [NSString stringWithFormat:@"%@,1", skillStr];
        }
    }else {
        _dataDictionary[@"filmLevel"] = @(0);
        _dataDictionary[@"filmWorkingSeniority"] = @(0);
    }
    // 隐形车衣 2
    if((![self.yinxingBut.titleLabel.text isEqualToString:@"工作年限"]) && (![self.yinxingBut.titleLabel.text isEqualToString:@"0 年"]) && (![self.yinxingView.xingjiStr isEqualToString:@"0"])) {
        _dataDictionary[@"carCoverLevel"] = self.yinxingView.xingjiStr;
        NSRange rang = NSMakeRange(0, 1);
        _dataDictionary[@"carCoverWorkingSeniority"] = [self.yinxingBut.titleLabel.text substringWithRange:rang];
//        NSLog(@"\\\\\\\\\%@=====%@", _dataDictionary[@"carCoverWorkingSeniority"], self.yinxingBut);
        if([skillStr isEqualToString:@""]) {
            
            skillStr = @"2";
        }else {
            
            skillStr = [NSString stringWithFormat:@"%@,2", skillStr];
        }
    }else {
        _dataDictionary[@"carCoverLevel"] = @(0);
        _dataDictionary[@"carCoverWorkingSeniority"] = @(0);
    }
    // 车身改色 3
    if((![self.gaiseBut.titleLabel.text isEqualToString:@"工作年限"]) && (![self.gaiseBut.titleLabel.text isEqualToString:@"0 年"]) && (![self.gaiseView.xingjiStr isEqualToString:@"0"])) {
        _dataDictionary[@"colorModifyLevel"] = self.gaiseView.xingjiStr;
        NSRange rang = NSMakeRange(0, 1);
        _dataDictionary[@"colorModifyWorkingSeniority"] = [self.gaiseBut.titleLabel.text substringWithRange:rang];
//        NSLog(@"\\\\\\\\\%@=====%@", _dataDictionary[@"colorModifyWorkingSeniority"], self.gaiseBut);
        if([skillStr isEqualToString:@""]) {
            
            skillStr = @"3";
        }else {
            
            skillStr = [NSString stringWithFormat:@"%@,3", skillStr];
        }
    }else {
        _dataDictionary[@"colorModifyLevel"] = @(0);
        _dataDictionary[@"colorModifyWorkingSeniority"] = @(0);
    }
    // 美容清洁 4
    if((![self.meirongBut.titleLabel.text isEqualToString:@"工作年限"]) && (![self.meirongBut.titleLabel.text isEqualToString:@"0 年"]) && (![self.meirongView.xingjiStr isEqualToString:@"0"])) {
        _dataDictionary[@"beautyLevel"] = self.meirongView.xingjiStr;
        NSRange rang = NSMakeRange(0, 1);
        if([self.meirongBut.titleLabel.text isEqualToString:@"10 年"]) {
            rang = NSMakeRange(0, 2);
        }
        _dataDictionary[@"beautyWorkingSeniority"] = [self.meirongBut.titleLabel.text substringWithRange:rang];
//        NSLog(@"\\\\\\\\\%@=====%@", _dataDictionary[@"beautyWorkingSeniority"], self.meirongBut);
        if([skillStr isEqualToString:@""]) {
            
            skillStr = @"4";
        }else {
            
            skillStr = [NSString stringWithFormat:@"%@,4", skillStr];
        }
    }else {
        _dataDictionary[@"beautyLevel"] = @(0);
        _dataDictionary[@"beautyWorkingSeniority"] = @(0);
    }
    
    // 安全膜 5
    if((![self.anQuanBut.titleLabel.text isEqualToString:@"工作年限"]) && (![self.anQuanBut.titleLabel.text isEqualToString:@"0 年"]) && (![self.anQuanView.xingjiStr isEqualToString:@"0"])) {
        _dataDictionary[@"safeLevel"] = self.anQuanView.xingjiStr;
        NSRange rang = NSMakeRange(0, 1);
        if([self.anQuanBut.titleLabel.text isEqualToString:@"10 年"]) {
            rang = NSMakeRange(0, 2);
        }
        _dataDictionary[@"safeWorkingSeniority"] = [self.anQuanBut.titleLabel.text substringWithRange:rang];
        //        NSLog(@"\\\\\\\\\%@=====%@", _dataDictionary[@"beautyWorkingSeniority"], self.meirongBut);
        if([skillStr isEqualToString:@""]) {
            
            skillStr = @"5";
        }else {
            
            skillStr = [NSString stringWithFormat:@"%@,5", skillStr];
        }
    }else {
        _dataDictionary[@"safeLevel"] = @(0);
        _dataDictionary[@"safeWorkingSeniority"] = @(0);
    }
    
    // 其他 99
    if((![self.qiTaBut.titleLabel.text isEqualToString:@"工作年限"]) && (![self.qiTaBut.titleLabel.text isEqualToString:@"0 年"]) && (![self.qiTaView.xingjiStr isEqualToString:@"0"])) {
        _dataDictionary[@"otherLevel"] = self.qiTaView.xingjiStr;
        NSRange rang = NSMakeRange(0, 1);
        if([self.qiTaBut.titleLabel.text isEqualToString:@"10 年"]) {
            rang = NSMakeRange(0, 2);
        }
        _dataDictionary[@"otherWorkingSeniority"] = [self.qiTaBut.titleLabel.text substringWithRange:rang];
        //        NSLog(@"\\\\\\\\\%@=====%@", _dataDictionary[@"beautyWorkingSeniority"], self.meirongBut);
        if([skillStr isEqualToString:@""]) {
            
            skillStr = @"99";
        }else {
            
            skillStr = [NSString stringWithFormat:@"%@,99", skillStr];
        }
    }else {
        _dataDictionary[@"otherLevel"] = @(0);
        _dataDictionary[@"otherWorkingSeniority"] = @(0);
    }
    
    
    
    _dataDictionary[@"skill"] = skillStr;
    
    ICLog(@"==认证信息==%@", _dataDictionary);
    
    if([_dataDictionary[@"name"] isEqualToString:@""]) {
    
        [self addAlertView:@"请输入姓名"];
    }else if([_dataDictionary[@"idNo"] isEqualToString:@""]) {
        [self addAlertView:@"请输入身份证号"];
    }else if([_dataDictionary[@"idPhoto"] isEqualToString:@""]) {
        [self addAlertView:@"请上传证件照"];
    }else if([_dataDictionary[@"skills"] isEqualToString:@""]) {
        [self addAlertView:@"请至少选择一项技能和工龄"];
    }else if([_dataDictionary[@"bank"] isEqualToString:@""]) {
        [self addAlertView:@"请输入银行"];
    }else if([_dataDictionary[@"bankCardNo"] isEqualToString:@""]) {
        [self addAlertView:@"请输入银行卡号"];
    }else if([_dataDictionary[@"bankAddress"] isEqualToString:@""]) {
        [self addAlertView:@"请输入开户行地址"];
    }else {
        [GFHttpTool certifyPostParameters:_dataDictionary success:^(id responseObject) {
            
//            NSLog(@"==提交认证的=%@", responseObject);
            if([responseObject[@"status"] integerValue] == 1) {
                [self addAlertView:@"提交成功"];
                [self performSelector:@selector(success) withObject:nil afterDelay:1.5];
            }else {
                
                [self addAlertView:responseObject[@"message"]];
            }
        } failure:^(NSError *error) {
            
//            NSLog(@"==提交认证的=%@", error);
        }];
    }
}
- (void)success{
    
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
//    UINavigationController *vv = (UINavigationController *)window.rootViewController;
//    CLAutobonViewController *clVC = (CLAutobonViewController *)vv.viewControllers[0];
////    [clVC.certifyButton setTitleColor:[[UIColor alloc]initWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1.0] forState:UIControlStateNormal];
//    [clVC.certifyButton setTitle:@"查看进度" forState:UIControlStateNormal];
//    [self.navigationController popToRootViewControllerAnimated:YES];
    
    GFSignInViewController *autobonView = [[GFSignInViewController alloc] init];
    UINavigationController *mavVC = [[UINavigationController alloc] initWithRootViewController:autobonView];
    mavVC.navigationBarHidden = YES;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = mavVC;
    
//    [self.navigationController popToRootViewControllerAnimated:YES];
    
    //    CLCertifyingViewController *certifying = [[CLCertifyingViewController alloc]init];
    //    [self.navigationController pushViewController:certifying animated:YES];
    
//    if ([_submitButton.titleLabel.text isEqualToString:@"提交"]) {
//        CLAutobonViewController *autobon = (CLAutobonViewController *)self.navigationController.viewControllers[1];
//        autobon.certifyButton.userInteractionEnabled = NO;
//        [autobon.certifyButton setTitleColor:[[UIColor alloc]initWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1.0] forState:UIControlStateNormal];
//        [self.navigationController popViewControllerAnimated:YES];
//    }else{
//        [self.navigationController popViewControllerAnimated:YES];
//    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if(textField.tag == 99) {
        
        [self.view endEditing:YES];
        _tableView.hidden = NO;
        _ttView.hidden = NO;
    }else {
        
        _scView.contentSize = CGSizeMake(_scView.contentSize.width, _scView.contentSize.height + 300);
        _scView.contentOffset = CGPointMake(0, _scView.contentOffset.y + 250);
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if(textField.tag != 99) {
        
        _scView.contentSize = CGSizeMake(_scView.contentSize.width, _scView.contentSize.height - 300);
        _scView.contentOffset = CGPointMake(0, _scView.contentOffset.y);
    }
}

- (void)nianxingClick:(GFButtonRight *)sender {
    
    _bbView.hidden = NO;
    self.butTag = sender.tag;
    self.selectBut = sender;
    
    [self.view endEditing:YES];
    [self.timePickerView selectRow:0 inComponent:0 animated:YES];
}
//轻击手势触发方法
-(void)tapGesture:(UITapGestureRecognizer *)sender {
    
    _bbView.hidden = YES;
//    _tableView.hidden = YES;
}
//轻击手势触发方法
-(void)tapGesture2:(UITapGestureRecognizer *)sender {
    
//    _bbView.hidden = YES;
    _tableView.hidden = YES;
    _ttView.hidden = YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    return 11;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    return [NSString stringWithFormat:@"%ld 年", row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)componen {
    
    [self.selectBut setTitle:[NSString stringWithFormat:@"%ld 年", row] forState:UIControlStateNormal];
//    NSLog(@"===%@", self.selectBut.titleLabel.text);
}

- (void)xieyiBut {
    
    CLDelegateViewController *delegateView = [[CLDelegateViewController alloc]init];
    delegateView.delegateTitle = @"CertifyDelegate";
    [self.navigationController pushViewController:delegateView animated:YES];
}
// 银行信息输入框
- (UITextField *)setYinhangWith:(CGFloat)x withY:(CGFloat)y withTitle:(NSString *)tittle {
    
    UIView *vv = [[UIView alloc] init];
    vv.frame = CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width, 40);
    [_scView addSubview:vv];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.frame = CGRectMake(10, 0, 100, 40);
    lab.textColor = [UIColor lightGrayColor];
    lab.text = tittle;
    lab.font = [UIFont systemFontOfSize:14];
    [vv addSubview:lab];
    
    UITextField *txt = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame), 0, [UIScreen mainScreen].bounds.size.width - 20 - 100, 40)];
    [txt setTextFieldPlaceholderString:@"请输入"];
    txt.font = [UIFont systemFontOfSize:14];
    txt.textColor = [UIColor darkGrayColor];
    [vv addSubview:txt];
    
    return txt;
}

// 星级和工作年限评估条
- (GFPingfenView *)setJinengpingdingWithX:(CGFloat)x withY:(CGFloat)y withBut:(GFButtonRight *)but withTitle:(NSString *)title {
    
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width, 45)];
    [_scView addSubview:vv];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.frame = CGRectMake(10, 0, 80, 25);
    lab.textColor = [UIColor darkGrayColor];
    lab.font = [UIFont systemFontOfSize:14];
    lab.text = title;
    [vv addSubview:lab];
    
    GFPingfenView *pView = [[GFPingfenView alloc] initWithFrame:CGRectMake(90, 0, 145, 25)];
    [vv addSubview:pView];
    
    
    [but setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    [but setTitle:@"工作年限" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor colorWithRed:233 / 255.0 green:96 / 255.0 blue:30 / 255.0 alpha:1] forState:UIControlStateNormal];
    but.titleLabel.font = [UIFont systemFontOfSize:12];
    but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [vv addSubview:but];
    [but addTarget:self action:@selector(nianxingClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return pView;
}

// 姓名、身份证、推荐人输入框
- (UITextField *)setTextFieldWithTitle:(NSString *)title withX:(CGFloat)x withY:(CGFloat)y {
    
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width - 120, 30)];
    [_scView addSubview:vv];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.frame = CGRectMake(0, 0, 80, 30);
    lab.text = title;
    lab.textColor = [UIColor grayColor];
    lab.font = [UIFont systemFontOfSize:14];
    [vv addSubview:lab];
    
    UITextField *txt = [[UITextField alloc] initWithFrame:CGRectMake(80, 0, vv.frame.size.width - 80, 30)];
    txt.font = [UIFont systemFontOfSize:14];
    txt.textColor = [UIColor darkGrayColor];
    [txt setTextFieldPlaceholderString:@"请输入"];
    [vv addSubview:txt];
    
    UIView *lineView= [[UIView alloc] initWithFrame:CGRectMake(75, 29, vv.frame.size.width - 75, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [vv addSubview:lineView];
    
    return txt;
}
// 添加导航
- (void)setNavigation{
    
    
    _navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"我要认证" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [_navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
    
    
}
// 返回按钮
-(void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)ccClick:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    if (sender.tag == 1) {
        _isHeadImage = YES;
    }else{
        _isHeadImage = NO;
    }
    if (_chooseView == nil) {
        _chooseView = [[CLTouchView alloc]initWithFrame:self.view.bounds];
        _chooseView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
        [self.view addSubview:_chooseView];
        
        UIView *chooseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 80)];
        chooseView.center = self.view.center;
        chooseView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        chooseView.layer.cornerRadius = 15;
        chooseView.clipsToBounds = YES;
        [_chooseView addSubview:chooseView];
        
        // 相机和相册按钮
        UIButton *cameraButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 40)];
        [cameraButton setTitle:@"相册" forState:UIControlStateNormal];
        [cameraButton addTarget:self action:@selector(userHeadChoose:) forControlEvents:UIControlEventTouchUpInside];
        cameraButton.tag = 1;
        [chooseView addSubview:cameraButton];
        
        UIButton *photoButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width-100, 40)];
        [photoButton setTitle:@"相机" forState:UIControlStateNormal];
        [photoButton addTarget:self action:@selector(userHeadChoose:) forControlEvents:UIControlEventTouchUpInside];
        photoButton.tag = 2;
        [chooseView addSubview:photoButton];
    }
    
    
    _chooseView.hidden = NO;
}
#pragma mark - 选择照片
- (void)userHeadChoose:(UIButton *)button{
    _chooseView.hidden = YES;
    //    _scrollView.userInteractionEnabled = YES;
    if (button.tag == 1) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        //        imagePickerController.allowsEditing = YES;
        imagePickerController.delegate =self;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }else{
        //        NSLog(@"打开相机");
        BOOL result = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        if (result) {
            //            NSLog(@"---支持使用相机---");
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            // 编辑模式
            //            imagePicker.allowsEditing = YES;
            [self  presentViewController:imagePicker animated:YES completion:^{
            }];
        }else{
            //            NSLog(@"----不支持使用相机----");
        }
        
    }
    
    
}
#pragma mark - 图片协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (_isHeadImage) {
        [_iconBut setBackgroundImage:image forState:UIControlStateNormal];
        CGSize imagesize;
        if (image.size.width > image.size.height) {
            imagesize.width = 800;
            imagesize.height = image.size.height*800/image.size.width;
        }else{
            imagesize.height = 800;
            imagesize.width = image.size.width*800/image.size.height;
        }
        UIImage *imageNew = [self imageWithImage:image scaledToSize:imagesize];
        NSData *imageData = UIImageJPEGRepresentation(imageNew, 0.8);
        
        
        
        [GFHttpTool headImage:imageData success:^(NSDictionary *responseObject) {
//            NSLog(@"-----responseObject---%@--",responseObject);
            if ([responseObject[@"status"]intValue] == 1) {
                _haveHeadImage = YES;
                
                [self addAlertView:@"头像上传成功"];
            }else{
                [self addAlertView:@"头像上传失败"];
                [_iconBut setBackgroundImage:[UIImage imageNamed:@"userHeadImage"] forState:UIControlStateNormal];
            }
        } failure:^(NSError *error) {
//            NSLog(@"---请求失败－－%@－－",error);
            [self addAlertView:@"头像上传失败"];
            [_iconBut setBackgroundImage:[UIImage imageNamed:@"userHeadImage"] forState:UIControlStateNormal];
        }];
        
    }else{
        [_idCardImgViewBut setBackgroundImage:image forState:UIControlStateNormal];
        //        _haveIdentityImage = YES;
        _idCardImgViewBut.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        CGSize imagesize;
        imagesize.width = image.size.width/2;
        imagesize.height = image.size.height/2;
        UIImage *imageNew = [self imageWithImage:image scaledToSize:imagesize];
        NSData *imageData = UIImageJPEGRepresentation(imageNew, 0.3);
        [GFHttpTool idPhotoImage:imageData success:^(NSDictionary *responseObject) {
            //            NSLog(@"----%@---",responseObject);
            if ([responseObject[@"status"]intValue] == 1) {
                _haveIdentityImage = YES;
                [self addAlertView:@"证件照上传成功"];
                [_dataDictionary setObject:responseObject[@"message"] forKey:@"idPhoto"];
                self.idPhoto = responseObject[@"message"];
                
            }else{
                [self addAlertView:@"证件照上传失败"];
                [_idCardImgViewBut setBackgroundImage:[UIImage imageNamed:@"userImage"] forState:UIControlStateNormal];
            }
        } failure:^(NSError *error) {
            [self addAlertView:@"证件照上传失败"];
            [_idCardImgViewBut setBackgroundImage:[UIImage imageNamed:@"userImage"] forState:UIControlStateNormal];
        }];
        
    }
    
}
#pragma mark - 压缩图片尺寸
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}


#pragma mark - textView的协议方法
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@"请介绍一下自己吧！（200字以内）"]) {
        textView.text = nil;
        textView.textColor = [UIColor blackColor];
    }
    
    _scView.contentSize = CGSizeMake(_scView.contentSize.width, _scView.contentSize.height+300);
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        textView.text = @"请介绍一下自己吧！（200字以内）";
        textView.textColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    }
    
    _scView.contentSize = CGSizeMake(_scView.contentSize.width, _scView.contentSize.height-300);
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (textView.text.length > 200 && range.length==0) {
        return NO;
    }else{
        return YES;
    }
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
