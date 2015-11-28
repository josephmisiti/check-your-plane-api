//
//  Accident.h
//  check-my-plane
//
//  Created by Joseph Misiti on 11/28/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Accident : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *eventId;
@property (nonatomic, copy, readonly) NSString *registrationNumber;
@property (nonatomic, copy, readonly) NSString *accidentInfo;

@end
