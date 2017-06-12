//
//  MSULocationController.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/5/26.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LocationCityBlock)(NSString *locaCity);

@interface MSULocationController : UIViewController

@property (nonatomic , copy) LocationCityBlock locationCityBlock;
@end
