//
//  main.m
//  CarMap
//
//  Created by 李孟龙 on 16/1/26.
//  Copyright © 2016年 mll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

NSString *const URLHOST = @"http://121.40.219.58";   //网络请求的域名
//NSString *const URLHOST = @"http://hpecar.com:8012";   //网络请求的域名
//extern NSString* const URLHOST;
//NSLog(@"打印一下域名－－－－%@",URLHOST);

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
