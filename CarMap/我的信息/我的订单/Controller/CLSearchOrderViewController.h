//
//  CLSearchOrderViewController.h
//  CarMapB
//
//  Created by inCar on 2018/6/14.
//  Copyright © 2018年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CLSearchOrderDelegate <NSObject>

- (void)searchOrderForDictionary:(NSDictionary *)dataDictionary;



@end


@interface CLSearchOrderViewController : UIViewController

@property (nonatomic ,assign) id <CLSearchOrderDelegate> delegate;

@end
