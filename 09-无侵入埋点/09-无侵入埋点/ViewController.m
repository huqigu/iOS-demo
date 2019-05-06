//
//  ViewController.m
//  09-无侵入埋点
//
//  Created by yellow on 2019/5/6.
//  Copyright © 2019 yellow. All rights reserved.
//

#import "ViewController.h"
#import "JCBaseButton.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    for (int i = 0; i < 3; i ++) {
        CGFloat btnY = 100 + 100 * i;
        JCBaseButton *button = [[JCBaseButton alloc] init];
        button.frame = CGRectMake((self.view.frame.size.width - 100) / 2.0, btnY, 100, 50);
        button.tag = i;
        button.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:button];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)btnClick:(UIButton *)btn {
    UIViewController *vc;
    switch (btn.tag) {
        case 0:
            vc = [[FirstViewController alloc] init];
            break;
        case 1:
            vc = [[SecondViewController alloc] init];
            break;
        case 2:
            vc = [[ThirdViewController alloc] init];
            break;
        default:
            vc = [[JCBaseViewController alloc] init];
            break;
    }
    [self presentViewController:vc animated:YES completion:nil];
}

@end
