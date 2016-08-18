//
//  ScenicCellViewModel.m
//  MVVMDemo
//
//  Created by Liang Shixing on 16/7/25.
//  Copyright © 2016年 Liang Shixing. All rights reserved.
//

#import "ScenicCellViewModel.h"
#import "Scenic.h"

@interface ScenicCellViewModel ()
@property (nonatomic) Scenic *scenic;
@end

@implementation ScenicCellViewModel

- (instancetype)initWithScenic:(Scenic *)scenic
{
    if (self = [super init]) {
        self.cellName = @"POITableViewCell";
        _scenic = scenic;
        [self bindSignals];
    }
    return self;
}

- (void)bindSignals
{
    RACSignal *scenicSignal = [RACSignal return :self.scenic];

    self.titleSignal = [scenicSignal map:^id (Scenic *scenic) {
        return scenic.name;
    }];

    self.priceSignal = [scenicSignal map:^id (Scenic *scenic) {
        NSString *priceString = [NSString stringWithFormat:@"￥%.2f起", scenic.lowestPrice];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:priceString
                                                                                            attributes:@{NSForegroundColorAttributeName : [UIColor blueColor]}];
        [attributeString setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10],
                                         NSForegroundColorAttributeName : [UIColor blueColor]}
                                 range:NSMakeRange([priceString length] - 1, 1)];
        return [attributeString copy];
    }];

    self.campaignSignal = [scenicSignal map:^id (Scenic *scenic) {
        return scenic.campaignTag;
    }];

    self.campaignHiddenSignal = [scenicSignal map:^id (Scenic *scenic) {
        return @([scenic.campaignTag length] == 0);
    }];


    self.frontImageSignal = [[[scenicSignal map:^id (Scenic *scenic) {
        NSData *data = [NSData dataWithContentsOfURL:scenic.frontImgURL];
        return [UIImage imageWithData:data];
    }] subscribeOn:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground]]
                             deliverOnMainThread];

    self.rightFooterSignal = [RACSignal combineLatest:@[scenicSignal, RACObserve(self, currentCityID) ] reduce:^id (Scenic *scenic, NSNumber *currentCityID) {
        if ([currentCityID integerValue] == scenic.cityID) {
            return scenic.areaName;
        } else {
            return scenic.cityName;
        }
    }];
}

@end
