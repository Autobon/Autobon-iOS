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
#import "GFMyMessageViewController.h"
#import "CLShareViewController.h"
#import "GFHttpTool.h"
#import "MYImageView.h"
#import "GFTipView.h"




@interface CLWorkOverViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UIView *_chooseView;
    UIButton *_carImageButton;
    UIButton *_cameraBtn;
    NSMutableArray *_imageArray;
    NSMutableArray *_buttonArray;
    NSArray *_workItemarray;
//    NSMutableArray *_workItemBtnArray;
    NSMutableArray *_workItemIdArray;
    UIScrollView *_scrollView;
    NSMutableArray *_fiveItemArray;
    NSMutableArray *_fiveItemIdArray;
    NSMutableArray *_sevenItemArray;
    NSMutableArray *_sevenItemIdArray;
    UICollectionView *_collectionView;
    
    UILabel *_distanceLabel;
    
    NSTimer *_timer;
    
}


@end

@implementation CLWorkOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _imageArray = [[NSMutableArray alloc]init];
    _buttonArray = [[NSMutableArray alloc]init];
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = CGRectMake(0, 64+36, self.view.frame.size.width, self.view.frame.size.height-64-38);
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 700);
    [self.view addSubview:_scrollView];
    
    
    
    
    
    
    [self setDate];
    
    [self setNavigation];
    
    [self titleView];
    
    
    [self startTimeForNows];
    
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


#pragma mark - 获取开始时间计算用时
- (void)startTimeForNows{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_startTime floatValue]/1000];
    NSInteger time = (NSInteger)[[NSDate date] timeIntervalSince1970] - [_startTime floatValue]/1000;
    
    
        NSInteger minute = time/60;
        if (minute > 60) {
            _distanceLabel.text = [NSString stringWithFormat:@"已用时：%d时 %d分",minute/60,minute%60];
        }else{
            NSLog(@"----shezhi时间");
            _distanceLabel.text = [NSString stringWithFormat:@"已用时： %ld分钟",(long)minute];
            
        }
    
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(timeForWork:) userInfo:@{@"time":@(time)} repeats:YES];
    }
    
}

- (void)timeForWork:(NSTimer *)timer{
    
    NSLog(@"----%@----",timer.userInfo[@"time"]);
    
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
    
    NSLog(@"－1457600262000－－已用时－－%@--",_startTime);
    
    _distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, -10, self.view.frame.size.width, 20)];
//    _distanceLabel.text = @"已用时：15分28秒";
    _distanceLabel.backgroundColor = [UIColor whiteColor];
    _distanceLabel.font = [UIFont systemFontOfSize:15];
    _distanceLabel.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:_distanceLabel];
    
    CLTitleView *photoTitle = [[CLTitleView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_distanceLabel.frame)+10, self.view.frame.size.width, 45) Title:@"上传工作完成车辆照片"];
    UILabel *photoLabel = [[UILabel alloc]init];
    photoLabel.text = @"不少于3张";
    photoLabel.font = [UIFont systemFontOfSize:16];
    photoLabel.textColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1.0];
    photoLabel.frame = CGRectMake(190, 8, 120, 35);
    [photoTitle addSubview:photoLabel];
    
    [_scrollView addSubview:photoTitle];
    
    
    _carImageButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/7, CGRectGetMaxY(photoTitle.frame)+10, self.view.frame.size.width*5/7, self.view.frame.size.width*27/70)];
