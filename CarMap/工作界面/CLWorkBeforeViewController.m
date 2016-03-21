//
//  WorkBeforeViewController.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/19.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLWorkBeforeViewController.h"
#import "GFNavigationView.h"
#import "CLTitleView.h"
#import "CLWorkOverViewController.h"
#import "GFMyMessageViewController.h"
#import "GFHttpTool.h"
#import "GFTipView.h"
#import "MYImageView.h"
#import "CLCleanWorkViewController.h"








@interface CLWorkBeforeViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIView *_chooseView;
    UIButton *_carImageButton;
    UIButton *_cameraBtn;
    NSMutableArray *_imageArray;
    
    UILabel *_distanceLabel;
    NSTimer *_timer;
    
}


@end

@implementation CLWorkBeforeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _imageArray = [[NSMutableArray alloc]init];
    
    [self setDate];
    
    [self setNavigation];
    
    [self titleView];
    
    [self startTimeForNows];
    
}

// 设置日期和状态
- (void)setDate{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 36)];
    headerView.backgroundColor = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, 200, 20)];
    timeLabel.text = [self weekdayString];
    timeLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:timeLabel];
    
    UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-100, 8, 80, 20)];
    stateLabel.text = @"工作模式";
    stateLabel.textAlignment = NSTextAlignmentRight;
    stateLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:stateLabel];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 36, self.view.frame.size.width, 1)];
    view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
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


#pragma mark - 获取开始时间计算用时
- (void)startTimeForNows{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_startTime integerValue]/1000];
    NSLog(@"---date-- %@---",[formatter stringFromDate:date]);
    
    NSInteger time = (NSInteger)[[NSDate date] timeIntervalSince1970] - [_startTime integerValue]/1000;
    
    
    NSInteger minute = time/60;
    if (minute > 60) {
        _distanceLabel.text = [NSString stringWithFormat:@"已用时：%ld时 %ld分",minute/60,minute%60];
    }else{
        NSLog(@"----shezhi时间");
        _distanceLabel.text = [NSString stringWithFormat:@"已用时： %ld分钟",minute];
        
    }
    
    
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(timeForWork:) userInfo:@{@"time":@(time)} repeats:YES];
    }
    
}

- (void)timeForWork:(NSTimer *)timer{
    
    static NSInteger a = 0;
    if (a == 0) {
        a = [timer.userInfo[@"time"] integerValue];
        
    }
    a = a + 60;
    NSInteger minute = a/60;
    if (minute > 60) {
        _distanceLabel.text = [NSString stringWithFormat:@"已用时：%ld时 %ld分",minute/60,minute%60];
    }else{
        NSLog(@"----shezhi时间");
        _distanceLabel.text = [NSString stringWithFormat:@"已用时： %ld分钟",minute];
        
    }
    
}



- (void)titleView{
    
    CLTitleView *titleView = [[CLTitleView alloc]initWithFrame:CGRectMake(0, 64+36+40, self.view.frame.size.width, 45) Title:@"上传未开始工作车辆照片"];
    [self.view addSubview:titleView];
    
    
    
    _distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 101, self.view.frame.size.width, 40)];
    _distanceLabel.text = @"已用时：15分28秒";
    _distanceLabel.backgroundColor = [UIColor whiteColor];
    _distanceLabel.font = [UIFont systemFontOfSize:15];
    _distanceLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_distanceLabel];
    
    
    
    _carImageButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/7, 200, self.view.frame.size.width*5/7, self.view.frame.size.width*27/70)];
//    _carImageView.image = [UIImage imageNamed:@"carImage"];
    [_carImageButton setBackgroundImage:[UIImage imageNamed:@"carImage"] forState:UIControlStateNormal];
    [_carImageButton addTarget:self action:@selector(userHeadChoose:) forControlEvents:UIControlEventTouchUpInside];
