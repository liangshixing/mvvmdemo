//
//  Hotel.m
//  MVVMDemo
//
//  Created by Liang Shixing on 16/8/2.
//  Copyright © 2016年 Liang Shixing. All rights reserved.
//

#import "Hotel.h"

@implementation Hotel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"poiAttrTagList" : @"poiAttrTagList",
             @"lowestPrice" : @"lowestPrice",
             @"scoreIntro" : @"scoreIntro",
             @"avgScore" : @"avgScore",
             @"lng" : @"lng",
             @"lat" : @"lat",
             @"positionDescription" : @"posdescr",
             @"frontImageURL" : @"frontImg",
             @"name" : @"name",
             @"saleTag" : @"poiSaleAndSpanTag",
             @"lastOrderTime" : @"poiLastOrderTime"};
}

+ (NSValueTransformer *)frontImageURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
