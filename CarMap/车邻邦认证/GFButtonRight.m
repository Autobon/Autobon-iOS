//
//  GFButton.m
//  CLHYR
//
//  Created by 陈光法 on 16/8/12.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFButton.h"

@implementation GFButton


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.imageView sizeToFit];
    [self.titleLabel sizeToFit];
    
    CGFloat imgWitdth = self.imageView.bounds.size.width + self.imgLabMargin * 0.5;
    CGFloat titleWidth = self.titleLabel.frame.size.width + self.imgLabMargin * 0.5;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imgWitdth, 0, imgWitdth);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth, 0, -titleWidth);
}


- (void)setImgLabMargin:(CGFloat)imgLabMargin {
    
    _imgLabMargin = imgLabMargin;
    
    [self layoutIfNeeded];
}


@end
