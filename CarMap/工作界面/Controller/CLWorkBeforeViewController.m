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
#import "CLHomeOrderViewController.h"
#import "CLHomeOrderCellModel.h"

#import "GFAlertView.h"
#import "GFFangqiViewController.h"

#import "GFImageView.h"
#import "CLTouchView.h"
#import "CLTouchScrollView.h"
#import "HXPhotoPicker.h"


@interface CLWorkBeforeViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,HXAlbumListViewControllerDelegate,UITextViewDelegate>
{
    UIView *_chooseView;
    UIButton *_carImageButton;
    UIButton *_cameraBtn;
    NSMutableArray *_imageArray;
    
    UILabel *_distanceLabel;
    NSTimer *_timer;
    
    GFNavigationView *_navView;
    
    
    UIView *_contentView;
    UITextView *_textView;
}

@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) UIColor *bottomViewBgColor;

@end

@implementation CLWorkBeforeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _imageArray = [[NSMutableArray alloc]init];
    
    [self setNavigation];
    
    [self setDate];
    
    [self titleView];
    
//    [self startTimeForNows];
    
}

// 设置日期和状态
- (void)setDate{
    
    CLTouchScrollView *scrollView = [[CLTouchScrollView alloc]init];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navView.mas_bottom).offset(5);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
    }];
    
    _contentView = [[UIView alloc]init];
    [scrollView addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(scrollView);
        make.edges.equalTo(scrollView);
    }];
    
    
    
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.frame = CGRectMake(10, 8, 200, 20);
    timeLabel.text = [self weekdayString];
    timeLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:timeLabel];
    
    UILabel *stateLabel = [[UILabel alloc] init];
    stateLabel.frame = CGRectMake(self.view.frame.size.width-100, 8, 80, 20);
    stateLabel.text = @"工作模式";
    stateLabel.textAlignment = NSTextAlignmentRight;
    stateLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:stateLabel];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 36, self.view.frame.size.width, 1)];
    view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [headerView addSubview:view];
    
//    NSLog(@"设置日期和时间");
    //    headerView.backgroundColor = [UIColor cyanColor];
    [_contentView addSubview:headerView];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_contentView);
        make.top.equalTo(_contentView);
        make.height.mas_offset(36);
    }];
    
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
//    NSLog(@"---dateString--%@---",dateString);
    
    NSString *timeString = [NSString stringWithFormat:@"%@  %@",dateString,[weekdays objectAtIndex:theComponents.weekday]];
    return timeString;
    
    
    
}


#pragma mark - 获取开始时间计算用时
- (void)startTimeForNows{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_startTime floatValue]/1000];
//    NSLog(@"---date-- %@---",[formatter stringFromDate:date]);
    
    NSInteger time = (NSInteger)[[NSDate date] timeIntervalSince1970] - [_startTime integerValue]/1000;
    
//    NSLog(@"--时间戳-%ld", time);
    
    NSInteger minute = time/60;
    if (minute > 60) {
        
        _distanceLabel.text = [NSString stringWithFormat:@"已用时：%ld时 %ld分",minute/60,minute%60];
    }else{
        
//        NSLog(@"----shezhi时间");
        _distanceLabel.text = [NSString stringWithFormat:@"已用时： %ld分钟",minute];
        
    }
    
    
    if (_timer == nil) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(timeForWork:) userInfo:@{@"time":@(time)} repeats:YES];
    }
    
}

- (void)timeForWork:(NSTimer *)timer{
    
//    NSLog(@"----%@----",timer.userInfo[@"time"]);
    
    static NSInteger a = 0;
    if (a == 0) {
        a = [timer.userInfo[@"time"] integerValue];
        
    }
    a = a + 60;
    NSInteger minute = a/60;
    if (minute > 60) {
        _distanceLabel.text = [NSString stringWithFormat:@"已用时：%ld时 %ld分",minute/60,minute%60];
    }else{
//        NSLog(@"----shezhi时间");
        _distanceLabel.text = [NSString stringWithFormat:@"已用时： %ld分钟",minute];
        
    }
    
}



