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
    };
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}

@end
