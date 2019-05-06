//
//  JCHook.m
//  09-无侵入埋点
//
//  Created by yellow on 2019/5/6.
//  Copyright © 2019 yellow. All rights reserved.
//

#import "JCHook.h"
#import <objc/runtime.h>

@implementation JCHook

+ (void)hookForClass:(Class)targetClass fromSelector:(SEL)fromSelector toSelector:(SEL)toSelector {
    
    Method fromMethod = class_getInstanceMethod(targetClass, fromSelector);
    
    Method toMethod = class_getInstanceMethod(targetClass, toSelector);
    
    // 返回成功则表示被替换的方法没有实现，先添加实现。返回失败则表示已实现，直接进行IMP指针交换
    if (class_addMethod(targetClass, fromSelector, method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        // 进行方法替换
        class_replaceMethod(targetClass, toSelector, method_getImplementation(fromMethod), method_getTypeEncoding(fromMethod));
    }else {
        // 交换IMP指针
        method_exchangeImplementations(fromMethod, toMethod);
    }
}

@end
