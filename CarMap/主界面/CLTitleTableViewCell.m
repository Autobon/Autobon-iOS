//
//  CLTitleTableViewCell.m
//  CarMap
//
//  Created by 李孟龙 on 16/2/18.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "CLTitleTableViewCell.h"

@implementation CLTitleTableViewCell


- (void)initWithTitle{
//    if (self = [super init]) {
//        self.backgroundColor = [UIColor redColor];
//标题label
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width, 40)];
        titleLable.text = @"抢单2单，在线5小时";
        titleLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLable];
        
//详情标题
        UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, self.frame.size.width, 30)];
        detailLabel.text = @"今日流水：600.00  成功率50%";
        detailLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:detailLabel];
        
        
//    }
//    return self;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
