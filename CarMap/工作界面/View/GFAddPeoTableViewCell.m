//
//  GFAddPeoTableViewCell.m
//  CarMap
//
//  Created by 陈光法 on 16/12/12.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFAddPeoTableViewCell.h"
#import "GFAddpeoModel.h"
#import "UIImageView+WebCache.h"

@interface GFAddPeoTableViewCell()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *phoneLab;
//@property (nonatomic, strong) UIButton *addBut;

@end

@implementation GFAddPeoTableViewCell


- (void)setModel:(GFAddpeoModel *)model {
    
    _model = model;
    
    self.nameLab.text = model.name;
    self.phoneLab.text = model.phone;
    NSString *str = [NSString stringWithFormat:@"%@%@",BaseHttp,model.avatar];
    ICLog(@"--------%@====", str);
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"userHeadImage"]];
//    self.addBut.tag = [model.jishiId integerValue];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self != nil) {
    
        self.backgroundColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1];
        
        UIView *vv = [[UIView alloc] init];
        vv.frame = CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width - 40, 80);
        vv.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:vv];
        
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
//        self.iconView.backgroundColor = [UIColor redColor];
        self.iconView.layer.cornerRadius = 30;
        self.contentView.contentMode = UIViewContentModeScaleAspectFit;
        [vv addSubview:self.iconView];
        
        self.nameLab = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 30)];
//        self.nameLab.backgroundColor = [UIColor greenColor];
        self.nameLab.font = [UIFont systemFontOfSize:15];
        self.nameLab.text = @"王尼玛 ";
        self.nameLab.textColor = [UIColor darkGrayColor];
        [vv addSubview:self.nameLab];
        
        self.phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 200, 30)];
//        self.phoneLab.backgroundColor = [UIColor greenColor];
        self.phoneLab.font = [UIFont systemFontOfSize:15];
        self.phoneLab.text = @"999999999";
        self.phoneLab.textColor = [UIColor darkGrayColor];
        [vv addSubview:self.phoneLab];
        
        self.addBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addBut.frame = CGRectMake(vv.frame.size.width - 60, 10, 50, 30);
        self.addBut.layer.borderColor = [[UIColor orangeColor] CGColor];
        self.addBut.layer.borderWidth = 1;
        self.addBut.layer.cornerRadius = 5;
        [self.addBut setTitle:@"添加" forState:UIControlStateNormal];
        [self.addBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        self.addBut.titleLabel.font = [UIFont systemFontOfSize:15];
        [vv addSubview:self.addBut];
    }
    
    return self;
}











- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
