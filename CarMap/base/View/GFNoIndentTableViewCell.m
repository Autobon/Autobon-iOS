//
//  GFNoIndentTableViewCell.m
//  车邻邦客户端
//
//  Created by 陈光法 on 16/3/10.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import "GFNoIndentTableViewCell.h"
#import "GFTitleView.h"

@interface GFNoIndentTableViewCell()




{
    GFTitleView *indentView;
    
    CGFloat hh;
    
    
}


@end


@implementation GFNoIndentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if(self != nil) {
        self.backgroundColor = [UIColor clearColor];
        CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
        
        CGFloat jiange1 = kHeight * 0.016;
        CGFloat jiange2 = kHeight * 0.011;
        CGFloat jiange3 = kHeight * 0.03125;
        CGFloat jiange4 = kHeight * 0.023;
        
        CGFloat jianjv1 = kWidth * 0.065;
        
        self.baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 400)];
        self.baseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.baseView];
        
        
        // 订单编号
        indentView = [[GFTitleView alloc] initWithY:jiange1];
        [self.baseView addSubview:indentView];
        
        
        // 汽车贴膜
        CGFloat lab1W = kWidth - jianjv1 * 2.0;
        CGFloat lab1H = kHeight * 0.0261;
        CGFloat lab1X = jianjv1;
        CGFloat lab1Y = CGRectGetMaxY(indentView.frame) + jiange1;
        self.lab1 = [[UILabel alloc] init];
        self.lab1.frame = CGRectMake(lab1X, lab1Y, lab1W, lab1H);
        self.lab1.textColor = [UIColor colorWithRed:235 / 255.0 green:96 / 255.0 blue:1 / 255.0 alpha:1];
        self.lab1.text = @"汽车贴膜";
        self.lab1.font = [UIFont systemFontOfSize:11 / 320.0 * kWidth];
        [self.baseView addSubview:self.lab1];
        
        
        // 预约时间
        CGFloat lab2W = lab1W;
        CGFloat lab2H = lab1H;
        CGFloat lab2X = lab1X;
        CGFloat lab2Y = CGRectGetMaxY(self.lab1.frame) + jiange2 - 3;
        self.lab2 = [[UILabel alloc] init];
        self.lab2.frame = CGRectMake(lab2X, lab2Y, lab2W, lab2H);
        self.lab2.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
        self.lab2.font = [UIFont systemFontOfSize:11 / 320.0 * kWidth];
        [self.baseView addSubview:self.lab2];
        
        
        // 边线
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(jianjv1 - 2, CGRectGetMaxY(self.lab2.frame) + jiange1, kWidth - jianjv1 * 2 + 4, 1)];
        lineView1.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
        [self.baseView addSubview:lineView1];
        
        
        // 订单图
        CGFloat imageViewW = kWidth - jianjv1 * 2 + 4;
        CGFloat imageViewH = kHeight * 0.237;
        CGFloat imageViewX = jianjv1 - 2;
        CGFloat imageViewY = CGRectGetMaxY(lineView1.frame) + jiange3;
        self.indentImgView = [[UIImageView alloc] initWithFrame:CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH)];
        self.indentImgView.backgroundColor = [UIColor redColor];
        [self.baseView addSubview:self.indentImgView];
        
        
        // 边线
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.indentImgView.frame) + jiange3, kWidth, 1)];
        lineView2.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
        [self.baseView addSubview:lineView2];
        
        hh = CGRectGetMaxY(lineView2.frame) + jiange4;
        
        // 备注
        CGFloat lab3W = kWidth - jianjv1 * 2.0;
        CGFloat lab3H = kHeight * 0.03;
        CGFloat lab3X = jianjv1;
        CGFloat lab3Y = CGRectGetMaxY(lineView2.frame) + jiange4;
        self.lab3 = [[UILabel alloc] init];
        self.lab3.frame = CGRectMake(lab3X, lab3Y, lab3W, lab3H);
        self.lab3.font = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
        self.lab3.numberOfLines = 0;
//        self.lab3.backgroundColor = [UIColor cyanColor];
        [self.baseView addSubview:self.lab3];
        
        // 下单时间
        self.baseView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lab3.frame) + jiange4, kWidth, kHeight * 0.0573)];
        [self.baseView addSubview:self.baseView2];
        
        // 边线
        UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight * 0.0573, kWidth, 1)];
        lineView4.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
        [self.baseView2 addSubview:lineView4];
        // lab
        CGFloat lab4W = kWidth - jianjv1 * 2.0;
        CGFloat lab4H = kHeight * 0.0573;
        CGFloat lab4X = jianjv1;
        CGFloat lab4Y = 0;
        self.lab4 = [[UILabel alloc] init];
        self.lab4.frame = CGRectMake(lab4X, lab4Y, lab4W, lab4H);
        self.lab4.font = [UIFont systemFontOfSize:12 / 320.0 * kWidth];
        [self.baseView2 addSubview:self.lab4];
        
        self.baseView.frame = CGRectMake(0, 0, kWidth, CGRectGetMaxY(self.baseView2.frame));
        self.baseView.backgroundColor = [UIColor grayColor];
        
        self.cellHeight = self.backgroundView.frame.size.height;
        
        
        
        // 边线
        UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-5, kWidth, 1)];
        lineView3.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:230 / 255.0 blue:231 / 255.0 alpha:1];
        [self addSubview:lineView3];
        
        
    }
    
    return self;
}



- (void)setMessage {
    CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat kHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat jianjv1 = kWidth * 0.065;
    CGFloat jiange4 = kHeight * 0.023;
    

    if([self.orderType isEqualToString:@"未接单"]) {
        indentView.rightLab.textColor = [UIColor colorWithRed:143 / 255.0 green:144 / 255.0 blue:145 / 255.0 alpha:1];
    }
    
    indentView.titleLab.text = self.orderNum;
    indentView.rightLab.text = self.orderType;
    self.lab1.text = self.workCon;
    self.lab2.text = self.workTime;
    self.lab3.text = self.beizhu;
    self.lab4.text = self.xiadanTime;
    
    NSString *fenStr = self.beizhu;
    NSMutableDictionary *fenDic = [[NSMutableDictionary alloc] init];
    fenDic[NSFontAttributeName] = [UIFont systemFontOfSize:14 / 320.0 * kWidth];
    fenDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    CGRect fenRect = [fenStr boundingRectWithSize:CGSizeMake(kWidth - jianjv1 * 2.0, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fenDic context:nil];
    CGFloat lab3W = kWidth - jianjv1 * 2.0;
    CGFloat lab3H = fenRect.size.height;
    CGFloat lab3X = jianjv1;
    CGFloat lab3Y = CGRectGetMaxY(self.indentImgView.frame) + jiange4;
    self.lab3.frame = CGRectMake(lab3X, lab3Y+10, lab3W, lab3H);
    self.baseView.frame = CGRectMake(0, 0, kWidth, CGRectGetMaxY(self.baseView2.frame));
    self.lab3.backgroundColor = [UIColor cyanColor];
    
//    NSLog(@"%f  %f  %f  %f", lab3X, lab3Y, lab3W, lab3H);
//    NSLog(@"%f", self.imageView.frame.origin.y);
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
