//
//  PCManager.h
//  Sgzx
//
//  Created by l on 08/05/2018.
//  Copyright © 2018 doctorplusone. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^LocationResult)(NSString *city);
typedef void (^SuccessLoadHandle)(NSDictionary *respones);
typedef void (^Failure)(NSError *error);
@interface PCManager : NSObject
@property(nonatomic,strong) NSString *selectedCity;//已选择的城市
+(instancetype)shareProvinceCityManager;
/**
 获取省市列表

 @param successBlock 成功
 @param failBlock 失败
 */
-(void)getProvinceCityListSuccessBlock:(SuccessLoadHandle)successBlock failBlock:(Failure)failBlock;
//获取定位
-(void)getLocationWithResult:(LocationResult)aLocationResult;
@end
