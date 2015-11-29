//
//  AccidentList.m
//  check-my-plane
//
//  Created by Joseph Misiti on 11/29/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "AccidentList.h"
#import "Accident.h"
#import "AccidentViewController.h"

@interface AccidentList ()

@end

@implementation AccidentList {
    AccidentViewController* _accidentViewController;
}

@synthesize accidentsArray = _accidentsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(kColorGrey);
    _accidentViewController = [[AccidentViewController alloc] init];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.separatorColor = [UIColor blackColor];

    self.title = @"Accident List";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.accidentsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BFCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BFCell"];
    }
    
    Accident *accident = [self.accidentsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = accident.owner;
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Accident *accident = [self.accidentsArray objectAtIndex:indexPath.row];
    [_accidentViewController setAccident:accident];
    [self.navigationController pushViewController:_accidentViewController animated:YES];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

@end
