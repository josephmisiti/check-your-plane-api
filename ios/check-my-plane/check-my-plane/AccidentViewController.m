//
//  AccidentViewController.m
//  check-my-plane
//
//  Created by Joseph Misiti on 11/28/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "AccidentViewController.h"
#import "Accident.h"

static CGFloat kLeftMargin = 15.0f;


@interface AccidentViewController ()
-(void)_fillForms;
@end

@implementation AccidentViewController {
    UIWebView* _descriptionView;
}

@synthesize airplaneMake = _airplaneMake;
@synthesize registrationNumber = _registrationNumber;
@synthesize lastInspectionDate = _lastInspectionDate;
@synthesize numHoursLastInspection = _numHoursLastInspection;
@synthesize totalAmountOfHours = _totalAmountOfHours;
@synthesize descriptionButton = _descriptionButton;
@synthesize webViewContainer = _webViewContainer;
@synthesize accident = _accident;

#pragma mark - UIViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(kColorGrey);
    
    [self.view addSubview:self.airplaneMake];
    [self.view addSubview:self.registrationNumber];
    [self.view addSubview:self.lastInspectionDate];
    [self.view addSubview:self.numHoursLastInspection];
    [self.view addSubview:self.totalAmountOfHours];
    [self.view addSubview:self.descriptionButton];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self _fillForms];
    
    _descriptionView = [[UIWebView alloc] initWithFrame:self.view.frame];

}

#pragma mark - Private

-(void)_fillForms {
    self.airplaneMake.text = self.accident.aircraftMake;
    self.registrationNumber.text = self.accident.registrationNumber;
    self.lastInspectionDate.text = self.accident.lastInspectedDate;
    self.numHoursLastInspection.text = self.accident.amountHrsSinceLastInspection;
    self.totalAmountOfHours.text = self.accident.amountOfHours;
    
}

#pragma mark - Lazy Loading


-(UILabel*)airplaneMake {
    if(!_airplaneMake) {
        _airplaneMake = [[UILabel alloc] init];
        _airplaneMake.frame = CGRectMake(kLeftMargin, 15.0f, self.view.frame.size.width-2.0f*kLeftMargin, 50.0f);
        _airplaneMake.backgroundColor = [UIColor whiteColor];
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
        _registrationNumber.layer.cornerRadius = 10; // this value vary as per your desire
        _registrationNumber.clipsToBounds = YES;
        
    }
    return _registrationNumber;
}

-(UILabel*)lastInspectionDate {
    if(!_lastInspectionDate) {
        CGFloat yOffset = self.registrationNumber.frame.origin.y + self.registrationNumber.frame.size.height + 5.0f;
        _lastInspectionDate = [[UILabel alloc] init];
        _lastInspectionDate.frame = CGRectMake(kLeftMargin, yOffset, self.view.frame.size.width-2.0f*kLeftMargin, 50.0f);
        _lastInspectionDate.backgroundColor = [UIColor whiteColor];
        _lastInspectionDate.layer.cornerRadius = 10; // this value vary as per your desire
        _lastInspectionDate.clipsToBounds = YES;
        
    }
    return _lastInspectionDate;
}

-(UILabel*)numHoursLastInspection {
    if(!_numHoursLastInspection) {
        CGFloat yOffset = self.lastInspectionDate.frame.origin.y + self.lastInspectionDate.frame.size.height + 5.0f;
        _numHoursLastInspection = [[UILabel alloc] init];
        _numHoursLastInspection.frame = CGRectMake(kLeftMargin, yOffset, self.view.frame.size.width-2.0f*kLeftMargin, 50.0f);
        _numHoursLastInspection.backgroundColor = [UIColor whiteColor];
        _numHoursLastInspection.layer.cornerRadius = 10; // this value vary as per your desire
        _numHoursLastInspection.clipsToBounds = YES;
        
    }
    return _numHoursLastInspection;
}

-(UILabel*)totalAmountOfHours {
    if(!_totalAmountOfHours) {
        CGFloat yOffset = self.numHoursLastInspection.frame.origin.y + self.numHoursLastInspection.frame.size.height + 5.0f;
        _totalAmountOfHours = [[UILabel alloc] init];
        _totalAmountOfHours.frame = CGRectMake(kLeftMargin, yOffset, self.view.frame.size.width-2.0f*kLeftMargin, 50.0f);
        _totalAmountOfHours.backgroundColor = [UIColor whiteColor];
        _totalAmountOfHours.layer.cornerRadius = 10; // this value vary as per your desire
        _totalAmountOfHours.clipsToBounds = YES;
        
    }
    return _totalAmountOfHours;
}

-(UIButton*)descriptionButton {
    if(!_descriptionButton){
        CGFloat yOffset = self.totalAmountOfHours.frame.origin.y + self.totalAmountOfHours.frame.size.height + 5.0f;
        _descriptionButton = [[UIButton alloc] init];
        _descriptionButton.frame = CGRectMake(kLeftMargin, yOffset, self.view.frame.size.width-2.0f*kLeftMargin, 50.0f);
        _descriptionButton.backgroundColor = UIColorFromRGB(kColorPink);
        _descriptionButton.alpha = 0.5f;
        _descriptionButton.layer.cornerRadius = 10; // this value vary as per your desire
        _descriptionButton.clipsToBounds = YES;
        [_descriptionButton setTitle:@"Read Description" forState:UIControlStateNormal];
        _descriptionButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:25.0f];
        [_descriptionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_descriptionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_descriptionButton addTarget:self action:@selector(onClickReadDescription:)
                forControlEvents:UIControlEventTouchUpInside];

    }
    return _descriptionButton;
}

-(UIViewController*)webViewContainer{
    if(!_webViewContainer){
        _webViewContainer = [[UIViewController alloc] init];
    }
    return _webViewContainer;
}



-(void)onClickReadDescription:(id)sender {
    NSString* url = [NSString stringWithFormat:@"http://www.ntsb.gov/_layouts/ntsb.aviation/brief.aspx?ev_id=%@", self.accident.eventId];
    NSMutableURLRequest * request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_descriptionView loadRequest:request];
    [self.webViewContainer.view addSubview:_descriptionView];
    [self.navigationController pushViewController:self.webViewContainer animated:YES];
    
    
}

@end
