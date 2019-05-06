//
//  JCBaseTableView.m
//  09-无侵入埋点
//
//  Created by yellow on 2019/5/6.
//  Copyright © 2019 yellow. All rights reserved.
//

#import "JCBaseTableView.h"
#import "JCHook.h"
#import <objc/runtime.h>

@implementation JCBaseTableView
#pragma mark - initialize
+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method method = class_getInstanceMethod(self, @selector(_selectRowAtIndexPath:animated:scrollPosition:notifyDelegate:));
        
        [self analysisMethod:method];
        
        [JCHook hookForClass:self fromSelector:@selector(_selectRowAtIndexPath:animated:scrollPosition:notifyDelegate:) toSelector:@selector(hook_selectRowAtIndexPath:animated:scrollPosition:notifyDelegate:)];
    });
}

#pragma mark - hook method

- (void)hook_selectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition notifyDelegate:(BOOL)notifyDelegate {
    [self insertTableViewDidSelectIndexPath:indexPath];
    [self hook_selectRowAtIndexPath:indexPath animated:animated scrollPosition:scrollPosition notifyDelegate:notifyDelegate];
}

#pragma mark - private Methods
- (void)insertTableViewDidSelectIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",indexPath);
}

+ (void)analysisMethod:(Method)method {
    // 获取方法的参数类型
    unsigned int argumentsCount = method_getNumberOfArguments(method);
    char argName[512] = {};
    for (unsigned int j = 0; j < argumentsCount; ++j) {
        method_getArgumentType(method, j, argName, 512);
        
        NSLog(@"第%u个参数类型为：%s", j, argName);
        memset(argName, '\0', strlen(argName));
    }
    
    char returnType[512] = {};
    method_getReturnType(method, returnType, 512);
    NSLog(@"返回值类型：%s", returnType);
    
    // type encoding
    NSLog(@"TypeEncoding: %s", method_getTypeEncoding(method));
}

@end
