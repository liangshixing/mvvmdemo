//
//  ScenicCellViewModel.h
//  MVVMDemo
//
//  Created by Liang Shixing on 16/7/25.
//  Copyright © 2016年 Liang Shixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "POICellViewModel.h"

@class Scenic;
@interface ScenicCellViewModel : POICellViewModel

@property (nonatomic) NSInteger currentCityID;

- (instancetype)initWithScenic:(Scenic *)scenic;

@end
