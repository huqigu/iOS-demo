//
//  JCBaseViewController.m
//  09-无侵入埋点
//
//  Created by yellow on 2019/5/6.
//  Copyright © 2019 yellow. All rights reserved.
//

#import "JCBaseViewController.h"
#import "JCHook.h"

@implementation JCBaseViewController

#pragma mark - initialize
+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [JCHook hookForClass:self fromSelector:@selector(viewWillAppear:) toSelector:@selector(hook_viewWillAppear:)];
        [JCHook hookForClass:self fromSelector:@selector(viewWillDisappear:) toSelector:@selector(hook_viewWillDisappear:)];
    });
}

#pragma mark - hook method
- (void)hook_viewWillAppear:(BOOL)animated {
    // 埋点代码
    [self insertViewWillAppear];
    // 调用原方法
    [self hook_viewWillAppear:animated];
}

- (void)hook_viewWillDisappear:(BOOL)animated {
    [self insertViewWillDisappear];
    [self hook_viewWillDisappear:animated];
}

#pragma mark - private Methods
- (void)insertViewWillAppear {
    NSLog(@"%@ && %s",NSStringFromClass([self class]),__func__);
}

- (void)insertViewWillDisappear {
    NSLog(@"%@ && %s",NSStringFromClass([self class]),__func__);
}

@end
