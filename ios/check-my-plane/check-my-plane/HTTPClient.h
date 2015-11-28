//
//  HTTPClient.h
//  check-my-plane
//
//  Created by Joseph Misiti on 11/28/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

typedef void (^MAPHTTPClientSuccess)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^MAPHTTPClientFailure)(AFHTTPRequestOperation *operation, NSError *error);


@interface HTTPClient : AFHTTPRequestOperationManager

+ (HTTPClient *)sharedClient;

- (void)searchRegistrationNumber:(NSDictionary *)params
               success:(MAPHTTPClientSuccess)success
               failure:(MAPHTTPClientFailure)failure;

@end
