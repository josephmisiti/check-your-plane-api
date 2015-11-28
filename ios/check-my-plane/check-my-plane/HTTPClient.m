//
//  HTTPClient.m
//  check-my-plane
//
//  Created by Joseph Misiti on 11/28/15.
//  Copyright © 2015 Math And Pencil LLC. All rights reserved.
//

#import "HTTPClient.h"

@implementation HTTPClient

+ (HTTPClient *)sharedClient {
    static HTTPClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[self alloc] init];
        NSMutableSet *newSet=[NSMutableSet set];
        newSet.set = sharedClient.responseSerializer.acceptableContentTypes;
        [newSet addObject:@"text/html"];
        [newSet addObject:@"application/json"];
        [newSet addObject:@"text/json"];
        [newSet addObject:@"text/javascript"];
        [newSet addObject:@"text/plain"];
        sharedClient.responseSerializer.acceptableContentTypes = newSet;
    });
    return sharedClient;
}

- (void)searchRegistrationNumber:(NSDictionary *)params
                         success:(MAPHTTPClientSuccess)success
                         failure:(MAPHTTPClientFailure)failure {
    
    
    NSString* url = kQueryURL;
    if([params objectForKey:@"registration_number"]){
        url = [NSString stringWithFormat:kDetailsURL, [params objectForKey:@"registration_number"]];
    }
    NSLog(@"%@", url);
    [self GET:url parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject){
          if(success){
              success((AFHTTPRequestOperation *)operation, responseObject);
          }
          
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
              failure((AFHTTPRequestOperation *)operation, error);
          }
      }];

}

@end
