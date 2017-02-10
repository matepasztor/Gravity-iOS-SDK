//
//  GravityClient.m
//  GravityClient
//
//  Created by Balazs Kiss on 7/8/13.
//  Copyright (c) 2013 Balazs Kiss. All rights reserved.
//

#import "GravityClient.h"
#import "GravityItem.h"
#import "GravityRequest.h"
#import "GravityNameValue.h"
#import "GravityEvent.h"
#import "GravityItemRecommendation.h"
#import "GravityRecommendationContext.h"
#import "GravityUser.h"
#import "GravityScenarioInfo.h"

GravityResultOrder const GravityResultOrderPersonalized = @"personalized";
GravityResultOrder const GravityResultOrderRelevance = @"relevance";
GravityResultOrder const GravityResultOrderPopular = @"popular";

@interface GravityClient (){
    CLLocationManager *locationManager;
}
@end

@implementation GravityClient

- (id)init {
    self = [super init];
    if (self) {
        self.recommendedItems = [NSMutableDictionary dictionary];
        self.cookieId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [self trackLocation];
    }
    return self;
}

- (id)initWithURL:(NSString *)url {
    self = [self init];
    if (self) {
        self.baseURL = url;
    }
    return self;
}

- (id)initWithURL:(NSString *)url username:(NSString *)username password:(NSString *)password {
    self = [self init];
    if (self) {
        self.baseURL = url;
        self.username = username;
        self.password = password;
    }
    return self;
}