- (void)titleView{
    
    CLTitleView *titleView = [[CLTitleView alloc]initWithFrame:CGRectMake(0, 64+36, self.view.frame.size.width, 45) Title:@"上传未开始工作车辆照片"];
    [_contentView addSubview:titleView];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_contentView).offset(36);
        make.height.mas_offset(45);
    }];
    
    
    UILabel *photoLabel = [[UILabel alloc] init];
    photoLabel.text = @"不少于3张";
    photoLabel.font = [UIFont systemFontOfSize:16];
    photoLabel.textColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1.0];
    photoLabel.frame = CGRectMake(210, 8, 120, 35);
    [titleView addSubview:photoLabel];
    
    
//    _distanceLabel = [[UILabel alloc] init];
//    _distanceLabel.frame = CGRectMake(0, 101, self.view.frame.size.width, 40);
//    _distanceLabel.text = @"已用时：15分28秒";
//    _distanceLabel.backgroundColor = [UIColor whiteColor];
//    _distanceLabel.font = [UIFont systemFontOfSize:15];
//    _distanceLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:_distanceLabel];
    
    
    
    _carImageButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/7, 150 + 24, self.view.frame.size.width*5/7, self.view.frame.size.width*27/70)];
//    _carImageView.image = [UIImage imageNamed:@"carImage"];
    [_carImageButton setBackgroundImage:[UIImage imageNamed:@"carImage"] forState:UIControlStateNormal];
    [_carImageButton addTarget:self action:@selector(userChoosePhoto) forControlEvents:UIControlEventTouchUpInside];
//    _carImageButton.backgroundColor = [UIColor cyanColor];
    [_contentView addSubview:_carImageButton];
    
    _cameraBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*6/7-15, 150+self.view.frame.size.width*27/70-25 + 24, 30, 30)];
    [_cameraBtn setImage:[UIImage imageNamed:@"cameraUser"] forState:UIControlStateNormal];
    [_cameraBtn addTarget:self action:@selector(userChoosePhoto) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_cameraBtn];
    
    
    
    
    CLTitleView *remarkTitleView = [[CLTitleView alloc]initWithFrame:CGRectMake(0, 64+36, self.view.frame.size.width, 45) Title:@"订单备注"];
    [_contentView addSubview:remarkTitleView];
    
    [remarkTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_cameraBtn.mas_bottom).offset(36);
        make.height.mas_offset(45);
    }];
    
    
//    UIButton *submitRemarkButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [submitRemarkButton setTitle:@"提交" forState:UIControlStateNormal];
//    submitRemarkButton.titleLabel.font = [UIFont systemFontOfSize:15];
//    [submitRemarkButton setTitleColor:[UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1] forState:UIControlStateNormal];
//    [submitRemarkButton addTarget:self action:@selector(submitRemarkBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    submitRemarkButton.layer.cornerRadius = 5;
//    submitRemarkButton.layer.borderWidth = 1;
//    submitRemarkButton.layer.borderColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1].CGColor;
//    [_contentView addSubview:submitRemarkButton];
//    [submitRemarkButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(remarkTitleView);
//        make.right.equalTo(_contentView).offset(-20);
//        make.width.mas_offset(60);
//        make.height.mas_offset(25);
//    }];
    
    _textView = [[UITextView alloc]init];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
    _textView.layer.cornerRadius = 5;
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.text = @"请填写备注（最多300字）";
    _textView.textColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    _textView.delegate = self;
    [_contentView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentView).offset(20);
        make.top.equalTo(remarkTitleView.mas_bottom).offset(20);
        make.right.equalTo(_contentView).offset(-20);
        make.height.mas_offset(100);
    }];
    
    
    
    UIButton *signinButton = [[UIButton alloc]initWithFrame:CGRectMake(30, self.view.frame.size.height-75, self.view.frame.size.width-60, 50)];
//    signinButton.center = CGPointMake(self.view.center.x, self.view.frame.size.height-60);
    [signinButton setTitle:@"继续" forState:UIControlStateNormal];
    signinButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
    signinButton.layer.cornerRadius = 10;
    
    [signinButton addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_contentView addSubview:signinButton];
    
    [signinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentView).offset(30);
        make.top.equalTo(_textView.mas_bottom).offset(80);
        make.right.equalTo(_contentView).offset(-30);
        make.height.mas_offset(50);
        
        make.bottom.equalTo(_contentView).offset(-150);
    }];
    
    
}

