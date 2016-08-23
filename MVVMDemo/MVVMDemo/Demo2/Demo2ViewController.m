//
//  Demo2ViewController.m
//  MVVMDemo
//
//  Created by Liang Shixing on 16/8/3.
//  Copyright © 2016年 Liang Shixing. All rights reserved.
//

#import "Demo2ViewController.h"
#import <ReactiveCocoa.h>
#import "Demo2ViewModel.h"
@interface Demo2ViewController ()
@property (nonatomic) Demo2ViewModel *viewModel;
@end

@implementation Demo2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _viewModel = [[Demo2ViewModel alloc] init];
    RACChannelTerminal *phoneTerminal = [_phoneTextField rac_newTextChannel];
    [_viewModel.phoneTerminal subscribe:phoneTerminal];
    [phoneTerminal subscribe:_viewModel.phoneTerminal];

    RACChannelTerminal *passwordTerminal = [_passwordTextField rac_newTextChannel];
    RACChannelTerminal *viewModelPasswordTerminal = RACChannelTo(_viewModel, password);
    [viewModelPasswordTerminal subscribe:passwordTerminal];
    [passwordTerminal subscribe:viewModelPasswordTerminal];

    RAC(_outputLabel, text) = _viewModel.outputSignal;
    _clearButton.rac_command = _viewModel.clearCommand;

    UIColor *(^mapValidateToColor)(NSNumber *) = ^(NSNumber *pass) {
        return [pass boolValue] ? [UIColor blackColor] : [UIColor redColor];
    };

    RAC(_passwordTextField, textColor) = [[_viewModel.verifyPasswordSignal distinctUntilChanged]map:mapValidateToColor];

    RAC(_phoneTextField, textColor) = [[_viewModel.verifyPhoneSignal distinctUntilChanged]map:mapValidateToColor];
}

@end
