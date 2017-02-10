//
//  GravityRecommendationContext.h
//  GravityClient
//
//  Created by Balazs Kiss on 9/9/13.
//  Copyright (c) 2013 Gravity R&D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GravityRecommendationContext : NSObject

@property (nonatomic,strong) NSString *scenarioId;
@property (nonatomic,assign) NSUInteger limit;
@property (nonatomic,strong) NSArray *nameValues;
@property (nonatomic,strong) NSArray *resultNameValues;

/**
 Converts a GravityRecommendationContext array to JSON
 */
+ (NSData *)contextsToJSON:(NSArray *) contexts;

@end
