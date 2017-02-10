//
//  GravityScenarioInfo.h
//  GravityClient
//
//  Created by Laszlo Fanaczan on 23/06/16.
//  Copyright © 2016 fea. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 ScenarioInfo
 */
@interface GravityScenarioInfo : NSObject

/**
 Id of the scenarioInfo
 */
@property NSNumber *Id;

/**
 Api name of the scenarioInfo
 */
@property NSString *apiName;

/**
 Human readable name of the scenarioInfo
 */
@property NSString *humanReadableName;

/**
 Description of the scenarioInfo
 */
@property NSString *desc;

/**
 Order of the scenarioInfo
 */
@property NSNumber *order;

/**
 Number limit of the scenarioInfo
 */
@property NSNumber *numberLimit;

/**
 Type of the scenarioInfo
 */
@property NSString *type;

/**
 Modifier name of the scenarioInfo
 */
@property NSString *modifierName;

/**
 Initializes a GravityScenarioInfo object with a dictionary
 @param dict the dictionary representing the object
 @return an initialized GravityScenarioInfo object
 */
- (id)initWithDictionary:(NSDictionary *)dict;

/**
 Initializes a GravityScenarioInfo object with JSON data
 @param jsonData the JSON data representing the object
 @return an initialized GravityScenarioInfo object
 */
- (id)initWithJSON:(NSData *)jsonData;

@end