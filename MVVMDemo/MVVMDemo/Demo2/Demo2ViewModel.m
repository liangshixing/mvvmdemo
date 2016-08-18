//
//  Demo2ViewModel.m
//  MVVMDemo
//
//  Created by Liang Shixing on 16/8/4.
//  Copyright © 2016年 Liang Shixing. All rights reserved.
//

#import "Demo2ViewModel.h"
@interface Demo2ViewModel ()
@property (nonatomic) NSString *phone;
@end

@implementation Demo2ViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _phone = @"186";
        _password = @"";
        _phoneTerminal = RACChannelTo(self, phone);

        _outputSignal = [RACSignal combineLatest:@[RACObserve(self, phone), RACObserve(self, password)] reduce:^id (NSString *phone, NSString *password) {
            return [NSString stringWithFormat:@"手机号：%@, 密码：%@", phone, password];
        }];

        _verifyPhoneSignal = [RACObserve(self, phone) map:^id (NSString *phone) {
            NSString *phoneRegexp = @"^1(3[0-9]|5[0-35-9]|8[0-25-9])\\d{8}$";
            NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegexp];
            return @((BOOL)[regextestmobile evaluateWithObject:phone]);
        }];

        _verifyPasswordSignal = [RACObserve(self, password) map:^id (NSString *password) {
            return @((BOOL)([password length] >= 8));
        }];

        RACSignal *verifyAllSignal = [RACSignal combineLatest:@[ _verifyPhoneSignal, _verifyPasswordSignal] reduce:^id (NSNumber *phonePass, NSNumber *passwordPass) {
            return @([phonePass boolValue] && [passwordPass boolValue]);
        }];


        @weakify(self);
        _clearCommand = [[RACCommand alloc] initWithEnabled:verifyAllSignal signalBlock:^RACSignal *(id input) {
            @strongify(self);
            self.phone = @"186";
            self.password = @"";
            return [RACSignal empty];
        }];

    }
    return self;
}

@end
