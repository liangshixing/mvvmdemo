//
//  BaseTableViewCell.h
//  MVVMDemo
//
//  Created by Liang Shixing on 16/7/25.
//  Copyright © 2016年 Liang Shixing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseCellViewModel;

@interface BaseTableViewCell : UITableViewCell

- (void)bindWithViewModel:(BaseCellViewModel *)viewModel;

@end
