//
//  QueryViewController.h
//  check-my-plane
//
//  Created by Joseph Misiti on 11/28/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueryViewController : UIViewController


@property (nonatomic, strong) NSMutableArray* accidentsArray;
@property (nonatomic, strong) UILabel* inputLabel;
@property (nonatomic, strong) UITextField* inputField;
@property (nonatomic, strong) UIButton* submitButton;

-(void)onSubmitQuery:(id)sender;

@end
