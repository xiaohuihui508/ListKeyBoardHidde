//
//  UIViewController+RTCommon.m
//  ISS-ISPS-RT
//
//  Created by isoft on 2018/12/18.
//  Copyright © 2018 isoft. All rights reserved.
//

#import "UIViewController+RTCommon.h"

@implementation UIViewController (RTCommon)

- (void)setInsetNoneWithScrollView:(UIScrollView *)scrollView {
    //新增对系统的判断
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;  //UIScrollView也适用
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.edgesForExtendedLayout = UIRectEdgeNone;
}


@end