#pragma mark - 提交备注
- (void)submitRemarkBtnClick{
    ICLog(@"---提交备注---");
    if(_textView.text.length < 1){
        [self addAlertView:@"请填写订单备注"];
        return;
    }
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
    NSString *remarkString = _textView.text;
    if ([remarkString isEqualToString:@"请填写备注（最多300字）"]){
        remarkString = @"";
    }
    dataDictionary[@"remark"] = remarkString;
    dataDictionary[@"orderId"] = _model.orderId;
//    dataDictionary[@"orderId"] = @"qqq";
//    NSDictionary *dataDictionary = @{@"orderId":[NSString stringWithFormat:@"%@",_model.orderId],@"remark":_textView.text};
    [GFHttpTool postOrderRemarkWithDictionary:dataDictionary Success:^(id responseObject) {
        ICLog(@"responseObject------%@---",responseObject);
        BOOL status = [responseObject[@"status"] boolValue];
        if (status == YES) {
            [self addAlertView:@"操作成功"];
            _textView.text = nil;
        }else{
            [self addAlertView:@"请求失败，请重试"];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}


#pragma mark - 选择照片
- (void)userChoosePhoto{
    
    
    /*
    if (_chooseView == nil) {
        _chooseView = [[CLTouchView alloc]initWithFrame:self.view.bounds];
        _chooseView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
        [self.view addSubview:_chooseView];
        
        UIView *chooseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 80)];
        chooseView.center = self.view.center;
        chooseView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        chooseView.layer.cornerRadius = 15;
        chooseView.clipsToBounds = YES;
        [_chooseView addSubview:chooseView];
        
        // 相机和相册按钮
        UIButton *cameraButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 40)];
        [cameraButton setTitle:@"相册" forState:UIControlStateNormal];
        [cameraButton addTarget:self action:@selector(userHeadChoose:) forControlEvents:UIControlEventTouchUpInside];
        cameraButton.tag = 1;
        [chooseView addSubview:cameraButton];
        
        UIButton *photoButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width-100, 40)];
        [photoButton setTitle:@"相机" forState:UIControlStateNormal];
        [photoButton addTarget:self action:@selector(userHeadChoose:) forControlEvents:UIControlEventTouchUpInside];
        photoButton.tag = 2;
        [chooseView addSubview:photoButton];
    }
    
    
    _chooseView.hidden = NO;
//    [_chooseView bringSubviewToFront:self.view];
    [self.view bringSubviewToFront:_chooseView];
     */
    
    _manager = nil;
    [self directGoPhotoViewController];
    
}

- (void)directGoPhotoViewController {
    HXAlbumListViewController *vc = [[HXAlbumListViewController alloc] init];
    vc.manager = self.manager;
    vc.delegate = self;
    HXCustomNavigationController *nav = [[HXCustomNavigationController alloc] initWithRootViewController:vc];
    nav.supportRotation = self.manager.configuration.supportRotation;
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:nil];
}



- (void)albumListViewController:(HXAlbumListViewController *)albumListViewController didDoneAllImage:(NSArray<UIImage *> *)imageList{
    NSSLog(@"%@",imageList);
    [imageList enumerateObjectsUsingBlock:^(UIImage* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self updataImage:obj];
    }];
}

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _manager.configuration.openCamera = YES;
        _manager.configuration.lookLivePhoto = YES;
        _manager.configuration.photoMaxNum = 9 - _imageArray.count;
        _manager.configuration.videoMaxNum = 1;
        _manager.configuration.maxNum = 10;
        _manager.configuration.videoMaxDuration = 500.f;
        _manager.configuration.saveSystemAblum = NO;
        //        _manager.configuration.reverseDate = YES;
        _manager.configuration.showDateSectionHeader = NO;
        _manager.configuration.selectTogether = NO;
        //        _manager.configuration.rowCount = 3;
        //        _manager.configuration.movableCropBox = YES;
        //        _manager.configuration.movableCropBoxEditSize = YES;
        //        _manager.configuration.movableCropBoxCustomRatio = CGPointMake(1, 1);
        _manager.configuration.requestImageAfterFinishingSelection = YES;
        __weak typeof(self) weakSelf = self;
        //        _manager.configuration.replaceCameraViewController = YES;
        _manager.configuration.shouldUseCamera = ^(UIViewController *viewController, HXPhotoConfigurationCameraType cameraType, HXPhotoManager *manager) {
            
            // 这里拿使用系统相机做例子
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = (id)weakSelf;
            imagePickerController.allowsEditing = NO;
            NSString *requiredMediaTypeImage = ( NSString *)kUTTypeImage;
            NSString *requiredMediaTypeMovie = ( NSString *)kUTTypeMovie;
            NSArray *arrMediaTypes;
            if (cameraType == HXPhotoConfigurationCameraTypePhoto) {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeImage,nil];
            }else if (cameraType == HXPhotoConfigurationCameraTypeVideo) {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeMovie,nil];
            }else {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeImage, requiredMediaTypeMovie,nil];
            }
            [imagePickerController setMediaTypes:arrMediaTypes];
            // 设置录制视频的质量
            [imagePickerController setVideoQuality:UIImagePickerControllerQualityTypeHigh];
            //设置最长摄像时间
            [imagePickerController setVideoMaximumDuration:60.f];
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            imagePickerController.modalPresentationStyle=UIModalPresentationOverCurrentContext;
            [viewController presentViewController:imagePickerController animated:YES completion:nil];
        };
    }
    return _manager;
}







