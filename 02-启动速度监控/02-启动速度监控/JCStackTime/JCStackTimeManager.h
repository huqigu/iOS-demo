//
//  JCStackTimeManager.h
//  02-启动速度监控
//
//  Created by yellow on 2019/4/29.
//  Copyright © 2019 yellow. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JCStackMethodModel;

NS_ASSUME_NONNULL_BEGIN

@interface JCStackTimeManager : NSObject

+ (instancetype)sharedManager;

/**
 开始监控
 */
- (void)startMonitor;


/**
 停止监控

 @param callback 监控到的所有方法时长，误差0.01秒
 */
- (void)stopMonitor:(void(^)(NSArray<JCStackMethodModel *> *))callback;

@end

NS_ASSUME_NONNULL_END
