//
//  GravityItem.h
//  GravityClient
//
//  Created by Balazs Kiss on 7/8/13.
//  Copyright (c) 2013 Balazs Kiss. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 An item in the recommendation
 */
@interface GravityItem : NSObject

/**
 Id of the item
 */
@property NSString *Id;

/**
 Type of the item
 */
@property NSString *type;

/**
 Title of the item
 */
@property NSString *title;

/**
 Defines whether the item is visible to users
 */
@property BOOL hidden;

/**
 An item is never recommended before this date.
 */
@property NSDate *fromDate;

/**
 An item is never recommended after this date.
 */
@property NSDate *toDate;

/**
 The NameValues for the item
 */
@property NSMutableArray *nameValues;

/**
 Initializes a GravityItem object with a dictionary
 @param dict the dictionary representing the object
 @return an initialized GravityItem object
 */
- (id)initWithDictionary:(NSDictionary *)dict;

/**
 Converts a GravityItem array to JSON
 */
+ (NSData *)itemsToJSON:(NSArray *)items;

@end
