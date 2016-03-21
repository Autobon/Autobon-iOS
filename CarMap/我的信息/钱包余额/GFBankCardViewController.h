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

@property (nonatomic, copy) NSString *bankStr;
@property (nonatomic, copy) NSString *bankCard;
@property (nonatomic, strong) GFTextField *cardTxt;


@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *endBank;
@end
