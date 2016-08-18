//
//  Demo2ViewModel.h
//  MVVMDemo
//
//  Created by Liang Shixing on 16/8/4.
//  Copyright © 2016年 Liang Shixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface Demo2ViewModel : NSObject

@property (nonatomic) RACChannelTerminal *phoneTerminal;
@property (nonatomic) NSString *password;
@property (nonatomic) RACSignal *verifyPhoneSignal;
@property (nonatomic) RACSignal *verifyPasswordSignal;
@property (nonatomic) RACSignal *outputSignal;
@property (nonatomic) RACCommand *clearCommand;

@end
