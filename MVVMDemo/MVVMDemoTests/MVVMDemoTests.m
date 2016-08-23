//
//  MVVMDemoTests.m
//  MVVMDemoTests
//
//  Created by Liang Shixing on 16/7/23.
//  Copyright © 2016年 Liang Shixing. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Demo2ViewModel.h"

@interface MVVMDemoTests : XCTestCase

@end

@implementation MVVMDemoTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testVerifyPhone
{
    Demo2ViewModel *viewModel = [[Demo2ViewModel alloc] init];

    RACChannel *channel = [[RACChannel alloc] init];
    [viewModel.phoneTerminal subscribe:channel.leadingTerminal];
    [channel.leadingTerminal subscribe:viewModel.phoneTerminal];

    [channel.followingTerminal sendNext:@"18612345678"]; // 模拟从文本框输入 18612345678

    NSNumber *verifyPhoneResult = [viewModel.verifyPhoneSignal first];
    XCTAssertEqualObjects(verifyPhoneResult, @(YES));

    [viewModel setValue:@"13810001000" forKey:@"phone"]; // 模拟ViewModel更新phone值为13810001000

    XCTAssertEqualObjects([channel.followingTerminal first], @"13810001000"); // 检验文本框内容是否为13810001000

    viewModel.password = @"1234";
    NSNumber *verifyPasswordResult = [viewModel.verifyPasswordSignal first];
    XCTAssertEqualObjects(verifyPasswordResult, @(NO)); // 测试密码校验逻辑，少于8位，失败。
}

- (void)testClearCommand
{
    Demo2ViewModel *viewModel = [[Demo2ViewModel alloc] init];

    [viewModel setValue:@"18612345678" forKey:@"phone"];
    XCTAssertEqualObjects([viewModel valueForKey:@"phone"], @"18612345678");

    [viewModel setValue:@"passw0rd" forKey:@"password"];
    XCTAssertEqualObjects([viewModel valueForKey:@"password"], @"passw0rd");

    [viewModel.clearCommand execute:nil];

    XCTAssertEqualObjects([viewModel valueForKey:@"phone"], @"186");
    XCTAssertEqualObjects([viewModel valueForKey:@"password"], @"");
}

- (void)testPerformanceExample
{
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
