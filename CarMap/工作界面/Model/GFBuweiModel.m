//
//  GFBuweiModel.m
//  CarMap
//
//  Created by 陈光法 on 16/11/10.
//  Copyright © 2016年 mll. All rights reserved.
//

#import "GFBuweiModel.h"

@implementation GFBuweiModel



- (instancetype)initWithDictionary:(NSDictionary *)dic {

    self = [super init];
    
    if(self != nil) {
        
        _buweiDicArr = dic[@"constructionPositions"];
        _proId = [NSString stringWithFormat:@"%@", dic[@"id"]];
        _proName = dic[@"name"];
        _typeId = [NSString stringWithFormat:@"%@", dic[@"type"]];
        _typeName = dic[@"typeName"];
        _constructionPositionName = dic[@"constructionPositionName"];
        _constructionPosition = [NSString stringWithFormat:@"%@", dic[@"constructionPosition"]];
    }
    
    return self;
}

@end
