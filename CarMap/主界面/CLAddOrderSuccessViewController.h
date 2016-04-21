//
//  CLAddOrderSuccessViewController.h
//  CarMap
//
//  Created by 李孟龙 on 16/3/3.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^addOrderBlock)();

@interface CLAddOrderSuccessViewController : UIViewController

@property (nonatomic ,copy) addOrderBlock addBlock;
@property (nonatomic ,strong) NSString *orderNum;

@property (nonatomic ,strong) NSDictionary *dataDictionary;
@property (nonatomic ) BOOL isHome;

@end
