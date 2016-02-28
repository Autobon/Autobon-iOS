//
//  CLAddPersonViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/25.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLAddPersonViewController.h"
#import "GFNavigationView.h"
#import "CLPersonTableViewCell.h"



@interface UITableView (touch)

@end

@implementation UITableView (touch)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[self superview] endEditing:YES];
}

@end


@interface CLAddPersonViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UISearchBar *_searchbar;
}
@end

@implementation CLAddPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    
    [self setViewForAdd];
    
    self.view.backgroundColor = [UIColor colorWithRed:253/255.0 green:253/255.0 blue:253/255.0 alpha:1.0];
}


- (void)setViewForAdd{
    _searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(20, 84, self.view.frame.size.width-100, 40)];
//    searchbar.backgroundColor = [UIColor whiteColor];
    _searchbar.barTintColor = [UIColor whiteColor];
//    searchbar.barStyle = UIBarStyleDefault;
    _searchbar.layer.cornerRadius = 20;
    _searchbar.layer.borderWidth = 1.0;
    _searchbar.layer.borderColor = [[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]CGColor];
    
    [self.view addSubview:_searchbar];
    _searchbar.delegate = self;
    _searchbar.clipsToBounds = YES;
    
    
    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, 84, 60, 40)];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [self.view addSubview:searchButton];
    
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.frame = CGRectMake(0, 124, self.view.frame.size.width, self.view.frame.size.height-124);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor cyanColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[CLPersonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        cell.backgroundColor = [UIColor cyanColor];
        [cell setCell];
    }
    
    
    return cell;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
}

// 添加导航
- (void)setNavigation{
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:@"moreList" withRightImgHightName:@"moreListClick" withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView.rightBut addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
    
    
}
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}
// 更多按钮的响应方法
- (void)moreBtnClick{
    NSLog(@"更多");
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
