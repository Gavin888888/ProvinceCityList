//
//  LIViewController.m
//  ProvinceAndCity
//
//  Created by 876637125@qq.com on 05/08/2018.
//  Copyright (c) 2018 876637125@qq.com. All rights reserved.
//

#import "LIViewController.h"
#import "LISecondViewController.h"
@interface LIViewController ()

@end

@implementation LIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{LISecondViewController *secondVc = [[LISecondViewController alloc] init];
        
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:secondVc];
        [self presentViewController:navi animated:YES completion:nil];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
