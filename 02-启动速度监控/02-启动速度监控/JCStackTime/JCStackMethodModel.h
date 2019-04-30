//
//  JCStackMethodModel.h
//  02-启动速度监控
//
//  Created by yellow on 2019/4/29.
//  Copyright © 2019 yellow. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCStackMethodModel : NSObject

/**
 记录方法时长
 */
@property (nonatomic, assign) float time;

/**
 记录方法名称
 */
@property (nonatomic, copy) NSString *methodName;

/**
 记录方法地址
 */
@property (nonatomic, copy) NSString *methodAddress;

@end

NS_ASSUME_NONNULL_END
