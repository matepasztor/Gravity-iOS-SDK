//
//  GravityEvent.h
//  GravityClient
//
//  Created by Balazs Kiss on 7/8/13.
//  Copyright (c) 2013 Balazs Kiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"

/**
 An event that can be sent to a Gravity service
 */
@interface GravityEvent : NSObject

/**
 The relevant item ID
 */
@property NSString *itemId;

/**
 The ID of the user
 */
@property NSString *userId;

/**
 The cookieID of the user
 */
@property NSString *cookieId;

/**
 Type of event
 */
@property NSString *type;

/**
 Extra GravityNameValue parameters
 */
@property NSMutableArray *nameValues;

/**
 Converts a GravityEvent array to JSON
 */
+ (NSData *)eventsToJSON:(NSArray *)events;

- (void)setLocation:(CLLocation *)location;

@end
