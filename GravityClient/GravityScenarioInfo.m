//
//  GravityScenarioInfo.m
//  GravityClient
//
//  Created by Laszlo Fanaczan on 23/06/16.
//  Copyright © 2016 fea. All rights reserved.
//

#import "GravityScenarioInfo.h"

@implementation GravityScenarioInfo

- (id)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.Id = dict[@"id"];
        self.apiName = dict[@"apiName"];
        self.humanReadableName = dict[@"humanReadableName"];
        self.desc = dict[@"description"];
        self.order = dict[@"order"];
        self.numberLimit = dict[@"numberLimit"];
        self.type = dict[@"type"];
        self.modifierName = dict[@"modifierName"];
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
    return [NSString stringWithFormat: @"GravityScenarioInfo: id=%@ apiName=%@ humanReadableName=%@ description=%@ order=%@ numberLimit=%@ type=%@ modifierName=%@", _Id, _apiName, _humanReadableName, _desc, _order, _numberLimit, _type, _modifierName];
}

@end