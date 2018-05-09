//
//  PCManager.m
//  Sgzx
//
//  Created by l on 08/05/2018.
//  Copyright © 2018 doctorplusone. All rights reserved.
//

#import "PCManager.h"
#import <BMKLocationkit/BMKLocationComponent.h>
#import <BMKLocationKit/BMKLocationAuth.h>
@interface PCManager ()<BMKLocationManagerDelegate,BMKLocationAuthDelegate>
@property(nonatomic,strong) BMKLocationManager *locationManager;
@end
@implementation PCManager
+(instancetype)shareProvinceCityManager
{
    static dispatch_once_t onceToken;
    static PCManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[PCManager alloc] init];
        [[BMKLocationAuth sharedInstance] checkPermisionWithKey:@"gjlnrQUTUawHT6GAkrpKO50z2ElPem6I" authDelegate:self];

    });
    return manager;
}
-(void)getLocationWithResult:(LocationResult)aLocationResult
{
    //初始化实例
    _locationManager = [[BMKLocationManager alloc] init];
    //设置delegate
    _locationManager.delegate = self;
    //设置返回位置的坐标系类型
    _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    //设置距离过滤参数
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    //设置预期精度参数
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //设置应用位置类型
    _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    //设置是否自动停止位置更新
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    //设置是否允许后台定位
    _locationManager.allowsBackgroundLocationUpdates = YES;
    //设置位置获取超时时间
    _locationManager.locationTimeout = 10;
    //设置获取地址信息超时时间
    _locationManager.reGeocodeTimeout = 10;
    //开始定位
    [_locationManager requestLocationWithReGeocode:YES withNetworkState:YES completionBlock:^(BMKLocation * _Nullable location, BMKLocationNetworkState state, NSError * _Nullable error) {
        _selectedCity = location.rgcData.city;
        aLocationResult(_selectedCity);
    }];
}
#pragma mark - BMKLocationAuthDelegate
- (void)onCheckPermissionState:(BMKLocationAuthErrorCode)iError
{
    
}
#pragma mark - BMKLocationManagerDelegate
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didFailWithError:(NSError * _Nullable)error
{
    
}
/**
 *  @brief 定位权限状态改变时回调函数
 *  @param manager 定位 BMKLocationManager 类。
 *  @param status 定位权限状态。
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
}
-(void)getProvinceCityListSuccessBlock:(SuccessLoadHandle)successBlock failBlock:(Failure)failBlock
{
    NSString *url_str = @"http://service3.99melove.cn/YSJDoctor-service/service/rest/app.Parameter/collection/getCity";
    NSURL *url = [NSURL URLWithString:url_str];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
        if (dict) {
            successBlock(dict);
        }else{
            failBlock(nil);
        }
    }];
    [sessionDataTask resume];
}
@end