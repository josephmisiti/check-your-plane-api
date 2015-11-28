//
//  QueryViewController.m
//  check-my-plane
//
//  Created by Joseph Misiti on 11/28/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "QueryViewController.h"
#import "HTTPClient.h"
#import "AccidentViewController.h"
#import "Accident.h"

@implementation QueryViewController {
    HTTPClient *_httpClient;
    AccidentViewController* _accidentViewController;
}

@synthesize inputLabel = _inputLabel;
@synthesize inputField = _inputField;
@synthesize submitButton = _submitButton;

static CGFloat kLeftMargin = 15.0f;

#pragma mark - UIViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(kColorGrey);
    [self.view addSubview:self.inputLabel];
    [self.view addSubview:self.inputField];
    [self.view addSubview:self.submitButton];
    
    _httpClient = [HTTPClient sharedClient];
    _accidentViewController = [[AccidentViewController alloc] init];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Lazy Loading

-(UILabel*)inputLabel {
    if(!_inputLabel) {
        _inputLabel = [[UILabel alloc] init];
        _inputLabel.frame = CGRectMake(kLeftMargin, 15.0f, self.view.frame.size.width-2.0f*kLeftMargin, 50.0f);
        _inputLabel.backgroundColor = [UIColor clearColor];
    
    }
    return _inputLabel;
}

-(UITextField*)inputField {
    if(!_inputField) {
        CGFloat yOffset = self.inputLabel.frame.origin.y + self.inputLabel.frame.size.height + 5.0f;
        _inputField = [[UITextField alloc] init];
        _inputField.frame = CGRectMake(kLeftMargin, yOffset, self.view.frame.size.width-2.0f*kLeftMargin, 50.0f);
        _inputField.backgroundColor = [UIColor whiteColor];
        _inputField.placeholder = @"Enter registration number (starts with N)";
        _inputField.layer.cornerRadius = 10; // this value vary as per your desire
        _inputField.clipsToBounds = YES;
        
        _inputField.text = @"N8373L";
    }
    return _inputField;
}

-(UIButton*)submitButton {
    if(!_submitButton) {
        CGFloat yOffset = self.inputField.frame.origin.y + self.inputField.frame.size.height + 5.0f;
        _submitButton = [[UIButton alloc] init];
        _submitButton.frame = CGRectMake(kLeftMargin, yOffset, self.view.frame.size.width-2.0f*kLeftMargin, 50.0f);
        _submitButton.backgroundColor = UIColorFromRGB(kColorPink);
        _submitButton.alpha = 0.5f;
        _submitButton.layer.cornerRadius = 10; // this value vary as per your desire
        _submitButton.clipsToBounds = YES;
        [_submitButton setTitle:@"Check My Plane" forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:25.0f];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_submitButton addTarget:self action:@selector(onSubmitQuery:)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}


#pragma mark - Clicks

-(void)onSubmitQuery:(id)sender {
    NSLog(@"--- onSubmitQuery");
    NSDictionary* params =  @{ @"registration_number" : self.inputField.text };
    [_httpClient searchRegistrationNumber:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary = (NSDictionary *)responseObject;
        NSLog(@"%@", dictionary);
        Accident *accident;
        for (NSDictionary *accidentDictionary in [dictionary objectForKey:@"Objects"]) {
            NSError *error = nil;
            accident = [MTLJSONAdapter modelOfClass:Accident.class fromJSONDictionary:accidentDictionary error:&error];
            NSLog(@"%@",accident);
        }
        
        [_accidentViewController setAccident:accident];
        [self.navigationController pushViewController:_accidentViewController animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
    
    
    
    
}

@end
