//
//  JCBaseButton.m
//  09-无侵入埋点
//
//  Created by yellow on 2019/5/6.
//  Copyright © 2019 yellow. All rights reserved.
//

#import "JCBaseButton.h"
#import "JCHook.h"

@implementation JCBaseButton
#pragma mark - initialize
+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [JCHook hookForClass:self fromSelector:@selector(sendAction:to:forEvent:) toSelector:@selector(hook_sendAction:to:forEvent:)];
    });
}

#pragma mark - hook method
- (void)hook_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [self insertSendAction:action to:target forEvent:event];
    [self hook_sendAction:action to:target forEvent:event];
}

#pragma mark - private Methods
- (void)insertSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    // 获取当前button在父视图上的节点
    NSInteger index = 0;
    for (UIView *subView in self.superview.subviews) {
        if (subView == self) {
            break;
        }
        index ++;
    }
    // 以action、target、index结合组成按钮的唯一标识
    NSLog(@"action = %@ && target = %@ && btnIndex = %ld ",NSStringFromSelector(action),target,(long)index);
}

@end
