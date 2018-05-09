//
//  ProvinceAndCityViewController.h
//  Sgzx
//
//  Created by l on 08/05/2018.
//  Copyright © 2018 doctorplusone. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ProvinceAndCityViewControllerDelegate;
@interface ProvinceAndCityViewController : UIViewController
@property(nonatomic,weak) id<ProvinceAndCityViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *selectedCityLabel;
@property (weak, nonatomic) IBOutlet UITableView *provinceTableView;
@property (weak, nonatomic) IBOutlet UITableView *cityTableView;
- (IBAction)restartLocation:(id)sender;
@end
@protocol ProvinceAndCityViewControllerDelegate <NSObject>
-(void)changeCityWithSelectCity:(NSString *)aCity;
@end

