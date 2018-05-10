//
//  PCManager.h
//  Sgzx
//
//  Created by l on 08/05/2018.
//  Copyright © 2018 doctorplusone. All rights reserved.
//

#import <Foundation/Foundation.h>
#define Province_City_URL @"http://service3.99melove.cn/YSJDoctor-service/service/rest/app.Parameter/collection/getCity"
typedef void (^LocationResult)(NSString *city);
typedef void (^SuccessLoadHandle)(NSDictionary *respones);
typedef void (^Failure)(NSError *error);
typedef void (^CityChangedBlock)(NSString *newCity);
@interface PCManager : NSObject
@property(nonatomic,strong) NSString *selectedCity;//已选择的城市
@property(nonatomic,copy) CityChangedBlock changeBlock;//用户所在城市发生改变
@property(nonatomic,weak) id showViewController;//显示所在的viewcontrol
@property(nonatomic,assign) int AuthorizationStatus;

+(instancetype)shareProvinceCityManager;
/**
 初始化

 @param aKey 百度地图appkey
 @return 实例
 */
+(instancetype)shareProvinceCityManagerWithLocationAppKey:(NSString *)aKey;

/**
 获取省市列表

 @param successBlock 成功
 @param failBlock 失败
 */
-(void)getProvinceCityListSuccessBlock:(SuccessLoadHandle)successBlock failBlock:(Failure)failBlock;

/**
 获取定位

 @param aLocationResult 定位结果
 */
-(void)getLocationWithResult:(LocationResult)aLocationResult;

@end
