//
//  DelegateViewController.m
//  obdInterface
//
//  Created by 李孟龙 on 16/1/20.
//  Copyright © 2016年 lubo. All rights reserved.
//

#import "CLDelegateViewController.h"
#import "GFNavigationView.h"



@interface CLDelegateViewController ()
{
    GFNavigationView *_navView;
}
@end

@implementation CLDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 返回按钮
//    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeSystem];
//    backBut.frame = CGRectMake(0, 0, 44, 44);
//    backBut.imageEdgeInsets = UIEdgeInsetsMake(0, -34, 0, 0);
//    [backBut setImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//    [backBut addTarget:self action:@selector(backButClick) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftBut = [[UIBarButtonItem alloc] initWithCustomView:backBut];
//    self.navigationItem.leftBarButtonItem = leftBut;
    
    
    
    UIWebView *webView = [[UIWebView alloc]init];
//    webView.scalesPageToFit = YES;
    NSString* path = [[NSBundle mainBundle] pathForResource:_delegateTitle ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
//    NSURL* url = [[NSURL alloc] initWithString:@"http://10.0.12.182:12345/api/web/admin/study/download?path=/uploads/study/20170619150545DX5WL3.xlsx"];
//    NSURL* url = [[NSURL alloc] initWithString:@"https://dev.markd.cn"];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    
//    [request setValue:@"autoken=\"staff:ssEoVBwJ3rSYnidORQUvhQ==@L8MUYS\"" forHTTPHeaderField:@"Cookie"];
    [webView loadRequest:request];
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = CGRectMake(20, 20, 40, 40);
    [self.view addSubview:webView];
    
    [self setNavigation];
    
    
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(_navView.mas_bottom);
    }];
}
// 添加导航
- (void)setNavigation{
    
    
    _navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"车邻邦协议" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [_navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navView];
    
    
    
}
-(void)backBtnClick{
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
