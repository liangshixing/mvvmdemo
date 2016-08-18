//
//  LocationManager.h
//  MVVMDemo
//
//  Created by Liang Shixing on 16/7/25.
//  Copyright © 2016年 Liang Shixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationManager : NSObject

@property (nonatomic) NSInteger lastLoaionCityID;
@property (nonatomic) NSString *lastLoaionCityName;

+ (instancetype)defaultLocationManager;

@end
