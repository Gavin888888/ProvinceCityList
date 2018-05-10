//
//  ProvinceAndCityViewController.m
//  Sgzx
//
//  Created by l on 08/05/2018.
//  Copyright © 2018 doctorplusone. All rights reserved.
//

#import "ProvinceAndCityViewController.h"
#import "PCManager.h"
@interface ProvinceAndCityViewController ()
@property(nonatomic,strong) PCManager *pcmanager;
@property(nonatomic,strong) NSMutableArray *dataSources;
@property(nonatomic,assign) int province_index;
@property(nonatomic,assign) int city_index;
@end

@implementation ProvinceAndCityViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pcmanager = [PCManager shareProvinceCityManager];
    }
    return self;
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if ([_delegate respondsToSelector:@selector(changeCityWithSelectCity:)]) {
        [_delegate changeCityWithSelectCity:_pcmanager.selectedCity];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"选择地区";
    if (_pcmanager.selectedCity) {
        _selectedCityLabel.text = [NSString stringWithFormat:@"当前城市：%@",_pcmanager.selectedCity];
    }
    [_provinceTableView registerClass:NSClassFromString(@"UITableViewCell") forCellReuseIdentifier:@"provinceCell"];
    [_cityTableView registerClass:NSClassFromString(@"UITableViewCell") forCellReuseIdentifier:@"cityCell"];
    UIView *province_footview = [[UIView alloc] init];
    _provinceTableView.tableFooterView = province_footview;
    UIView *city_footview = [[UIView alloc] init];
    _cityTableView.tableFooterView = city_footview;
    [self loadProvinceCity];
}
- (IBAction)restartLocation:(id)sender {
    if (_pcmanager.AuthorizationStatus == 2) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有获取坐标的权限，是否去设置？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *submitAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:appSettings];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:submitAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }else
    {
        [_pcmanager getLocationWithResult:^(NSString *city) {
            if (city) {
                _selectedCityLabel.text = [NSString stringWithFormat:@"当前城市：%@",city];
            }
        }];
    }
}
-(void)loadProvinceCity
{
    [_pcmanager getProvinceCityListSuccessBlock:^( NSDictionary *dataDic) {
        _dataSources = dataDic[@"citys"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_provinceTableView reloadData];
            [_cityTableView reloadData];
        });
    } failBlock:^(NSError * _Nullable ysjError) {
        
    }];
}
#pragma mark - UITableViewDelegate and UITableViewDataSource
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_provinceTableView]) {
        return _dataSources.count;
    }else
    {
        NSDictionary *children = _dataSources[_province_index];
        NSArray *cityArray = children[@"children"];
        return cityArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_provinceTableView]) {
        NSDictionary *province = _dataSources[indexPath.row];
        NSString *province_name = province[@"text"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"provinceCell"];
        cell.textLabel.text = province_name;
        cell.backgroundColor = [UIColor colorWithRed:227.0/255 green:225.0/255  blue:226.0/255  alpha:1];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        return cell;
    }else
    {
        NSDictionary *children = _dataSources[_province_index];
        NSArray *cityArray = children[@"children"];
        NSDictionary *city = cityArray[indexPath.row];
        NSString *city_name = city[@"text"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell"];
        cell.textLabel.text = city_name;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_provinceTableView]) {
        _province_index = (int)indexPath.row;
        [_cityTableView reloadData];
    }else
    {
        NSDictionary *children = _dataSources[_province_index];
        NSArray *cityArray = children[@"children"];
        NSDictionary *city = cityArray[indexPath.row];
        NSString *city_name = city[@"text"];
        _pcmanager.selectedCity = city_name;
        _selectedCityLabel.text = [NSString stringWithFormat:@"当前城市：%@",_pcmanager.selectedCity];
    }
}

@end
