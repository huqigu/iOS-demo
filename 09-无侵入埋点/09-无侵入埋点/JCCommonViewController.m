//
//  JCCommonViewController.m
//  09-无侵入埋点
//
//  Created by yellow on 2019/5/6.
//  Copyright © 2019 yellow. All rights reserved.
//

#import "JCCommonViewController.h"
#import "JCBaseButton.h"

@interface JCCommonViewController ()

@end

@implementation JCCommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    JCBaseButton *btn = [[JCBaseButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(commonBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)commonBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
