//
//  LocationManager.m
//  MVVMDemo
//
//  Created by Liang Shixing on 16/7/25.
//  Copyright © 2016年 Liang Shixing. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager
+ (instancetype)defaultLocationManager
{
    static dispatch_once_t onceToken;
    static LocationManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[LocationManager alloc] init];

        manager.lastLoaionCityID = 1;
        manager.lastLoaionCityName = @"北京";
    });
    return manager;
}

@end
