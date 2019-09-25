//
//  CLZYSupperSelectView.h
//  CarMapB
//
//  Created by inCar on 2018/6/14.
//  Copyright © 2018年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CLZYSuperSelectViewDelegate <NSObject>

- (void)didAcceptSomething:(NSString *) someoneName;



@end


@interface CLZYSupperSelectView : UIView

@property (nonatomic, assign) id <CLZYSuperSelectViewDelegate> delegate;
@property (nonatomic, copy) NSString *nameString;


- (instancetype)initWithTitle:(NSString *)titleString itemArray:(NSArray *)itemArray;

@end



