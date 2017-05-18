//
//  GFProjectView.h
//  施工项目按钮
//
//  Created by 陈光法 on 16/11/1.
//  Copyright © 2016年 陈光法. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GFProjectView;
@protocol GFProjectViewDelegate <NSObject>

- (void)GFProjectView:(GFProjectView *)projectView;

@end


@interface GFProjectView : UIView

@property (nonatomic, strong) NSArray *prArr;
@property (nonatomic, strong) NSMutableArray *buweiIdArr;
@property (nonatomic, strong) NSMutableArray *idArr;
@property (nonatomic, strong) NSMutableArray *disableArr;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) CGFloat vvHeight;

@property (nonatomic, weak) id<GFProjectViewDelegate> delegate;



@end
