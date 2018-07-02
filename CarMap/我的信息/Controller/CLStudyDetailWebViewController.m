//
//  CLStudyDetailWebViewController.m
//  CarMap
//
//  Created by inCar on 2018/6/25.
//  Copyright © 2018年 mll. All rights reserved.
//

#import "CLStudyDetailWebViewController.h"
#import "GFNavigationView.h"


@interface CLStudyDetailWebViewController ()
{
    CGFloat kWidth;
    CGFloat kHeight;
}

@property (nonatomic, strong) GFNavigationView *navView;

@end

@implementation CLStudyDetailWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _setBase];
    
    
    
    
    UIWebView *webView = [[UIWebView alloc]init];
    //    webView.scalesPageToFit = YES;
    NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@/api/mobile/admin/study/download?path=%@",BaseHttp,_pathString]];
    //    NSURL* url = [[NSURL alloc] initWithString:@"https://dev.markd.cn"];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    //    [request setValue:@"autoken=\"staff:ssEoVBwJ3rSYnidORQUvhQ==@L8MUYS\"" forHTTPHeaderField:@"Cookie"];
    [webView loadRequest:request];
    
    //    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    //    button.frame = CGRectMake(20, 20, 40, 40);
    [self.view addSubview:webView];
    
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(_navView.mas_bottom);
    }];
    
}








- (void)_setBase {
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"学习园地" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)leftButClick {
    
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
