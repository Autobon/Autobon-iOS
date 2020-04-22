//
//  CLCommissionViewController.m
//  CarMap
//
//  Created by inCar on 17/2/20.
//  Copyright © 2017年 mll. All rights reserved.
//

#import "CLCommissionViewController.h"
#import "GFNavigationView.h"


@interface CLCommissionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_titleArray;
    NSArray *_valueArray;
}

@property (nonatomic, strong) GFNavigationView *navView;

@end

@implementation CLCommissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 基础设置
    [self _setBase];
    
    _titleArray = @[@"贴膜顶级前档",@"贴膜顶级门",@"贴膜顶级后档",@"贴膜常规前档",@"贴膜常规门",@"贴膜常规后档",@"车衣前保险杠",@"车衣引擎盖",@"车衣左右前叶子板",@"车衣四门",@"车衣左右后叶子板",@"车衣尾盖",@"车衣后保险杠",@"车衣ABC柱套件",@"车衣车顶",@"车衣门拉手",@"车衣反光镜",@"普通洗车",@"出水芙蓉精细洗车",@"四门手扣犀牛皮",@"后视镜犀牛皮",@"天窗护理",@"新车整备",@"轮毂翻新",@"轮毂镀膜",@"玻璃镀膜",@"玻璃深度清洁",@"内饰翻新",@"内饰消毒除味",@"普林艾尔（空气净化）",@"室内清洗",@"桑拿+消毒除味",@"氧触媒套装",@"真皮清洁",@"真皮护理镀膜",@"内部聚乙烯养护",@"门板镀膜",@"引擎舱翻新护理",@"真皮保养",@"底盘装甲",@"玻璃镀膜-4S店",@"轮毂清洗",@"外观镀络件养护",@"外观镀络件翻新",@"发动机表面清洁",@"卡曼一号镀晶",@"绚丽极光养护",@"卡曼二号镀晶",@"漆面抛光（旧车）",@"打蜡（含漆面处理）",@"封釉（含漆面处理）",@"抛光（旧车）",@"新车漆面处理",@"镀晶维护",@"镀膜（镀晶含漆面处理）",@"镀膜维护",@"新车漆面处理"];
    _valueArray = @[@"60    ",@"12    ",@"40    ",@"40    ",@"5    ",@"20    ",@"95    ",@"87    ",@"72    ",@"127    ",@"150    ",@"55    ",@"79    ",@"48    ",@"71    ",@"8    ",@"8    ",@"4    ",@"10    ",@"6    ",@"6    ",@"5    ",@"10    ",@"15    ",@"5    ",@"15    ",@"20    ",@"45    ",@"15    ",@"80    ",@"30    ",@"10    ",@"10    ",@"10    ",@"20    ",@"10    ",@"15    ",@"20    ",@"10    ",@"40    ",@"10    ",@"5    ",@"15    ",@"50    ",@"15    ",@"70    ",@"50    ",@"70    ",@"40    ",@"30    ",@"30    ",@"50    ",@"40    ",@"20    ",@"40    ",@"30    ",@"20    "];
    
    
    [self setTableView];
    
}


- (void)setTableView{
    
    UITableView *tableView = [[UITableView alloc]init];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
//    tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
    [self.view addSubview:tableView];
    tableView.showsVerticalScrollIndicator = NO;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(_navView.mas_bottom);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.detailTextLabel.text = _valueArray[indexPath.row];
    return cell;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 57;
}


- (void)_setBase {
    
    
    self.view.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
    
    // 导航栏
    self.navView = [[GFNavigationView alloc] initWithLeftImgName:@"back.png" withLeftImgHightName:@"backClick.png" withRightImgName:nil withRightImgHightName:nil withCenterTitle:@"佣金标准" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
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