#pragma mark - 选择照片
- (void)userHeadChoose:(UIButton *)button{
    _chooseView.hidden = YES;
    //    _scrollView.userInteractionEnabled = YES;
    if (button.tag == 1) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        //        imagePickerController.allowsEditing = YES;
        imagePickerController.delegate =self;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }else{
        //        NSLog(@"打开相机");
        BOOL result = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        if (result) {
            //            NSLog(@"---支持使用相机---");
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            // 编辑模式
            //            imagePicker.allowsEditing = YES;
            [self  presentViewController:imagePicker animated:YES completion:^{
            }];
        }else{
            //            NSLog(@"----不支持使用相机----");
        }
        
    }
    
    
}


#pragma mark - 图片协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self updataImage:image];
    
}


- (void)updataImage:(UIImage *)image{
    if (_imageArray.count == 0) {
        _carImageButton.hidden = YES;
        //        MYImageView *imageView = [[MYImageView alloc]init];
        GFImageView *imageView = [[GFImageView alloc]init];
        imageView.image = image;
        
        imageView.clipsToBounds = YES;
        
        imageView.frame = CGRectMake(10, _carImageButton.frame.origin.y - 64, (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
        _cameraBtn.frame = CGRectMake(20+(self.view.frame.size.width-40)/3, _carImageButton.frame.origin.y - 64, (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
        [_cameraBtn setImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
        _cameraBtn.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        imageView.userInteractionEnabled = YES;
        UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(imageView.frame.size.width-30, 0, 30, 30)];
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.alpha = 0.5;
        [imageView addSubview:deleteBtn];
        
        imageView.tag = _imageArray.count;
        imageView.imageArray = _imageArray;
        
        [_imageArray addObject:imageView];
        [_contentView addSubview:imageView];
        
    }else{
        //        NSLog(@"小车不存在---%@--",@(_imageArray.count));
        GFImageView *imageView = [[GFImageView alloc]initWithFrame:CGRectMake(_cameraBtn.frame.origin.x, _cameraBtn.frame.origin.y, (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3)];
        imageView.image = image;
        
        imageView.clipsToBounds = YES;
        
        [_contentView addSubview:imageView];
        
        if (_imageArray.count == 8) {
            _cameraBtn.hidden = YES;
        }else{
            _cameraBtn.frame = CGRectMake(10+(10+(self.view.frame.size.width-40)/3)*((_imageArray.count+1)%3),  _carImageButton.frame.origin.y+(10+(self.view.frame.size.width-40)/3)*((_imageArray.count+1)/3) - 64, (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
        }
        
        
        imageView.userInteractionEnabled = YES;
        UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(imageView.frame.size.width-30, 0, 30, 30)];
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.alpha = 0.5;
        [imageView addSubview:deleteBtn];
        imageView.tag = _imageArray.count;
        imageView.imageArray = _imageArray;
        [_imageArray addObject:imageView];
    }
    
    CGSize imagesize;
    if (image.size.width > image.size.height) {
        imagesize.width = 800;
        imagesize.height = image.size.height*800/image.size.width;
    }else{
        imagesize.height = 800;
        imagesize.width = image.size.width*800/image.size.height;
    }
    UIImage *imageNew = [self imageWithImage:image scaledToSize:imagesize];
    NSData *imageData = UIImageJPEGRepresentation(imageNew, 0.8);
    
    
    GFImageView *imageView = [_imageArray objectAtIndex:_imageArray.count-1];
    
    [GFHttpTool PostImageForWork:imageData success:^(NSDictionary *responseObject) {
        //        NSLog(@"上传成功－%@--－%@",responseObject,responseObject[@"message"]);
        if ([responseObject[@"status"] integerValue] == 1) {
            //
            imageView.resultURL = responseObject[@"message"];
        }else{
#warning --图片上传失败，从数组移走图片
            [self addAlertView:@"图片上传失败"];
            _cameraBtn.frame = imageView.frame;
            [_imageArray removeLastObject];
            [imageView removeFromSuperview];
        }
        //
    } failure:^(NSError *error) {
        //        NSLog(@"上传失败原因－－%@--",error);
        [self addAlertView:@"图片上传失败"];
        _cameraBtn.frame = imageView.frame;
        [imageView removeFromSuperview];
        [_imageArray removeLastObject];
        
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
//    NSLog(@"删除照片");
    
    UIImageView *imageView = (UIImageView *)[button superview];
    [imageView removeFromSuperview];
    [_imageArray removeObject:[button superview]];
    imageView = nil;
    
    [_imageArray enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL *stop) {
        obj.tag = idx;
        obj.frame = CGRectMake(10+(10+(self.view.frame.size.width-40)/3)*(idx%3),  _carImageButton.frame.origin.y+(10+(self.view.frame.size.width-40)/3)*(idx/3) - 64, (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
    }];
    
    if (_imageArray.count == 8) {
        _cameraBtn.hidden = NO;
    }else if(_imageArray.count == 0){
        _carImageButton.hidden = NO;
        _cameraBtn.frame = CGRectMake(CGRectGetMaxX(_carImageButton.frame)-15, CGRectGetMaxY(_carImageButton.frame)-20, 30, 30);
        [_cameraBtn setImage:[UIImage imageNamed:@"cameraUser"] forState:UIControlStateNormal];
        _cameraBtn.backgroundColor = [UIColor clearColor];
    }else{
        _cameraBtn.frame = CGRectMake(10+(10+(self.view.frame.size.width-40)/3)*((_imageArray.count)%3),  _carImageButton.frame.origin.y+(10+(self.view.frame.size.width-40)/3)*((_imageArray.count)/3) - 64, (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
    }
    
    
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 继续按钮的响应方法
- (void)nextBtnClick{
    
    if (_imageArray.count > 2) {
        
        __block NSString *URLString;
        [_imageArray enumerateObjectsUsingBlock:^(GFImageView *obj, NSUInteger idx, BOOL * _Nonnull stop) {

            if (idx == 0) {
                URLString = obj.resultURL;
            }else{
                URLString = [NSString stringWithFormat:@"%@,%@",URLString,obj.resultURL];
            }
        }];
        NSString *remarkString = _textView.text;
        if ([remarkString isEqualToString:@"请填写备注（最多300字）"]){
            remarkString = @"";
        }
//        URLString = [NSString stringWithFormat:@"%@&remark=%@", URLString, remarkString];
//        ICLog(@"URLString----%@---", URLString);
        NSDictionary *dataDict = @{@"orderId":@([_orderId integerValue]),@"urls":URLString,@"remark":remarkString};
        ICLog(@"dataDict----%@---", dataDict);
        [GFHttpTool PostPhotoForBeforeParameters: dataDict success:^(NSDictionary *responseObject) {
            
//            NSLog(@"---继续---%@", responseObject);
            
            if ([responseObject[@"status"] integerValue] == 1) {
                
                [_timer invalidate];
                _timer = nil;
                
                if([_startTime isEqualToString:@"未开始"]) {
                
                    _startTime = [NSString stringWithFormat:@"%ld", (NSInteger)[[NSDate date] timeIntervalSince1970] * 1000];
                }
                
//                if ([_orderType integerValue] == 4) {
//                    
//                    CLCleanWorkViewController *cleanWork = [[CLCleanWorkViewController alloc]init];
//                    cleanWork.orderId = _orderId;
//                    cleanWork.startTime = _startTime;
//                    cleanWork.orderNumber = self.orderNumber;
//                    [self.navigationController pushViewController:cleanWork animated:YES];
//                }else{
                CLWorkOverViewController *workOver = [[CLWorkOverViewController alloc]init];
                workOver.orderId = _orderId;
                workOver.orderType = _orderType;
                workOver.startTime = _startTime;
                workOver.orderNumber = self.orderNumber;
                _model.technicianRemark = remarkString;
                workOver.model = _model;
                [self.navigationController pushViewController:workOver animated:YES];
//                }
            }else{
//                responseObject[@"message"]
                [self addAlertView:responseObject[@"message"]];
            }
        } failure:^(NSError *error) {
            
        }];
        
        }else{
        [self addAlertView:@"至少上传三张照片"];
    }
}



#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}

// 添加导航
- (void)setNavigation{
    
    _navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:@"person" withRightImgHightName:@"personClick" withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [_navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView.rightBut addTarget:_navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *removeOrderButton = [[UIButton alloc]init];
    removeOrderButton.titleLabel.font = [UIFont systemFontOfSize:16];
    //    removeOrderButton.backgroundColor = [UIColor grayColor];
//    removeOrderButton.layer.borderColor = [[UIColor whiteColor] CGColor];
//    removeOrderButton.layer.borderWidth = 1;
//    removeOrderButton.layer.cornerRadius = 20;
    [removeOrderButton setTitle:@"改派" forState:UIControlStateNormal];
    if([_model.status isEqualToString:@"IN_PROGRESS"] || [_model.status isEqualToString:@"SIGNED_IN"] || [_model.status isEqualToString:@"AT_WORK"]) {
        
        [removeOrderButton setTitle:@"改派" forState:UIControlStateNormal];
    }
    [removeOrderButton setTitleColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [removeOrderButton addTarget:self action:@selector(removeOrderBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:removeOrderButton];
    
    
    [removeOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_navView).offset(-4);
        make.right.equalTo(_navView).offset(-45);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
    }];
    
    [self.view addSubview:_navView];
}

#pragma mark - textView的协议方法
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@"请填写备注（最多300字）"]) {
        textView.text = nil;
        textView.textColor = [UIColor blackColor];
    }
    
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        textView.text = @"请填写备注（最多300字）";
        textView.textColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    }
    
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (textView.text.length > 300 && range.length==0) {
        return NO;
    }else{
        return YES;
    }
}
#pragma mark - 弃单提示和请求
- (void)removeOrderBtnClick{
    GFAlertView *alertView = [[GFAlertView alloc]initWithTitle:@"确认要放弃此单吗？" leftBtn:@"取消" rightBtn:@"确定"];
    [alertView.rightButton addTarget:self action:@selector(removeOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alertView];
}
- (void)removeOrder{
    //    NSLog(@"确认放弃订单，订单ID为 －－%@--- ",_orderId);
    
    GFFangqiViewController *vc = [[GFFangqiViewController alloc] init];
    vc.model = _model;
    [self.navigationController pushViewController:vc animated:YES];
    
    /*
     [GFHttpTool postCancelOrder:_model.orderId Success:^(id responseObject) {
     
     NSLog(@"--放弃订单--%@", responseObject);
     if ([responseObject[@"status"] integerValue] == 1) {
     
     [GFTipView tipViewWithNormalHeightWithMessage:@"弃单成功" withShowTimw:1.5];
     [self performSelector:@selector(removeOrderSuccess) withObject:nil afterDelay:1.5];
     }else{
     
     [GFTipView tipViewWithNormalHeightWithMessage:responseObject[@"message"] withShowTimw:1.5];
     
     }
     
     } failure:^(NSError *error) {
     
     //       NSLog(@"放弃订单失败----%@---",error);
     
     }];
     */
    
}

- (void)removeOrderSuccess{
    CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
    [homeOrder headRefresh];
    [self.navigationController popToRootViewControllerAnimated:YES];
}



- (void)backBtnClick{
    
    [_timer invalidate];
    _timer = nil;
    CLHomeOrderViewController *homeOrder = self.navigationController.viewControllers[0];
    [homeOrder headRefresh];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
//    GFMyMessageViewController *myMessage = [[GFMyMessageViewController alloc]init];
//    [self.navigationController pushViewController:myMessage animated:YES];
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
