//
//  TravelModel.m
//  MVVMDemo
//
//  Created by Liang Shixing on 16/7/24.
//  Copyright © 2016年 Liang Shixing. All rights reserved.
//

#import "Scenic.h"

@implementation Scenic

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"campaignTag" : @"campaignTag",
             @"lowestPrice" : @"lowestPrice",
             @"lng" : @"lng",
             @"lat" : @"lat",
             @"cityID" : @"cityId",
             @"cityName" : @"cityName",
             @"areaName" : @"areaName",
             @"frontImgURL" : @"frontImg",
             @"solds" : @"solds",
             @"name" : @"name", };
}

+ (NSValueTransformer *)frontImgURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
