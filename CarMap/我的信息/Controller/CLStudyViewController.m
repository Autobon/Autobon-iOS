//
//  CLStudyViewController.m
//  CarMap
//
//  Created by inCar on 2018/6/19.
//  Copyright © 2018年 mll. All rights reserved.
//

#import "CLStudyViewController.h"
#import "GFNavigationView.h"
#import "GFHttpTool.h"
#import "CLStudyModel.h"
#import "Masonry.h"
#import "CLStudyTableViewCell.h"
#import "CLStudyDetailWebViewController.h"


@interface CLStudyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat kWidth;
    CGFloat kHeight;
    
    NSMutableArray *_dataArray;
    UITableView *_tableVIew;
}
@property (nonatomic, strong) GFNavigationView *navView;
@end

@implementation CLStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _setBase];
    
    _dataArray = [[NSMutableArray alloc]init];
    
    [self setViewForTableView];
    
    
    
    [GFHttpTool adminStudyListGetWithParameters:nil success:^(id responseObject) {
        ICLog(@"获取学习园地列表成功----%@---",responseObject);
        BOOL status = responseObject[@"status"];
        if(status == YES){
            NSDictionary *messageDictionary = responseObject[@"message"];
            NSArray *listArray = messageDictionary[@"list"];
            [listArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CLStudyModel *studyModel = [[CLStudyModel alloc]init];
                [studyModel setModelForDataWithDictionary:obj];
                [_dataArray addObject:studyModel];
            }];
            
            [_tableVIew reloadData];
        }


    } failure:^(NSError *error) {
        ICLog(@"---获取学习园地列表失败---%@---",error);


    }];
    
    
    
}


- (void)setViewForTableView{
    
    _tableVIew = [[UITableView alloc]init];
    _tableVIew.delegate = self;
    _tableVIew.dataSource = self;
    [self.view addSubview:_tableVIew];
    [_tableVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navView.mas_bottom).offset(0);
        make.left.bottom.right.equalTo(self.view).offset(0);
    }];
    
    _tableVIew.backgroundColor = [UIColor clearColor];
    _tableVIew.separatorColor = [UIColor clearColor];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLStudyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell = [[CLStudyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if(_dataArray.count > indexPath.row){
        [cell setDataForStudyModel:_dataArray[indexPath.row]];
    }
    
    
    return cell;
}


- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    return _dataArray.count;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(_dataArray.count > indexPath.row){
        CLStudyDetailWebViewController *studyDetailWebVC = [[CLStudyDetailWebViewController alloc]init];
        CLStudyModel *studyModel = _dataArray[indexPath.row];
        studyDetailWebVC.pathString = studyModel.path;
        [self.navigationController pushViewController:studyDetailWebVC animated:true];
    }
    
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
