//
//  HotelCellViewModel.m
//  MVVMDemo
//
//  Created by Liang Shixing on 16/8/2.
//  Copyright © 2016年 Liang Shixing. All rights reserved.
//

#import "HotelCellViewModel.h"
#import "Hotel.h"

@interface HotelCellViewModel ()
@property (nonatomic) Hotel *hotel;
@end

@implementation HotelCellViewModel

- (instancetype)initWithHotel:(Hotel *)hotel
{
    if (self = [super init]) {
        self.cellName = @"POITableViewCell";
        _hotel = hotel;
        [self bindSignals];
    }
    return self;
}

- (void)bindSignals
{
    RACSignal *hotelSignal = [RACSignal return :self.hotel];

    self.titleSignal = [hotelSignal map:^id (Hotel *hotel) {
        return hotel.name;
    }];

    self.priceSignal = [RACSignal empty];
    self.campaignSignal = [hotelSignal map:^id (Hotel *hotel) {
        return hotel.poiAttrTagList.firstObject ? : @"";
    }];

    self.campaignHiddenSignal = [hotelSignal map:^id (Hotel *hotel) {
        return @(hotel.poiAttrTagList.count == 0);
    }];

    self.frontImageSignal = [[[hotelSignal map:^id (Hotel *hotel) {
        NSData *data = [NSData dataWithContentsOfURL:hotel.frontImageURL];
        return [UIImage imageWithData:data];
    }] subscribeOn:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground]]
                             deliverOnMainThread];
    self.rightFooterSignal = [RACSignal empty];
}

@end
