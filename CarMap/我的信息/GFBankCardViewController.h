//
//  GFBankCardViewController.h
//  CarMap
//
//  Created by 陈光法 on 16/2/22.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GFBankCardViewController;
@class GFTextField;

@protocol GFBankCardViewControllerDelegate <NSObject>

@optional
- (void)changeBankCardViewController:(GFBankCardViewController *)bankCardVC;

@end





@interface GFBankCardViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>


@property (nonatomic, assign) id<GFBankCardViewControllerDelegate> delegate;

@property (nonatomic, assign) NSString *bankStr;
@property (nonatomic, strong) GFTextField *cardTxt;


@end
