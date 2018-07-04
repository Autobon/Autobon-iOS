//
//  CLTeamPeopleViewController.m
//  CarMap
//
//  Created by inCar on 2018/7/3.
//  Copyright © 2018年 mll. All rights reserved.
//

#import "CLTeamPeopleViewController.h"
#import "GFNavigationView.h"
#import "GFHttpTool.h"


@interface CLTeamPeopleViewController ()
{
    CGFloat kWidth;
    CGFloat kHeight;
    NSMutableArray *_dataArray;
    UITableView *_tableView;
}
@property (nonatomic, strong) GFNavigationView *navView;
@end



@implementation CLTeamPeopleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _setBase];
    
    [self getTeamPeople];
    
}


- (void)getTeamPeople{
    NSDictionary *dataDictionary = @{@"teamId":_teamModel.idString};
    [GFHttpTool getTechnicianTeamDetailWithDictionary:dataDictionary Success:^(id responseObject) {
        ICLog(@"----查询成功----%@--",responseObject);
        
    } failure:^(NSError *error) {
        ICLog(@"---查询失败---%@--",error);
        
    }];
}

- (void)_setBase {
    
    kWidth = [UIScreen mainScreen].bounds.size.width;
    kHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.view.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"团队技师" withFrame:CGRectMake(0, 0, kWidth, 64)];
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
