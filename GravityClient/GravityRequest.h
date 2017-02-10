//
//  GravityRequest.h
//  GravityClient
//
//  Created by Balazs Kiss on 7/11/13.
//  Copyright (c) 2013 Balazs Kiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GravityClient;
@class GravityRequest;
@class GravityItemRecommendation;

enum {
    GravityRequestTypeHello = 0,
    GravityRequestTypeRecommendation,
    GravityRequestTypeBulkRecommendation,
    GravityRequestTypeSearch,
    GravityRequestTypeEvent,
    GravityRequestTypeScenarioInfo,
    GravityRequestTypeUser,
    GravityRequestTypeItem
};
typedef NSUInteger GravityRequestType;

typedef void (^GravityRequestCompletionHandler)(GravityRequest *);

/**
 A request to the Gravity service
 */
@interface GravityRequest : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

/**
 Type of the request
 */
@property GravityRequestType type;

/**
 The called method
 */
@property NSString *method;

/**
 URL parameters of the request
 */
@property NSMutableArray *params;

/**
 Body of the request
 */
@property NSData *body;

/**
 The relevant connection object
 */
@property NSURLConnection *connection;

/**
 Response of the server
 */
@property NSMutableData *response;

/**
 The request is completed or not
 */
@property (readonly, getter = isCompleted) BOOL completed;

/**
 The received recommendation
 */
@property (readonly) GravityItemRecommendation *itemRecommendation;
@property (readonly) NSMutableArray *itemRecommendations;

/**
 Completion handler of the request
 */
@property (nonatomic, copy) GravityRequestCompletionHandler completionHandler;

/**
 Initalizes a GravityRequest connection with an URL
 @param client the GravityClient
 @param type the GravityRequestType
 @return an initialized GravityRequest object
 */
- (id) initWithClient:(GravityClient *)client andType:(GravityRequestType)type;

/**
 Sends the GravityRequest of the GravityClient
 */
- (void) send;


@end
