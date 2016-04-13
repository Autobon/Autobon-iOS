//
//  GFTransformTableViewCell.h
//  CarMap
//
//  Created by 陈光法 on 16/2/29.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFTransformTableViewCell : UITableViewCell
{
    UIImageView *_lineImgView;
    UIView *_baseView;
}

@property (nonatomic, assign) NSInteger cellHeight;
@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UILabel *contentLabel;
@property (nonatomic ,strong) UILabel *timeLab;

- (void)cellForMessage;

@end
