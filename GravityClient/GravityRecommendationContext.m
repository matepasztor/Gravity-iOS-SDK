//
//  GravityRecommendationContext.m
//  GravityClient
//
//  Created by Balazs Kiss on 9/9/13.
//  Copyright (c) 2013 Gravity R&D. All rights reserved.
//

#import "GravityRecommendationContext.h"
#import "GravityNameValue.h"

@implementation GravityRecommendationContext

+ (NSData *)contextsToJSON:(NSArray *)contexts {
    NSMutableArray *data = [NSMutableArray arrayWithCapacity:contexts.count];
    for(GravityRecommendationContext *context in contexts) {
        NSMutableArray *nameValues = [NSMutableArray array];
        for(GravityNameValue *nameValue in context.nameValues) {
            [nameValues addObject:[nameValue dictionary]];
        }
        NSDictionary *dict = @{
                               @"scenarioId": context.scenarioId,
                               @"numberLimit": [NSNumber numberWithUnsignedInt:(unsigned int)context.limit],
                               @"nameValues":nameValues,
                               @"resultNameValues":context.resultNameValues
                               };
        [data addObject:dict];
    }
    return [NSJSONSerialization dataWithJSONObject:data options:0 error:nil];
}
@end
