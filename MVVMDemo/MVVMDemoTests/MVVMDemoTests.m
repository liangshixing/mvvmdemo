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

    [viewModel setValue:@"18612345678" forKey:@"phone"];
    NSNumber *verifyPhoneResult = [viewModel.verifyPhoneSignal first];

    XCTAssertEqualObjects(verifyPhoneResult, @(YES));
    [viewModel setValue:@"110" forKey:@"phone"];
    verifyPhoneResult = [viewModel.verifyPhoneSignal first];

    XCTAssertEqualObjects(verifyPhoneResult, @(NO));
}

- (void)testClearCommand
{
    Demo2ViewModel *viewModel = [[Demo2ViewModel alloc] init];

    [viewModel setValue:@"18612345678" forKey:@"phone"];
    XCTAssertEqualObjects([viewModel valueForKey:@"phone"], @"18612345678");

    [viewModel setValue:@"passw0rd" forKey:@"password"];
    XCTAssertEqualObjects([viewModel valueForKey:@"password"], @"passw0rd");

    [viewModel.clearCommand execute:nil];

    XCTAssertEqualObjects([viewModel valueForKey:@"phone"], @"");
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
