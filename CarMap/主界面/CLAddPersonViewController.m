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
#import "GFHttpTool.h"
#import "CLAddPersonModel.h"
#import "UIImageView+WebCache.h"
#import "GFTipView.h"
#import "CLHomeOrderViewController.h"


//@interface UITableView (touch)
//
//@end
//
//@implementation UITableView (touch)
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [[self superview] endEditing:YES];
//}
//
//@end


@interface CLAddPersonViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UISearchBar *_searchbar;
    NSMutableArray *_addPersonArray;
    UITableView *_tableView;
    
    BOOL _isAdd;
    
}
@end

@implementation CLAddPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _addPersonArray = [[NSMutableArray alloc]init];
    
    [self setNavigation];
    
    [self setViewForAdd];
    
    self.view.backgroundColor = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
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
    [searchButton addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = CGRectMake(0, 124, self.view.frame.size.width, self.view.frame.size.height-124);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
//    tableView.backgroundColor = [UIColor cyanColor];
}


- (void)searchBtnClick{
    NSLog(@"搜索按钮被点击了");
    [self.view endEditing:YES];
    [GFHttpTool getSearch:_searchbar.text Success:^(NSDictionary *responseObject) {
        if ([responseObject[@"result"]integerValue] == 1) {
            NSDictionary *dataDic = responseObject[@"data"];
            NSArray *listArray = dataDic[@"list"];
            [_addPersonArray removeAllObjects];
            if (listArray.count>0) {
                [listArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                    CLAddPersonModel *person = [[CLAddPersonModel alloc]init];

                    if (![obj[@"avatar"] isKindOfClass:[NSNull class]] && ![obj[@"name"] isKindOfClass:[NSNull class]]) {
                        person.headImageURL = [NSString stringWithFormat:@"http://121.40.157.200:12345/%@",obj[@"avatar"]];
                        person.nameString = obj[@"name"];
                    }
                    person.phoneString = obj[@"phone"];
                    person.personId = obj[@"id"];
                    [_addPersonArray addObject:person];
                }];
                
            }else{
                [self addAlertView:@"技师不存在"];
            }
            [_tableView reloadData];
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        [self addAlertView:@"请求失败"];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _addPersonArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[CLPersonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell setCell];
        cell.backgroundColor = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
    }
    CLAddPersonModel *person = _addPersonArray[indexPath.row];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:person.headImageURL] placeholderImage:[UIImage imageNamed:@"userHeadImage"]];
    
    cell.userNameLabel.text = person.nameString;
    cell.identityLabel.text = person.phoneString;
    cell.button.tag = indexPath.row;
    [cell.button addTarget:self action:@selector(addPersonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - 添加合伙人按钮
- (void)addPersonBtnClick:(UIButton *)button{
    NSLog(@"添加合伙技师");
    CLAddPersonModel *person = _addPersonArray[button.tag];
    NSDictionary *dic = @{@"orderId":_orderId,@"partnerId":person.personId};
    [GFHttpTool postAddPerson:dic Success:^(NSDictionary *responseObject) {
         NSLog(@"－－－%@--",responseObject);
        if ([responseObject[@"result"]integerValue]==1) {
            [self addAlertView:@"邀请已发送"];
            _isAdd = YES;
        }else{
            [self addAlertView:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
       [self addAlertView:@"请求失败"];
    }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [self searchBtnClick];
}

// 添加导航
- (void)setNavigation{
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:@"moreList" withRightImgHightName:@"moreListClick" withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navView];
    
    
}
- (void)backBtnClick{
    if (_isAdd) {
        CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
        [homeOrder headRefresh];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
// 更多按钮的响应方法
- (void)moreBtnClick{
    NSLog(@"更多");
}

#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
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
