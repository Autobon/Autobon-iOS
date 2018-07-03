//
//  CLAUTouchView.h
//  CarMap
//
//  Created by inCar on 2018/7/2.
//  Copyright © 2018年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLAUTouchView : UIView
{
    NSMutableArray *_buttonArray;
}

- (void)setChooseViewWithTitleArray:(NSArray *)titleArray;


@property (nonatomic ,strong) UIButton *trueButton;


@end
