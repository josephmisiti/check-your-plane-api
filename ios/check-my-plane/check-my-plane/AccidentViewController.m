//
//  AccidentViewController.m
//  check-my-plane
//
//  Created by Joseph Misiti on 11/28/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "AccidentViewController.h"

static CGFloat kLeftMargin = 15.0f;


@interface AccidentViewController ()

@end

@implementation AccidentViewController

@synthesize airplaneMake = _airplaneMake;
@synthesize registrationNumber = _registrationNumber;

#pragma mark - UIViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(kColorGrey);
    
    [self.view addSubview:self.airplaneMake];
    [self.view addSubview:self.registrationNumber];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Lazy Loading


-(UILabel*)airplaneMake {
    if(!_airplaneMake) {
        _airplaneMake = [[UILabel alloc] init];
        _airplaneMake.frame = CGRectMake(kLeftMargin, 15.0f, self.view.frame.size.width-2.0f*kLeftMargin, 50.0f);
        _airplaneMake.backgroundColor = [UIColor whiteColor];
        _airplaneMake.text = @"Southwest Airlines";
        _airplaneMake.layer.cornerRadius = 10; // this value vary as per your desire
        _airplaneMake.clipsToBounds = YES;
    }
    return _airplaneMake;
}

-(UILabel*)registrationNumber {
    if(!_registrationNumber) {
        CGFloat yOffset = self.airplaneMake.frame.origin.y + self.airplaneMake.frame.size.height + 5.0f;

        _registrationNumber = [[UILabel alloc] init];
        _registrationNumber.frame = CGRectMake(kLeftMargin, yOffset, self.view.frame.size.width-2.0f*kLeftMargin, 50.0f);
        _registrationNumber.backgroundColor = [UIColor whiteColor];
        _registrationNumber.text = @"Southwest Airlines";
        _registrationNumber.layer.cornerRadius = 10; // this value vary as per your desire
        _registrationNumber.clipsToBounds = YES;
        
    }
    return _registrationNumber;
}

@end
