//
//  Demo1Model.m
//  MVVMDemo
//
//  Created by Liang Shixing on 16/7/24.
//  Copyright © 2016年 Liang Shixing. All rights reserved.
//

#import "Demo1Model.h"
#import <Mantle/Mantle.h>
#import "Scenic.h"
#import "Hotel.h"

@implementation Demo1Model


- (RACSignal *)loadTravelData
{
    /// 这里模拟网络连接
    return [[RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
        // 模拟网络的延时
        [NSThread sleepForTimeInterval:1];
        // 模拟 25% 的概率发生网络错误
        NSInteger randNumber = arc4random();
        NSLog(@"%ld", (long)randNumber);
        if (randNumber % 4 == 0) {
            NSError *error = [NSError errorWithDomain:@"Bad Network" code:500 userInfo:@{}];
            [subscriber sendError:error];
            return nil;
        }


        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Demo1TravelData" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSError *error = nil;

        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error ];

        if (error) {
            [subscriber sendError:error];
        } else {
            NSArray *scenicData = jsonData[@"data"];
            if (!scenicData) {
                [subscriber sendError:[NSError errorWithDomain:@"Error JSON Data" code:500 userInfo:@{}]];
            } else {
                NSArray *scenicArray = [MTLJSONAdapter modelsOfClass:Scenic.class fromJSONArray:scenicData error:&error ];

                if (error) {
                    [subscriber sendError:error];
                } else {
                    [subscriber sendNext:scenicArray];
                    [subscriber sendCompleted];
                }
            }
        }
        return [RACDisposable disposableWithBlock:^{
            //这里应该中断网络连接
        }];
    }] subscribeOn:[RACScheduler schedulerWithPriority:DISPATCH_QUEUE_PRIORITY_DEFAULT]];
}

- (RACSignal *)loadHotelData
{
    /// 这里模拟网络连接
    return [[RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
        // 模拟网络的延时
        [NSThread sleepForTimeInterval:1];

        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Demo1HotelData" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSError *error = nil;

        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error ];

        if (error) {
            [subscriber sendError:error];
        } else {
            NSArray *hotelData = jsonData[@"data"];
            if (!hotelData) {
                [subscriber sendError:[NSError errorWithDomain:@"Error JSON Data" code:500 userInfo:@{}]];
            } else {
                NSArray *hotelArray = [MTLJSONAdapter modelsOfClass:Hotel.class fromJSONArray:hotelData error:&error ];

                if (error) {
                    [subscriber sendError:error];
                } else {
                    [subscriber sendNext:hotelArray];
                    [subscriber sendCompleted];
                }
            }
        }
        return [RACDisposable disposableWithBlock:^{
            //这里应该中断网络连接
        }];
    }] subscribeOn:[RACScheduler schedulerWithPriority:DISPATCH_QUEUE_PRIORITY_DEFAULT]];
}

@end
