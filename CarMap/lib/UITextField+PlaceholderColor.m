//
//  UITextField+PlaceholderColor.m
//  CarMap
//
//  Created by inCarL on 2020/4/21.
//  Copyright © 2020 mll. All rights reserved.
//

#import "UITextField+PlaceholderColor.h"

@implementation UITextField (PlaceholderColor)

- (void)setTextFieldPlaceholderString:(NSString *)placeholder{

    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0], NSFontAttributeName:self.font}];
    self.attributedPlaceholder = attrString;

}


@end