//    _carImageView.image = [UIImage imageNamed:@"carImage"];
    [_carImageButton setBackgroundImage:[UIImage imageNamed:@"carImage"] forState:UIControlStateNormal];
    [_carImageButton addTarget:self action:@selector(userHeadChoose:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_carImageButton];
    
    _cameraBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_carImageButton.frame)-15, CGRectGetMaxY(_carImageButton.frame)-20, 30, 30)];
    [_cameraBtn setImage:[UIImage imageNamed:@"cameraUser"] forState:UIControlStateNormal];
    [_cameraBtn addTarget:self action:@selector(userHeadChoose:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_cameraBtn];
    
    
    
    
    CLTitleView *titleView = [[CLTitleView alloc]initWithFrame:CGRectMake(0, 40 + self.view.frame.size.width/3*2+30, self.view.frame.size.width, 45) Title:@"选择本次负责的工作项"];
    [_scrollView addSubview:titleView];
    

    UIButton *fiveButton = [[UIButton alloc]initWithFrame:CGRectMake(10, titleView.frame.origin.y+50, 100, 30)];
//    fiveButton.backgroundColor = [UIColor cyanColor];
    [fiveButton setTitle:@"五座车" forState:UIControlStateNormal];
    [fiveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    fiveButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [fiveButton setImage:[UIImage imageNamed:@"overClick"] forState:UIControlStateNormal];
    [fiveButton addTarget:self action:@selector(workItemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    fiveButton.tag = 5;
    [_scrollView addSubview:fiveButton];
    
    UIButton *sevenButton = [[UIButton alloc]initWithFrame:CGRectMake(130, titleView.frame.origin.y+50, 100, 30)];
//    sevenButton.backgroundColor = [UIColor cyanColor];
    [sevenButton setTitle:@"七座车" forState:UIControlStateNormal];
    [sevenButton setImage:[UIImage imageNamed:@"over"] forState:UIControlStateNormal];
    sevenButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [sevenButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sevenButton addTarget:self action:@selector(workItemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    sevenButton.tag = 7;
    [_scrollView addSubview:sevenButton];
    
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, titleView.frame.origin.y+80, self.view.frame.size.width-20, 1)];
    lineView.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    [_scrollView addSubview:lineView];
    
    
//    _workItenIdArray = [[NSMutableArray alloc]init];
    
//    _workItemarray = @[@"前风挡",@"左前门",@"右前门",@"左后门",@"右后门",@"左中门",@"右中门",@"左大角",@"右大角",@"后风挡"];
//    _workItemarray = @[@"前保险杠",@"左前翼子板",@"右前翼子板",@"左前门",@"右前门",@"左中门",@"右中门",@"左后门",@"右后门",@"左后翼子板",@"右后翼子板",@"左底边",@"右底边",@"引擎盖",@"后背箱盖",@"后保险杠",@"车顶",@"左后视镜",@"右后视镜"];
    _fiveItemArray = [[NSMutableArray alloc]init];
    _sevenItemArray = [[NSMutableArray alloc]init];
    _fiveItemIdArray = [[NSMutableArray alloc]init];
    _sevenItemIdArray = [[NSMutableArray alloc]init];
    
    [GFHttpTool GetWorkItemsOrderTypeId:[_orderType integerValue] success:^(NSDictionary *responseObject) {
        NSLog(@"－－－%@---",responseObject);
        NSArray *dataArray = responseObject[@"data"];
        [dataArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            if ([obj[@"seat"]integerValue] == 5) {
                [_fiveItemArray addObject:obj[@"name"]];
                [_fiveItemIdArray addObject:obj[@"id"]];
            }else{
                [_sevenItemArray addObject:obj[@"name"]];
                [_sevenItemIdArray addObject:obj[@"id"]];
            }
        }];
        
        _workItemarray = _fiveItemArray;
        _workItemIdArray = _fiveItemIdArray;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((self.view.frame.size.width-50)/4, 30);
        layout.minimumInteritemSpacing = 5.0f;
        layout.minimumLineSpacing = 5.0f;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, lineView.frame.origin.y + 5, self.view.frame.size.width , ((_workItemarray.count+1)/4 + 1)*35+10) collectionViewLayout:layout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_scrollView addSubview:_collectionView];
        
        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(10, _collectionView.frame.origin.y+_collectionView.frame.size.height+10, self.view.frame.size.width-20, 1)];
        lineView2.backgroundColor = [[UIColor alloc]initWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
        [_scrollView addSubview:lineView2];
        
        UIButton *workOverButton = [[UIButton alloc]initWithFrame:CGRectMake(30, lineView2.frame.origin.y+30, self.view.frame.size.width-60, 50)];
        //    workOverButton.center = CGPointMake(self.view.center.x, self.view.center.y+50+36+50);
        [workOverButton setTitle:@"完成工作" forState:UIControlStateNormal];
        workOverButton.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        workOverButton.layer.cornerRadius = 10;
        
        [workOverButton addTarget:self action:@selector(workOverBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [_scrollView addSubview:workOverButton];
        
        
    } failure:^(NSError *error) {
        NSLog(@"失败了－－－%@---",error);
    }];
    
//

    
    
    
    
    
    
    
}


#pragma mark - UICollectionViewDataSource
//返回当前区有多少 item。每一个单独的元素就是一个 item。
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _workItemarray.count;
}

//配置每个 item。

- (UICollectionViewCell* )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
   
    
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 10;
    cell.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    cell.layer.borderWidth = 1.0;
    cell.layer.borderColor = [[UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1.0]CGColor];

    
    UILabel* label = (UILabel *)[cell viewWithTag:5];
    if(!label){
        label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
        label.tag = 5;
    }
    
    label.text = _workItemarray[indexPath.row];
    label.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0];
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:label];
    return cell;
}

