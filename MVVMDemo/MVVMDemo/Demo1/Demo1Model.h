//
//  Demo1Model.h
//  MVVMDemo
//
//  Created by Liang Shixing on 16/7/24.
//  Copyright © 2016年 Liang Shixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface Demo1Model : NSObject

- (RACSignal *)loadTravelData;
- (RACSignal *)loadHotelData;

@end
