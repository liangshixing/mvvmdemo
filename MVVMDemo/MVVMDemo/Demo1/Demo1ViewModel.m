//
//  Demo1ViewModel.m
//  MVVMDemo
//
//  Created by Liang Shixing on 16/7/24.
//  Copyright © 2016年 Liang Shixing. All rights reserved.
//

#import "Demo1ViewModel.h"
#import "Demo1Model.h"
#import "LocationManager.h"
#import "Scenic.h"
#import "Hotel.h"
#import "ScenicCellViewModel.h"
#import "HotelCellViewModel.h"

@interface Demo1ViewModel ()
@property (nonatomic) RACCommand *loadDataCommand;
@property (nonatomic) RACSignal *dataSignal;
@property (nonatomic) RACSignal *errorSignal;
@end

@implementation Demo1ViewModel

- (instancetype)init
{
    if (self = [super init]) {
        _dataSignal = [[self.loadDataCommand.executionSignals flattenMap:^RACStream *(RACSignal *dataSignal) {
            LocationManager *locationManager = [LocationManager defaultLocationManager];
            return [dataSignal map:^id (RACTuple *data) {
                NSArray *scenicArray = data.first;
                NSArray *hotelArray = data.second;
                return [[[[scenicArray rac_sequence] map:^id (Scenic *scenic) {
                    ScenicCellViewModel *viewModel = [[ScenicCellViewModel alloc] initWithScenic:scenic];
                    viewModel.currentCityID = locationManager.lastLoaionCityID;
                    return viewModel;
                }] concat:[[hotelArray rac_sequence] map:^id (Hotel *hotel) {
                    HotelCellViewModel *viewModel = [[HotelCellViewModel alloc] initWithHotel:hotel];
                    return viewModel;
                }]] array];
            }];
        }] deliverOnMainThread];
        _errorSignal = self.loadDataCommand.errors;
    }
    return self;
}

- (RACCommand *)loadDataCommand
{
    if (!_loadDataCommand) {
        _loadDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            Demo1Model *model = [[Demo1Model alloc] init];
            RACSignal *travelSignal = [model loadTravelData];
            RACSignal *hotelSignal = [model loadHotelData];
            return [travelSignal zipWith:hotelSignal];
        }];
    }
    return _loadDataCommand;
}

@end
