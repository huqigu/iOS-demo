//
//  JCStackTimeManager.m
//  02-启动速度监控
//
//  Created by yellow on 2019/4/29.
//  Copyright © 2019 yellow. All rights reserved.
//

#import "JCStackTimeManager.h"
#import "BSBacktraceLogger.h"
#import "JCStackMethodModel.h"

#define TimeTnterval 0.01

@interface JCStackTimeManager ()

/**
 记录的所有堆栈方法
 */
@property (nonatomic, strong) NSMutableArray<JCStackMethodModel *> *stackMethods;

/**
 定时器，间隔0.01秒抓取方法堆栈的所有方法
 */
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation JCStackTimeManager

#pragma mark - Public Methods
// 单例
+ (instancetype)sharedManager {
    static JCStackTimeManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[JCStackTimeManager alloc] init];
        }
    });
    return manager;
}

// 开始监控
- (void)startMonitor {
    // 清空上一次的记录
    [self.stackMethods removeAllObjects];
    // 开始定时器
    dispatch_resume(self.timer);
}

// 停止监控
- (void)stopMonitor:(void (^)(NSArray<JCStackMethodModel *> * _Nonnull))callback {
    // 停止定时器
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
    // 回调记录的所有堆栈方法
    // 避免不同线程访问同一数组
    callback([self.stackMethods copy]);
}


#pragma mark - Private Methods

/**
 处理抓取到的方法堆栈
 
 @param methodModels 当前定时间隔堆栈上的方法
 */
- (void)managerCurrentStackMethods:(NSArray<JCStackMethodModel *> *)methodModels {
    // 查看是否在记录中
    for (JCStackMethodModel *model in methodModels) {
        BOOL isExist = NO;
        for (JCStackMethodModel *existModel in self.stackMethods) {
            // 如果在记录中，时长+0.01
            if ([model.methodAddress isEqualToString:existModel.methodAddress]) {
                isExist = YES;
                existModel.time += TimeTnterval;
                break;
            }
        }
        // 如果不在记录中，加入记录中，并初始化时长为0.01
        if (!isExist) {
            model.time = TimeTnterval;
            [self.stackMethods addObject:model];
        }
    }
}

#pragma mark - Getter && Setter
- (NSMutableArray<JCStackMethodModel *> *)stackMethods {
    if (_stackMethods == nil) {
        _stackMethods = [NSMutableArray array];
    }
    return _stackMethods;
}

- (dispatch_source_t)timer {
    if (_timer == nil) {
        /**
         创建定时器运行在子线程
         */
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
        /**
         设置定时器
         */
        dispatch_source_set_timer(_timer, 0, TimeTnterval * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
        /**
         设置定时器任务
         */
        __weak typeof(self) weakSelf = self;
        dispatch_source_set_event_handler(_timer, ^{
            [weakSelf managerCurrentStackMethods:[BSBacktraceLogger bs_backtraceMapArrayOfMainThread]];
        });
        
    }
    return _timer;
}

@end
