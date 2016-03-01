//
//  CLCleanWorkViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/3/1.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLCleanWorkViewController.h"
#import "GFNavigationView.h"
#import "CLTitleView.h"
#import "GFMyMessageViewController.h"


@interface CLCleanWorkViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIImageView *_carImageView;
    UIButton *_cameraBtn;
    NSMutableArray *_imageArray;
    
    UIScrollView *_scrollView;
    UITextField *_workTextField;
    
}

@end

@implementation CLCleanWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageArray = [[NSMutableArray alloc]init];

    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = CGRectMake(0, 64+36, self.view.frame.size.width, self.view.frame.size.height-64-38);
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 700);
    [self.view addSubview:_scrollView];
    
    
    
    
    
    
    [self setDate];
    
    [self setNavigation];
    
    [self titleView];
    
}

#pragma mark - 设置日期和状态
- (void)setDate{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 36)];
    headerView.backgroundColor = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, 200, 20)];
    timeLabel.text = [self weekdayString];
    timeLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:timeLabel];
    
    UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-120, 8, 100, 20)];
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
    
    UILabel *distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 1, self.view.frame.size.width, 40)];
    distanceLabel.text = @"已用时：15分28秒";
    distanceLabel.backgroundColor = [UIColor whiteColor];
    distanceLabel.font = [UIFont systemFontOfSize:15];
    distanceLabel.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:distanceLabel];
    
    _carImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/7, 55, self.view.frame.size.width*5/7, self.view.frame.size.width*27/70)];
    _carImageView.image = [UIImage imageNamed:@"carImage"];
    [_scrollView addSubview:_carImageView];
    
    _cameraBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*6/7-15, 55+self.view.frame.size.width*27/70-25, 30, 30)];
    [_cameraBtn setImage:[UIImage imageNamed:@"cameraUser"] forState:UIControlStateNormal];
    [_cameraBtn addTarget:self action:@selector(userHeadChoose:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_cameraBtn];
    
    CLTitleView *titleView = [[CLTitleView alloc]initWithFrame:CGRectMake(0, 40 + self.view.frame.size.width/3*2+10, self.view.frame.size.width, 45) Title:@"选择本次负责的工作项"];
    [_scrollView addSubview:titleView];
    
    
    
    
    _workTextField = [[UITextField alloc]initWithFrame:CGRectMake(80, titleView.frame.origin.y+60, self.view.frame.size.width-160, 40)];
    _workTextField.textAlignment = NSTextAlignmentCenter;
    _workTextField.layer.borderWidth = 0.5f;
    _workTextField.keyboardType = UIKeyboardTypeNumberPad;
    _workTextField.layer.borderColor = [[UIColor colorWithRed:174/255.0 green:174/255.0 blue:174/255.0 alpha:1.0]CGColor];
    [_scrollView addSubview:_workTextField];
    
// 加减按钮
    UIButton *subtractButton = [[UIButton alloc]initWithFrame:CGRectMake(40, _workTextField.frame.origin.y, 40, 40)];
    [subtractButton setImage:[UIImage imageNamed:@"subtract"] forState:UIControlStateNormal];
    subtractButton.tag = 1;
    [subtractButton addTarget:self action:@selector(workBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:subtractButton];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, _workTextField.frame.origin.y, 40, 40)];
    addButton.tag = 2;
    [addButton addTarget:self action:@selector(workBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [_scrollView addSubview:addButton];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80, addButton.frame.origin.y + 40, self.view.frame.size.width-160, 30)];
    label.text = @"按百分比计算(%)";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14.0];
    label.textColor = [UIColor colorWithRed:174/255.0 green:174/255.0 blue:174/255.0 alpha:1.0];
    [_scrollView addSubview:label];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, label.frame.origin.y+35, self.view.frame.size.width-20, 1)];
    lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:lineView];
    
    
    UIButton *workOverButton = [[UIButton alloc]initWithFrame:CGRectMake(30, lineView.frame.origin.y+30, self.view.frame.size.width-60, 50)];
    //    workOverButton.center = CGPointMake(self.view.center.x, self.view.center.y+50+36+50);
    [workOverButton setTitle:@"完成工作" forState:UIControlStateNormal];
    workOverButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    workOverButton.layer.cornerRadius = 10;
    
    [workOverButton addTarget:self action:@selector(workOverBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:workOverButton];
    
    
}

