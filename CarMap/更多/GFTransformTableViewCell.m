//
//  GFTransformTableViewCell.m
//  CarMap
//
//  Created by 陈光法 on 16/2/29.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFTransformTableViewCell.h"

@implementation GFTransformTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self != nil) {
        self.backgroundColor = [UIColor colorWithRed:252 / 255.0 green:252 / 255.0 blue:252 / 255.0 alpha:1];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
        
        CGFloat baseViewW = kWidth - kWidth * 0.028 * 2.0;
        CGFloat baseViewH = 400;
        CGFloat baseViewX = kWidth * 0.028;
        CGFloat baseViewY = kHeight * 0.026;
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(baseViewX, baseViewY, baseViewW, baseViewH)];
        _baseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_baseView];
        _baseView.layer.borderWidth = 1;
        _baseView.layer.borderColor = [[UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1] CGColor];

    
        
//        NSString *lab1Str = @"发送旅客的法国萨科技的股份发送旅客房价拉萨的叫法阿萨德飞拉萨发生了";
        
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
//        lab1.text = _titleString;
        _titleLabel.font = [UIFont systemFontOfSize:16 / 320.0 * kWidth];
        [_baseView addSubview:_titleLabel];

        
        
//        NSString *lab2Str = @"发送旅客的法国萨科技的股份发送旅客房价拉萨的叫法阿萨德飞拉萨发生了";
        
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
//        lab2.text = _contentString;
        _contentLabel.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
        [_baseView addSubview:_contentLabel];
        
        
        // 虚线
        
        _lineImgView = [[UIImageView alloc] init];
        _lineImgView.image = [UIImage imageNamed:@"line.png"];
        [_baseView addSubview:_lineImgView];
        
        
        _timeLab = [[UILabel alloc] init];
        _timeLab.textAlignment = NSTextAlignmentRight;
        _timeLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
//        timeLab.text = _timeString;
        _timeLab.font = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
        [_baseView addSubview:_timeLab];
        
        
    }
    
    
    return self;
}

- (void)cellForMessage{
    CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat baseViewW = kWidth - kWidth * 0.028 * 2.0;
    CGFloat baseViewX = kWidth * 0.028;
    CGFloat baseViewY = kHeight * 0.026;
    
    
    NSMutableDictionary *lab1Dic = [[NSMutableDictionary alloc] init];
    lab1Dic[NSFontAttributeName] = [UIFont systemFontOfSize:16 / 320.0 * kWidth];
    lab1Dic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect fenRect1 = [_titleLabel.text boundingRectWithSize:CGSizeMake(baseViewW - kWidth * 0.023 * 2.0, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:lab1Dic context:nil];
    CGFloat lab1W = baseViewW - kWidth * 0.023 * 2.0;
    CGFloat lab1H = fenRect1.size.height;
    CGFloat lab1X = kWidth * 0.023;
    CGFloat lab1Y = kHeight * 0.02864;
    _titleLabel.frame = CGRectMake(lab1X, lab1Y, lab1W, lab1H);
    NSMutableDictionary *lab2Dic = [[NSMutableDictionary alloc] init];
    lab2Dic[NSFontAttributeName] = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    lab2Dic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect fenRect2 = [_contentLabel.text boundingRectWithSize:CGSizeMake(baseViewW - kWidth * 0.023 * 2.0, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:lab2Dic context:nil];
    CGFloat lab2W  =lab1W;
    CGFloat lab2H = fenRect2.size.height;
    CGFloat lab2X = lab1X;
    CGFloat lab2Y = CGRectGetMaxY(_titleLabel.frame) + kHeight * 0.0234;
    _contentLabel.frame = CGRectMake(lab2X, lab2Y, lab2W, lab2H);
    
    // 虚线
    CGFloat lineImgViewW = baseViewW;
    CGFloat lineImgViewH = 1;
    CGFloat lineImgViewX = 0;
    CGFloat lineImgViewY = CGRectGetMaxY(_contentLabel.frame) + kHeight * 0.0234;
    _lineImgView.frame = CGRectMake(lineImgViewX, lineImgViewY, lineImgViewW, lineImgViewH);
    
    _timeLab.frame = CGRectMake(lab1X, CGRectGetMaxY(_lineImgView.frame), lab1W, kHeight * 0.0625);
    
    _baseView.frame = CGRectMake(baseViewX, baseViewY, baseViewW, CGRectGetMaxY(_timeLab.frame));
    
    
    self.cellHeight = _baseView.frame.size.height + kHeight * 0.026;
    
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
