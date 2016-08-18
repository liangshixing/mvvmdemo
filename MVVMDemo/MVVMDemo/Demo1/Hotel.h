//
//  Hotel.h
//  MVVMDemo
//
//  Created by Liang Shixing on 16/8/2.
//  Copyright © 2016年 Liang Shixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mantle/Mantle.h>

@interface Hotel : MTLModel<MTLJSONSerializing>

@property (nonatomic) NSArray *poiAttrTagList;
@property (nonatomic) NSString *scoreIntro;
@property (nonatomic) double avgScore;
@property (nonatomic) double lowestPrice;
@property (nonatomic) double lng;
@property (nonatomic) double lat;
@property (nonatomic) NSString *lastOrderTime;
@property (nonatomic) NSString *saleTag;
@property (nonatomic) NSString *positionDescription;
@property (nonatomic) NSString *name;
@property (nonatomic) NSURL *frontImageURL;

@end
