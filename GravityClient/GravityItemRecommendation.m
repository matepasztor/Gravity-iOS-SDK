//
//  GravityItemRecommendation.m
//  GravityClient
//
//  Created by Balazs Kiss on 7/8/13.
//  Copyright (c) 2013 Balazs Kiss. All rights reserved.
//

#import "GravityItemRecommendation.h"
#import "GravityItem.h"

@implementation GravityItemRecommendation

- (id)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.Id = dict[@"recommendationId"];
        self.itemIds = dict[@"itemIds"];
        self.predictionValues = dict[@"predictionValues"];
        NSMutableArray *items = [NSMutableArray arrayWithCapacity:[dict[@"items"] count]];
        for(NSDictionary *itemDict in dict[@"items"]) {
            GravityItem *item = [[GravityItem alloc] initWithDictionary:itemDict];
            [items addObject:item];
        }
        self.items = [NSArray arrayWithArray:items];
    }
    return self;
}

- (id)initWithJSON:(NSData *)jsonData {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData: jsonData options: 0 error: nil];
    if (!dict) {
        NSLog(@"Error parsing JSON");
        return nil;
    }
    self = [self initWithDictionary:dict];
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat: @"GravityItemRecommendation: id=%@ items=%@ itemIds=%@ predictionValues=%@", _Id, _items, _itemIds, _predictionValues];
}

@end
