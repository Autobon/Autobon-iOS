//
//  GFNoIndentViewController.m
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/10.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFNoIndentViewController.h"
#import "GFNavigationView.h"
#import "GFTextField.h"

#import "GFNoIndentTableViewCell.h"

@interface GFNoIndentViewController () {
    
    CGFloat kWidth;
    CGFloat kHeight;
}

@property (nonatomic, strong) GFNavigationView *navView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GFNoIndentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 基础设置
    [self _setBase];
    
    // 界面搭建
    [self _setView];
}

- (void)_setBase {
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"服务中心" withFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.navView.leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)_setView {
    
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(_navView.mas_bottom);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    GFNoIndentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
        cell = [[GFNoIndentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.orderNum = @"gasgasdgfasg";
    cell.orderType = @"未接单";
    cell.beizhu = @"放假撒旦了房价俺是打工啦打发苏开发商发誓的发生了回复撒见到过爱手工奥斯卡说服力撒谎的发完烧的啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发啦打发苏开发商发";
//    NSLog(@"cell.image---%@--",cell)
    [cell setMessage];
    
    return cell;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    
    
    return 500;
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
