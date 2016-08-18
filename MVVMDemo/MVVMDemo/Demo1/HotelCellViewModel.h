//
//  HotelCellViewModel.h
//  MVVMDemo
//
//  Created by Liang Shixing on 16/8/2.
//  Copyright © 2016年 Liang Shixing. All rights reserved.
//

#import "POICellViewModel.h"

@class Hotel;
@interface HotelCellViewModel : POICellViewModel

- (instancetype)initWithHotel:(Hotel *)hotel;

@end
