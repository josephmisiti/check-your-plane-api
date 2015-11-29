//
//  AccidentViewController.h
//  check-my-plane
//
//  Created by Joseph Misiti on 11/28/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Accident;

@interface AccidentViewController : UIViewController

@property (nonatomic, strong) Accident* accident;

@property (nonatomic, strong) UILabel* airplaneMake;
@property (nonatomic, strong) UILabel* registrationNumber;
@property (nonatomic, strong) UILabel* lastInspectionDate;
@property (nonatomic, strong) UILabel* numHoursLastInspection;
@property (nonatomic, strong) UILabel* totalAmountOfHours;
@property (nonatomic, strong) UILabel* airplaneOwner;

@property (nonatomic, strong) UIButton* descriptionButton;
@property (nonatomic, strong) UIViewController* webViewContainer;


-(void)onClickReadDescription:(id)sender;

@end
