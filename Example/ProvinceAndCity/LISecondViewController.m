//
//  LISecondViewController.m
//  ProvinceAndCity_Example
//
//  Created by l on 09/05/2018.
//  Copyright © 2018 876637125@qq.com. All rights reserved.
//

#import "LISecondViewController.h"
#import <ProvinceAndCity/PCManager.h>
#import <ProvinceAndCity/ProvinceAndCityViewController.h>

@interface LISecondViewController ()<ProvinceAndCityViewControllerDelegate>
@property(nonatomic,strong) UIButton *btn;
@end

@implementation LISecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.backgroundColor = [UIColor redColor];
    [_btn addTarget:self action:@selector(selectorCityBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _btn.frame = CGRectMake(100, 100, 200, 100);
    [self.view addSubview:_btn];
    
    [self leftBarButton];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
/**
 省市列表
 */
-(void)leftBarButton{
    //开始定位
    PCManager *manger = [PCManager shareProvinceCityManager];
    manger.showViewController = self;
    [manger getLocationWithResult:^(NSString *city) {
        [_btn setTitle:city forState:UIControlStateNormal];
    }];
    //切换城市
    manger.changeBlock = ^(NSString *newCity) {
        NSLog(@"城市已切换到：%@",newCity);
        [_btn setTitle:newCity forState:UIControlStateNormal];
    };
}
-(void)selectorCityBtnClick
{
    ProvinceAndCityViewController *pcvc = [[ProvinceAndCityViewController alloc] init];
    pcvc.delegate = self;
    [self.navigationController pushViewController:pcvc animated:YES];
}
#pragma  mark - ProvinceAndCityViewControllerDelegate
-(void)changeCityWithSelectCity:(NSString *)aCity
{
    [_btn setTitle:aCity forState:UIControlStateNormal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