//    _carImageButton.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_carImageButton];
    
    _cameraBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*6/7-15, 200+self.view.frame.size.width*27/70-25, 30, 30)];
    [_cameraBtn setImage:[UIImage imageNamed:@"cameraUser"] forState:UIControlStateNormal];
    [_cameraBtn addTarget:self action:@selector(userHeadChoose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cameraBtn];
    
    
    
    
    UIButton *signinButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-60, 50)];
    signinButton.center = CGPointMake(self.view.center.x, self.view.center.y+50+36+50);
    [signinButton setTitle:@"继续" forState:UIControlStateNormal];
    signinButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    signinButton.layer.cornerRadius = 10;
    
    [signinButton addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:signinButton];
    
    
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
//    [_chooseView removeFromSuperview];
//    
//    if (button.tag == 1) {
//        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
//        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//        imagePickerController.allowsEditing = YES;
//        imagePickerController.delegate =self;
//        [self presentViewController:imagePickerController animated:YES completion:nil];
//    }else{
        NSLog(@"打开相机");
        BOOL result = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        if (result) {
            NSLog(@"---支持使用相机---");
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            // 编辑模式
            //            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:^{
            }];
        }else{
            NSLog(@"----不支持使用相机----");
        }
        
//    }
    
    
}

#pragma mark - 图片协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (_imageArray.count == 0) {
        _carImageButton.hidden = YES;
        MYImageView *imageView = [[MYImageView alloc]init];
        imageView.image = image;
        imageView.frame = CGRectMake(10, _carImageButton.frame.origin.y, (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
        _cameraBtn.frame = CGRectMake(20+(self.view.frame.size.width-40)/3, _carImageButton.frame.origin.y, (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
        [_cameraBtn setImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
        _cameraBtn.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        imageView.userInteractionEnabled = YES;
        UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(imageView.frame.size.width-30, 0, 30, 30)];
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:deleteBtn];
        [_imageArray addObject:imageView];
        [self.view addSubview:imageView];
        
    }else{
        NSLog(@"小车不存在---%@--",@(_imageArray.count));
        MYImageView *imageView = [[MYImageView alloc]initWithFrame:CGRectMake(_cameraBtn.frame.origin.x, _cameraBtn.frame.origin.y, (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3)];
        imageView.image = image;
        [self.view addSubview:imageView];
        
        if (_imageArray.count == 2) {
            _cameraBtn.hidden = YES;
        }else{
            _cameraBtn.frame = CGRectMake(10+(10+(self.view.frame.size.width-40)/3)*((_imageArray.count+1)%3),  _carImageButton.frame.origin.y+(10+(self.view.frame.size.width-40)/3)*((_imageArray.count+1)/3), (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
        }
        
        
        imageView.userInteractionEnabled = YES;
        UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(imageView.frame.size.width-30, 0, 30, 30)];
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:deleteBtn];
        [_imageArray addObject:imageView];
    }
    
    CGSize imagesize;
    imagesize.width = image.size.width/2;
    imagesize.height = image.size.height/2;
    UIImage *imageNew = [self imageWithImage:image scaledToSize:imagesize];
    NSData *imageData = UIImageJPEGRepresentation(imageNew, 0.1);
    MYImageView *imageView = [_imageArray objectAtIndex:_imageArray.count-1];
    [GFHttpTool PostImageForWork:imageData success:^(NSDictionary *responseObject) {
        NSLog(@"上传成功－%@--－%@",responseObject,responseObject[@"message"]);
        if ([responseObject[@"result"] integerValue] == 1) {
           
            imageView.resultURL = responseObject[@"data"];
        }else{
#warning --图片上传失败，从数组移走图片
            
        }

    } failure:^(NSError *error) {
        NSLog(@"上传失败原因－－%@--",error);
    }];
    
}

#pragma mark - 压缩图片尺寸
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}



#pragma mark - 删除相片的方法
- (void)deleteBtnClick:(UIButton *)button{
    NSLog(@"删除照片");
    
    UIImageView *imageView = (UIImageView *)[button superview];
    [imageView removeFromSuperview];
    [_imageArray removeObject:[button superview]];
    imageView = nil;
    
    [_imageArray enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL *stop) {
        
        obj.frame = CGRectMake(10+(10+(self.view.frame.size.width-40)/3)*(idx%3),  _carImageButton.frame.origin.y+(10+(self.view.frame.size.width-40)/3)*(idx/3), (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
    }];
    
    if (_imageArray.count == 2) {
        _cameraBtn.hidden = NO;
    }else if(_imageArray.count == 1){
        _cameraBtn.frame = CGRectMake(10+(10+(self.view.frame.size.width-40)/3)*((_imageArray.count)%3),  _carImageButton.frame.origin.y+(10+(self.view.frame.size.width-40)/3)*((_imageArray.count)/3), (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
    }else{
        _carImageButton.hidden = NO;
        _cameraBtn.frame = CGRectMake(self.view.frame.size.width*6/7-15, 200+self.view.frame.size.width*27/70-25, 30, 30);
        [_cameraBtn setImage:[UIImage imageNamed:@"cameraUser"] forState:UIControlStateNormal];
        _cameraBtn.backgroundColor = [UIColor clearColor];
    }
    
    
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 继续按钮的响应方法
- (void)nextBtnClick{
    
    if (_imageArray.count > 0) {
        
        __block NSString *URLString;
        [_imageArray enumerateObjectsUsingBlock:^(MYImageView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"imageURL---%@--",obj.resultURL);
            if (idx == 0) {
                URLString = obj.resultURL;
            }else{
                URLString = [NSString stringWithFormat:@"%@,%@",URLString,obj.resultURL];
            }
        }];
        
        
        [GFHttpTool PostPhotoForBeforeOrderId:[_orderId integerValue] URLs:URLString success:^(NSDictionary *responseObject) {
            if ([responseObject[@"result"] integerValue] == 1) {
                
//                CLWorkOverViewController *workOver = [[CLWorkOverViewController alloc]init];
//                workOver.orderId = _orderId;
//                workOver.orderType = _orderType;
//                [self.navigationController pushViewController:workOver animated:YES];
                
                [_timer invalidate];
                _timer = nil;
                
                if ([_orderType integerValue] == 4) {
                    
                    CLCleanWorkViewController *cleanWork = [[CLCleanWorkViewController alloc]init];
                    cleanWork.orderId = _orderId;
                    cleanWork.startTime = _startTime;
//                    [self.navigationController pushViewController:cleanWork animated:YES];
                    cleanWork.orderNumber = self.orderNumber;
                    UIWindow *window = [UIApplication sharedApplication].keyWindow;
                    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:cleanWork];
                    navigation.navigationBarHidden = YES;
                    window.rootViewController = navigation;
                    
                    
                    
                }else{
                    CLWorkOverViewController *workOver = [[CLWorkOverViewController alloc]init];
                    workOver.orderId = _orderId;
                    workOver.orderType = _orderType;
                    workOver.startTime = _startTime;
                    workOver.orderNumber = self.orderNumber;
                    UIWindow *window = [UIApplication sharedApplication].keyWindow;
                    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:workOver];
                    navigation.navigationBarHidden = YES;
                    window.rootViewController = navigation;
                    
                    
//                    [self.navigationController pushViewController:workOver animated:YES];
                }
                
                
                
            }
        } failure:^(NSError *error) {
            NSLog(@"－－－失败了--%@",error);
            [self addAlertView:@"提交失败"];
        }];
        
        
        
        
        
        
        }else{
        [self addAlertView:@"至少上传一张照片照片"];
    }
    
    
    
    
    
}



#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}

// 添加导航
- (void)setNavigation{
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"person" withLeftImgHightName:@"personClick" withRightImgName:@"moreList" withRightImgHightName:@"moreListClick" withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:navView];
    
    
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
