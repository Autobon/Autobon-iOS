//
//  CLWorkOverViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/24.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLWorkOverViewController.h"
#import "GFNavigationView.h"
#import "CLTitleView.h"


@interface CLWorkOverViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIView *_chooseView;
    UIImageView *_carImageView;
    UIButton *_cameraBtn;
    NSMutableArray *_imageArray;
    NSMutableArray *_buttonArray;
}


@end

@implementation CLWorkOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageArray = [[NSMutableArray alloc]init];
    _buttonArray = [[NSMutableArray alloc]init];
    [self setDate];
    
    [self setNavigation];
    
    [self titleView];
    
}

// 设置日期和状态
- (void)setDate{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 36)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, 200, 20)];
    timeLabel.text = [self weekdayString];
    timeLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:timeLabel];
    
    UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-100, 8, 80, 20)];
    stateLabel.text = @"即将完成模式";
    stateLabel.textAlignment = NSTextAlignmentRight;
    stateLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:stateLabel];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 36, self.view.frame.size.width, 1)];
    view.backgroundColor = [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0];
    [headerView addSubview:view];
    
    NSLog(@"设置日期和时间");
    //    headerView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:headerView];
}
#pragma mark - 获取周几
- (NSString *)weekdayString{
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"zh_CN"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:[NSDate date]];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSLog(@"---dateString--%@---",dateString);
    
    NSString *timeString = [NSString stringWithFormat:@"%@  %@",dateString,[weekdays objectAtIndex:theComponents.weekday]];
    return timeString;
    
    
    
}

- (void)titleView{
    
    
    
    
    
    UILabel *distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 101, self.view.frame.size.width, 40)];
    distanceLabel.text = @"已用时：15分28秒";
    distanceLabel.backgroundColor = [UIColor whiteColor];
    distanceLabel.font = [UIFont systemFontOfSize:15];
    distanceLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:distanceLabel];
    
    
    
    
    
    
    
    
    
    
    
    
    _carImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/7, 155, self.view.frame.size.width*5/7, self.view.frame.size.width*27/70)];
    _carImageView.image = [UIImage imageNamed:@"carImage"];
    [self.view addSubview:_carImageView];
    
    _cameraBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*6/7-15, 155+self.view.frame.size.width*27/70-25, 30, 30)];
    [_cameraBtn setImage:[UIImage imageNamed:@"cameraUser"] forState:UIControlStateNormal];
    [_cameraBtn addTarget:self action:@selector(cameraHeadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cameraBtn];
    
    
    
    
    CLTitleView *titleView = [[CLTitleView alloc]initWithFrame:CGRectMake(0, 64+36+40 + self.view.frame.size.width/3*2+10, self.view.frame.size.width, 45) Title:@"选择本次负责的工作项"];
    [self.view addSubview:titleView];
    

    UIButton *fiveButton = [[UIButton alloc]initWithFrame:CGRectMake(10, titleView.frame.origin.y+50, 100, 30)];
    [fiveButton setTitle:@"五座车" forState:UIControlStateNormal];
    [fiveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:fiveButton];
    
    UIButton *sevenButton = [[UIButton alloc]initWithFrame:CGRectMake(130, titleView.frame.origin.y+50, 100, 30)];
    [sevenButton setTitle:@"七座车" forState:UIControlStateNormal];
    [sevenButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:sevenButton];
    
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, titleView.frame.origin.y+80, self.view.frame.size.width, 2)];
    lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [self.view addSubview:lineView];
    
    
    NSArray *array = @[@"前风挡",@"左前门",@"右前门",@"左后门",@"右后门",@"左中门",@"右中门",@"左大角",@"右大角",@"后风挡"];
    for (int i = 0; i < array.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10+(10+(self.view.frame.size.width-50)/4)*(i%4), lineView.frame.origin.y+10+35*(i/4), (self.view.frame.size.width-50)/4, 30)];
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        button.layer.cornerRadius = 10;
        button.layer.borderWidth = 1.0;
        button.layer.borderColor = [[UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1.0]CGColor];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.view addSubview:button];
    }
    
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, titleView.frame.origin.y+80+120, self.view.frame.size.width, 2)];
    lineView2.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [self.view addSubview:lineView2];
    
    UIButton *workOverButton = [[UIButton alloc]initWithFrame:CGRectMake(30, self.view.frame.size.height-60, self.view.frame.size.width-60, 50)];