- (void)workBtnClick:(UIButton *)button{
    if (button.tag == 1 && [_workTextField.text integerValue]>=10) {
        _workTextField.text = [NSString stringWithFormat:@"%ld",[_workTextField.text integerValue]-10];
    }else if(button.tag == 2 && [_workTextField.text integerValue]<=90){
        _workTextField.text = [NSString stringWithFormat:@"%ld",[_workTextField.text integerValue]+10];
    }
    
    
}

#pragma mark - 选择照片
- (void)userHeadChoose:(UIButton *)button{
    
    NSLog(@"打开相机");
    BOOL result = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (result) {
        NSLog(@"---支持使用相机---");
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        
        [self  presentViewController:imagePicker animated:YES completion:^{
        }];
    }else{
        NSLog(@"----不支持使用相机----");
    }
    
}

#pragma mark - 图片协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (_imageArray.count == 0) {
        _carImageView.hidden = YES;
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = image;
        imageView.frame = CGRectMake(10, _carImageView.frame.origin.y, (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
        _cameraBtn.frame = CGRectMake(20+(self.view.frame.size.width-40)/3, _carImageView.frame.origin.y, (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
        [_cameraBtn setImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
        _cameraBtn.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        imageView.userInteractionEnabled = YES;
        UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(imageView.frame.size.width-30, 0, 30, 30)];
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:deleteBtn];
        [_imageArray addObject:imageView];
        [_scrollView addSubview:imageView];
        
    }else{
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(_cameraBtn.frame.origin.x, _cameraBtn.frame.origin.y, (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3)];
        imageView.image = image;
        [_scrollView addSubview:imageView];
        
        if (_imageArray.count == 5) {
            _cameraBtn.hidden = YES;
        }else{
            _cameraBtn.frame = CGRectMake(10+(10+(self.view.frame.size.width-40)/3)*((_imageArray.count+1)%3),  _carImageView.frame.origin.y+(10+(self.view.frame.size.width-40)/3)*((_imageArray.count+1)/3), (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
        }
        
        
        imageView.userInteractionEnabled = YES;
        UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(imageView.frame.size.width-30, 0, 30, 30)];
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:deleteBtn];
        [_imageArray addObject:imageView];
    }
    
    
}
#pragma mark - 删除相片的方法
- (void)deleteBtnClick:(UIButton *)button{
    NSLog(@"删除照片");
    
    UIImageView *imageView = (UIImageView *)[button superview];
    [imageView removeFromSuperview];
    [_imageArray removeObject:[button superview]];
    imageView = nil;
    
    [_imageArray enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL *stop) {
        
        obj.frame = CGRectMake(10+(10+(self.view.frame.size.width-40)/3)*(idx%3),  _carImageView.frame.origin.y+(10+(self.view.frame.size.width-40)/3)*(idx/3), (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
    }];
    
    if (_imageArray.count == 5) {
        _cameraBtn.hidden = NO;
    }else{
        _cameraBtn.frame = CGRectMake(10+(10+(self.view.frame.size.width-40)/3)*((_imageArray.count)%3),  _carImageView.frame.origin.y+(10+(self.view.frame.size.width-40)/3)*((_imageArray.count)/3), (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
    }
    
    
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}


// 添加导航
- (void)setNavigation{
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"person" withLeftImgHightName:@"personClick" withRightImgName:@"moreList" withRightImgHightName:@"moreListClick" withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:navView];
    
    
}

#pragma mark - 工作完成的按钮响应方法
- (void)workOverBtnClick{
    
}

- (void)backBtnClick{
    //    [self.navigationController popViewControllerAnimated:YES];
    GFMyMessageViewController *myMessage = [[GFMyMessageViewController alloc]init];
    [self.navigationController pushViewController:myMessage animated:YES];
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