#pragma mark - UICollectionViewDelegate

//选中某个 item。
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell viewWithTag:5];
    if ([_buttonArray containsObject:_workItemIdArray[indexPath.row]]) {
        cell.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        label.textColor = [UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1.0];
        cell.layer.borderColor = [[UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1.0]CGColor];
        [_buttonArray removeObject:_workItemIdArray[indexPath.row]];
    }else{
        
        cell.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        label.textColor = [UIColor whiteColor];
        cell.layer.borderColor = [[UIColor clearColor]CGColor];
        [_buttonArray addObject:_workItemIdArray[indexPath.row]];
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
            [self  presentViewController:imagePicker animated:YES completion:^{
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
        [_scrollView addSubview:imageView];
        
    }else{
        NSLog(@"小车不存在---%@--",@(_imageArray.count));
        MYImageView *imageView = [[MYImageView alloc]initWithFrame:CGRectMake(_cameraBtn.frame.origin.x, _cameraBtn.frame.origin.y, (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3)];
        imageView.image = image;
        [_scrollView addSubview:imageView];
        
        if (_imageArray.count == 5) {
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
    if (image.size.width > image.size.height) {
        imagesize.width = 800;
        imagesize.height = image.size.height*800/image.size.width;
    }else{
        imagesize.height = 800;
        imagesize.width = image.size.width*800/image.size.height;
    }
    UIImage *imageNew = [self imageWithImage:image scaledToSize:imagesize];
    NSData *imageData = UIImageJPEGRepresentation(imageNew, 0.8);
    [GFHttpTool PostImageForWork:imageData success:^(NSDictionary *responseObject) {
        NSLog(@"上传成功－%@--－%@",responseObject,responseObject[@"message"]);
        if ([responseObject[@"result"] integerValue] == 1) {
            MYImageView *imageView = [_imageArray objectAtIndex:_imageArray.count-1];
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
    
    if (_imageArray.count == 5) {
        _cameraBtn.hidden = NO;
    }else if (_imageArray.count == 0){
        _carImageButton.hidden = NO;
        _cameraBtn.frame = CGRectMake(CGRectGetMaxX(_carImageButton.frame)-15, CGRectGetMaxY(_carImageButton.frame)-20, 30, 30);
        [_cameraBtn setImage:[UIImage imageNamed:@"cameraUser"] forState:UIControlStateNormal];
        _cameraBtn.backgroundColor = [UIColor clearColor];
    }else{
        _cameraBtn.frame = CGRectMake(10+(10+(self.view.frame.size.width-40)/3)*((_imageArray.count)%3),  _carImageButton.frame.origin.y+(10+(self.view.frame.size.width-40)/3)*((_imageArray.count)/3), (self.view.frame.size.width-40)/3, (self.view.frame.size.width-40)/3);
    }
    
    
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 五座车七座车按钮
- (void)workItemBtnClick:(UIButton *)button{
    
    
    [_buttonArray removeAllObjects];
    if (button.tag == 5) {
        [button setImage:[UIImage imageNamed:@"overClick"] forState:UIControlStateNormal];
        UIButton *severBtn = (UIButton *)[self.view viewWithTag:7];
        [severBtn setImage:[UIImage imageNamed:@"over"] forState:UIControlStateNormal];
        
        _workItemarray = _fiveItemArray;
        _workItemIdArray = _fiveItemIdArray;
        [_collectionView reloadData];
        
    }else{
        [button setImage:[UIImage imageNamed:@"overClick"] forState:UIControlStateNormal];
        UIButton *fiveBtn = (UIButton *)[self.view viewWithTag:5];
        [fiveBtn setImage:[UIImage imageNamed:@"over"] forState:UIControlStateNormal];
        _workItemarray = _sevenItemArray;
        _workItemIdArray = _sevenItemIdArray;
        [_collectionView reloadData];
    
}
    
    
    
}
#pragma mark - 工作完成的按钮响应方法
- (void)workOverBtnClick{
    
    
    NSString *carSeat;
    if (_workItemarray.count < _sevenItemArray.count) {
        NSLog(@"五座车");
        carSeat = @"5";
    }else{
        NSLog(@"七座车");
        carSeat = @"7";
    }
    
    __block NSString *itemIdString;
    
    
    __block NSString *URLString;
// 判断图片个数
    if (_imageArray.count > 2) {
        [_imageArray enumerateObjectsUsingBlock:^(MYImageView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"imageURL---%@--",obj.resultURL);
            if (idx == 0) {
                URLString = obj.resultURL;
            }else{
                URLString = [NSString stringWithFormat:@"%@,%@",URLString,obj.resultURL];
            }
        }];

    // 判断是否选择工作项
        if (_buttonArray.count > 0) {
            [_buttonArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
                if (idx == 0) {
                    itemIdString = obj;
                }else{
                    itemIdString = [NSString stringWithFormat:@"%@,%@",itemIdString,obj];
                }
            }];
            NSLog(@"----itemIdString---%@---",itemIdString);
            
            NSDictionary *dictionary = @{@"orderId":_orderId,@"afterPhotos":URLString,@"workItems":itemIdString,@"carSeat":carSeat};
            NSLog(@"----dictionary---%@--",dictionary);
            
            [GFHttpTool PostOverDictionary:dictionary success:^(NSDictionary *responseObject) {
                NSLog(@"请求成功--%@--",responseObject);
                if ([responseObject[@"result"] integerValue] == 1) {
                    [_timer invalidate];
                    _timer = nil;
                    
                    CLShareViewController *homeOrder = [[CLShareViewController alloc]init];
                    homeOrder.orderNumber = self.orderNumber;
                    UIWindow *window = [UIApplication sharedApplication].keyWindow;
                    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:homeOrder];
                    navigation.navigationBarHidden = YES;
                    window.rootViewController = navigation;
                    
                    
                    
                    
                }else{
                    [self addAlertView:responseObject[@"message"]];
                }
                
                
                
            } failure:^(NSError *error) {
                NSLog(@"----请求失败了--%@--",error);
                [self addAlertView:@"提交失败"];
            }];
            
            
            
        }else{
            [self addAlertView:@"请选择工作项"];
        }
        
        
        
       
    }else{
        [self addAlertView:@"至少上传三张照片"];
    }
    
    NSLog(@"----URLString----%@---",URLString);
    
    
    
    
    
//    CLShareViewController *shareView = [[CLShareViewController alloc]init];
//    [self.navigationController pushViewController:shareView animated:YES];
    
}

#pragma mark - AlertView
- (void)addAlertView:(NSString *)title{
    GFTipView *tipView = [[GFTipView alloc]initWithNormalHeightWithMessage:title withViewController:self withShowTimw:1.0];
    [tipView tipViewShow];
}

// 添加导航
- (void)setNavigation{
    
    GFNavigationView *navView = [[GFNavigationView alloc] initWithLeftImgName:@"back" withLeftImgHightName:@"backClick" withRightImgName:@"person" withRightImgHightName:@"personClick" withCenterTitle:@"车邻邦" withFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navView.leftBut addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView.rightBut addTarget:navView action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:navView];
    
    
}
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
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

