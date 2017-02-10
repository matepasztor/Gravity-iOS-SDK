//
//  GravityUser.h
//  GravityClient
//
//  Created by Laszlo Fanaczan on 23/06/16.
//  Copyright © 2016 fea. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 User
 */
@interface GravityUser : NSObject

/**
 Id of the user
 */
@property NSString *userId;

/**
 cookieId of the user
 */
@property NSString *cookieId;


/**
 Visibilty flag of the user
 */
@property BOOL hidden;

/**
 The NameValues for the user
 */
@property NSArray *nameValues;

/**
 Initializes a GravityUser object with a dictionary
 @param dict the dictionary representing the object
 @return an initialized GravityScenarioInfo object
 */
- (id)initWithDictionary:(NSDictionary *)dict;

/**
 Initializes a GravityUser object with JSON data
 @param jsonData the JSON data representing the object
 @return an initialized GravityScenarioInfo object
 */
- (id)initWithJSON:(NSData *)jsonData;

/**
 Converts a GravityUser array to JSON
 */
+ (NSData *)usersToJSON:(NSArray *)users;

@end
 