+ (NSString *)escapeString:(NSString *)aString {
    return [aString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (GravityRequest *)sendRequest:(GravityRequest *)request {
    [request send];
    return request;
}

- (GravityRequest *)sayHelloTo:(NSString *)name {
    name = [GravityClient escapeString:name];
    GravityRequest *request = [[GravityRequest alloc] initWithClient:self andType:GravityRequestTypeHello];
    request.method = @"test";
    [request.params addObject:[[GravityNameValue alloc] initWithName:@"name" value:name]];
    return [self sendRequest:request];
}

- (GravityRequest *)getItemRecommendations:(NSString *)scenarioId limit:(NSUInteger)limit resultNameValues:(NSArray *)nameValues {
    return [self getItemRecommendations:scenarioId limit:limit resultNameValues:nameValues attributes:nil];
}

- (GravityRequest *)getItemRecommendations:(NSString *)scenarioId limit:(NSUInteger)limit resultNameValues:(NSArray *)nameValues attributes:(NSArray *)attributes {
    GravityRequest *request = [[GravityRequest alloc] initWithClient:self andType:GravityRequestTypeRecommendation];
    request.method = @"getItemRecommendation";
    [self appendUserIdToRequest:request];
    [request.params addObject:[GravityNameValue nameValueWithName:@"scenarioId" value:scenarioId]];
    [request.params addObject:[GravityNameValue nameValueWithName:@"cookieId" value:self.cookieId]];
    [request.params addObject:[GravityNameValue nameValueWithName:@"numberLimit" value:[NSString stringWithFormat:@"%lu", (unsigned long)limit]]];
    for (NSString *nameValue in nameValues) {
        [request.params addObject:[GravityNameValue nameValueWithName:@"resultNameValue" value:nameValue]];
    }
    for (GravityNameValue *nameValue in attributes) {
        [request.params addObject:nameValue];
    }
    return [self sendRequest:request];
}

- (GravityRequest *)getItemRecommendationBulk:(GravityRecommendationContext *)context {
    //It is only one request with one context, therefore no need to call the bulk end point.
    return [self getItemRecommendations:context.scenarioId limit:context.limit resultNameValues:context.resultNameValues attributes:context.nameValues];
}

- (GravityRequest *)getItemRecommendationsBulk:(NSArray *)contexts {
    GravityRequest *request = [[GravityRequest alloc] initWithClient:self andType:GravityRequestTypeBulkRecommendation];
    request.method = @"getItemRecommendationBulk";
    [self appendUserIdToRequest:request];
    [request.params addObject:[GravityNameValue nameValueWithName:@"cookieId" value:self.cookieId]];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
    request.body = [GravityRecommendationContext contextsToJSON:contexts];
    return [self sendRequest:request];
}

- (GravityRequest *)searchItemsWithKeyword:(NSString *)keyword limit:(NSUInteger)limit resultNameValues:(NSArray *)nameValues{
    return [self searchItemsWithKeyword:keyword limit:limit resultNameValues:nameValues orderBy:GravityResultOrderPersonalized];
}

- (GravityRequest *)searchItemsWithKeyword:(NSString *)keyword limit:(NSUInteger)limit resultNameValues:(NSArray *)nameValues orderBy:(GravityResultOrder) order{
    keyword = [GravityClient escapeString:keyword];
    GravityRequest *request = [[GravityRequest alloc] initWithClient:self andType:GravityRequestTypeSearch];
    request.type = GravityRequestTypeRecommendation;
    request.method = @"getItemRecommendation";
    [self appendUserIdToRequest:request];
    [request.params addObject:[GravityNameValue nameValueWithName:@"scenarioId" value:@"LIVESEARCH"]];
    [request.params addObject:[GravityNameValue nameValueWithName:@"q" value:keyword]];
    [request.params addObject:[GravityNameValue nameValueWithName:@"cookieId" value:self.cookieId]];
    [request.params addObject:[GravityNameValue nameValueWithName:@"numberLimit" value:[NSString stringWithFormat:@"%i", (unsigned int)limit]]];
    [request.params addObject:[GravityNameValue nameValueWithName:@"orderBy" value:order]];
    for (NSString *nameValue in nameValues) {
        [request.params addObject:[GravityNameValue nameValueWithName:@"resultNameValue" value:nameValue]];
    }
    return [self sendRequest:request];
}

- (GravityRequest *)addEvent:(GravityEvent *)event {
    [event setLocation:self.location];
    NSLog(@"ev_loc_long: %f", self.location.coordinate.longitude);
    NSLog(@"ev_loc_lat: %f", self.location.coordinate.latitude);
    return [self addEvents:[[NSArray alloc] initWithObjects:event, nil]];
}

- (GravityRequest *)addEvents:(NSArray *)events {
    //[events setLocation:self.location];
    GravityRequest *request = [[GravityRequest alloc] initWithClient:self andType:GravityRequestTypeEvent];
    request.method = @"addEvents";
    [request.params addObject:[GravityNameValue nameValueWithName:@"async" value:@"true"]];
    request.body = [GravityEvent eventsToJSON:events];
    return [self sendRequest:request];
}

- (GravityRequest *)addItem:(GravityItem *)item {
    return [self addItems:[[NSArray alloc] initWithObjects:item, nil]];
}

- (GravityRequest *)addItems:(NSArray *)items {
    GravityRequest *request = [[GravityRequest alloc] initWithClient:self andType:GravityRequestTypeItem];
    request.method = @"addItems";
    [request.params addObject:[GravityNameValue nameValueWithName:@"async" value:@"true"]];
    request.body = [GravityItem itemsToJSON:items];
    return [self sendRequest:request];
}

- (GravityRequest *)updateItem:(GravityItem *)item {
    return [self updateItems:[[NSArray alloc] initWithObjects:item, nil]];
}

- (GravityRequest *)updateItems:(NSArray *)items {
    GravityRequest *request = [[GravityRequest alloc] initWithClient:self andType:GravityRequestTypeItem];
    request.method = @"updateItems";
    [request.params addObject:[GravityNameValue nameValueWithName:@"async" value:@"true"]];
    request.body = [GravityItem itemsToJSON:items];
    return [self sendRequest:request];
}

- (GravityRequest *)addUser:(GravityUser *)user {
    return [self addUsers:[[NSArray alloc] initWithObjects:user, nil]];
}

- (GravityRequest *)addUsers:(NSArray *)users {
    GravityRequest *request = [[GravityRequest alloc] initWithClient:self andType:GravityRequestTypeUser];
    request.method = @"addUsers";
    [request.params addObject:[GravityNameValue nameValueWithName:@"async" value:@"true"]];
    request.body = [GravityUser usersToJSON:users];
    return [self sendRequest:request];
}

- (GravityRequest *)getAllScenarioInfo {
    GravityRequest *request = [[GravityRequest alloc] initWithClient:self andType:GravityRequestTypeScenarioInfo];
    request.method = @"scenarioInfo";
    return [self sendRequest:request];
}

- (void)appendUserIdToRequest:(GravityRequest*)request {
    if(self.userId) {
        [request.params addObject:[GravityNameValue nameValueWithName:@"userId" value:self.userId]];
    }
}

#pragma mark CLLocationManagerDelegate methods

- (void)trackLocation{
    if(locationManager == nil) {
        locationManager =[[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        //NSLog(@"trackLocation");
    }
    [locationManager requestWhenInUseAuthorization];
    [locationManager startMonitoringSignificantLocationChanges];
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"CoreLocation error");
}

 
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //NSLog(@"didUpdateLocations");
    CLLocation *location = [locations lastObject];
    [self setLocation:location];
    [locationManager stopUpdatingLocation];
}

@end
