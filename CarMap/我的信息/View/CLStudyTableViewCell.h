//
//  CLStudyTableViewCell.h
//  CarMap
//
//  Created by inCar on 2018/6/19.
//  Copyright © 2018年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLStudyModel.h"


@interface CLStudyTableViewCell : UITableViewCell

{
    UILabel *_titleLabel;
    UILabel *_typeLabel;
    UILabel *_remarkLabel;
    UILabel *_remarkDetailLabel;
}

- (void)setDataForStudyModel:(CLStudyModel *)studyModel;


@end
