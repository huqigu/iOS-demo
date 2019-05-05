//
//  ViewController.m
//  05-加载bundle中的动态库
//
//  Created by yellow on 2019/5/5.
//  Copyright © 2019 yellow. All rights reserved.
//

#import "ViewController.h"
#include <dlfcn.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 包含动态库的bundle路径
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"dyld" ofType:@"bundle"];
    // framework的路径
    NSString *frameworkPath = [[NSBundle bundleWithPath:bundlePath] pathForResource:@"Test" ofType:@"framework"];
    // 动态库中可执行文件的真实路径
    NSString *dyldFilePath = [frameworkPath stringByAppendingString:@"/Test"];
    
    // 以指定模式打开指定的动态链接库文件，并返回一个句柄
    // 不同的模式的详细介绍见dlopen百度百科
    void *handle = dlopen([dyldFilePath UTF8String], RTLD_LAZY);
    // handle == null 表示打开动态库失败，dlerror能获取到失败的信息
    if (!handle) {
        NSLog(@"dlopen error == %s",dlerror());
    }
    NSLog(@"dlopen = %s",handle);
    
    
    // 定义函数
    void(*pMytest)(int);
    // 通过"mytest"符号找到其对应的函数
    pMytest = dlsym(handle, "mytest");
    // pMytest == null 表示没有找到符号对应的地址，dlerror能获取到失败的信息
    if (!pMytest) {
        NSLog(@"dlsym error == %s",dlerror());
    }else {
        NSLog(@"dlsym = %s",dlsym(handle, "mytest"));
        // 调用函数
        pMytest(5);
    }
    
    
    // runtime调用oc方法
    [self runtimeCallMethod];
    
}

// 可以试试把该方法的调用放到dlopen之前，看看有什么区别
- (void)runtimeCallMethod {
    Class Boy = NSClassFromString(@"Boy");
    id boy = [[Boy alloc] init];
    
    SEL boySaySel = NSSelectorFromString(@"say");
    
    [boy performSelector:boySaySel withObject:nil afterDelay:0];
}


@end
