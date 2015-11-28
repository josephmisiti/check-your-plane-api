//
//  Accident.m
//  check-my-plane
//
//  Created by Joseph Misiti on 11/28/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "Accident.h"

@implementation Accident

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"eventId" : @"EventId",
        @"registrationNumber" : @"RegistrationNumber",
        @"accidentInfo" : @"Description",
    };
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}


- (NSString *)description {
    return [NSString stringWithFormat:
            @"Accident: %@ %@ %@",
            self.eventId, self.registrationNumber, self.accidentInfo];
}



@end
