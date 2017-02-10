//
//  GravityNameValue.h
//  GravityClient
//
//  Created by Balazs Kiss on 7/11/13.
//  Copyright (c) 2013 Balazs Kiss. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Simple name value pair
 */
@interface GravityNameValue : NSObject

/**
 Name
 */
@property NSString *name;

/**
 Value
 */
@property NSString *value;

/**
 Initializes a GravityNameValue object
 @param name the name
 @param value the value
 @return an initialized GravityNameValue object
 */
- (id)initWithName:(NSString *)name value:(NSString *)value;

/**
 Initializes a GravityNameValue object with a dictionary
 @param dict the dictionary representing the object
 @return an initialized GravityNameValue object
 */
- (id)initWithDictionary:(NSDictionary *)dict;

/**
 Returns GravityNameValue as a dictionary
 @return a dictionary representing the name value pair
 */
- (NSDictionary *)dictionary;

/**
 Returns a new GravityNameValue object
 @param name the name
 @param value the value
 @return an initialized GravityNameValue object
 */
+ (id)nameValueWithName:(NSString *)name value:(NSString *)value;

@end
