//
//  ViewController.m
//  02-启动速度监控
//
//  Created by yellow on 2019/4/29.
//  Copyright © 2019 yellow. All rights reserved.
//

#import "ViewController.h"
#import "JCStackTimeManager.h"
#import "JCStackMethodModel.h"
#import "BSBacktraceLogger.h"
@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[JCStackTimeManager sharedManager] startMonitor];
    
    [self testMethod];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[JCStackTimeManager sharedManager] stopMonitor:^(NSArray<JCStackMethodModel *> * methodModels) {
        for (JCStackMethodModel *model in methodModels) {
            NSLog(@"%@ -- %f",model.methodName,model.time);
        }
    }];
}

#pragma mark - Private Methods
- (void)testMethod {
    
    sleep(3.0);
}



@end
