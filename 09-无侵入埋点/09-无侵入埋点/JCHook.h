//
//  JCHook.h
//  09-无侵入埋点
//
//  Created by yellow on 2019/5/6.
//  Copyright © 2019 yellow. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCHook : NSObject

+ (void)hookForClass:(Class)targetClass fromSelector:(SEL)fromSelector toSelector:(SEL)toSelector;

@end

NS_ASSUME_NONNULL_END