//    workOverButton.center = CGPointMake(self.view.center.x, self.view.center.y+50+36+50);
    [workOverButton setTitle:@"完成工作" forState:UIControlStateNormal];
    workOverButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    workOverButton.layer.cornerRadius = 10;
    
    [workOverButton addTarget:self action:@selector(workOverBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:workOverButton];
    
    
}

- (void)buttonClick:(UIButton *)button{
    
    if ([_buttonArray containsObject:button]) {
        button.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        [button setTitleColor:[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_buttonArray removeObject:button];
    }else{
        
        button.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buttonArray addObject:button];
    }
    
    
}

#pragma mark - 相机按钮的实现方法
- (void)cameraHeadBtnClick:(UIButton *)button{
    [self.view endEditing:YES];
    
    
    _chooseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 80)];
    _chooseView.center = self.view.center;
    _chooseView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    _chooseView.layer.cornerRadius = 15;
    _chooseView.clipsToBounds = YES;
    [self.view addSubview:_chooseView];
    
    // 相机和相册按钮
    UIButton *cameraButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 40)];
    [cameraButton setTitle:@"相册" forState:UIControlStateNormal];
    [cameraButton addTarget:self action:@selector(userHeadChoose:) forControlEvents:UIControlEventTouchUpInside];
    cameraButton.tag = 1;
    [_chooseView addSubview:cameraButton];
    
    UIButton *_photoButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width-100, 40)];
    [_photoButton setTitle:@"相机" forState:UIControlStateNormal];
    [_photoButton addTarget:self action:@selector(userHeadChoose:) forControlEvents:UIControlEventTouchUpInside];
    _photoButton.tag = 2;
    [_chooseView addSubview:_photoButton];
    
    
}
#pragma mark - 选择照片
- (void)userHeadChoose:(UIButton *)button{
    [_chooseView removeFromSuperview];
    
    if (button.tag == 1) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePickerController.allowsEditing = YES;
        imagePickerController.delegate =self;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }else{
        NSLog(@"打开相机");
        BOOL result = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        if (result) {
            NSLog(@"---支持使用相机---");
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            // 编辑模式
            //            imagePicker.allowsEditing = YES;
            [self  presentViewController:imagePicker animated:YES completion:^{
            }];
        }else{
            NSLog(@"----不支持使用相机----");
        }
        
    }
    
    
}

#pragma mark - 图片协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (_imageArray.count == 0) {
        _carImageView.image = image;
        _carImageView.frame = CGRectMake(10, _carImageView.frame.origin.y, (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
        _cameraBtn.frame = CGRectMake(20+(self.view.frame.size.width-40)/3, _carImageView.frame.origin.y, (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
        [_cameraBtn setImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
        _cameraBtn.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    }else{
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(_cameraBtn.frame.origin.x, _cameraBtn.frame.origin.y, (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3)];
        imageView.image = image;
        [self.view addSubview:imageView];
        
        if (_imageArray.count == 5) {
            [_cameraBtn removeFromSuperview];
        }else{
            _cameraBtn.frame = CGRectMake(10+(10+(self.view.frame.size.width-40)/3)*((_imageArray.count+1)%3),  _carImageView.frame.origin.y+(10+(self.view.frame.size.width-40)/3)*((_imageArray.count+1)/3), (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
        }
        
        
    }
    
    [_imageArray addObject:image];
    
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 签到按钮的响应方法
- (void)workOverBtnClick{
    
}

// 添加导航
- (void)setNavigation{
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"person" withLeftImgHightName:@"personClick" withRightImgName:@"moreList" withRightImgHightName:@"moreListClick" withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
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

