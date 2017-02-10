//
//  GravityItem.m
//  GravityClient
//
//  Created by Balazs Kiss on 7/8/13.
//  Copyright (c) 2013 Balazs Kiss. All rights reserved.
//

#import "GravityItem.h"
#import "GravityNameValue.h"

@implementation GravityItem

- (id)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.Id = dict[@"itemId"];
        self.type = dict[@"itemType"];
        self.title = dict[@"title"];
        self.hidden = [dict[@"hidden"] boolValue];
        self.fromDate = [NSDate dateWithTimeIntervalSince1970: [dict[@"fromDate"] intValue]];
        self.toDate = [NSDate dateWithTimeIntervalSince1970: [dict[@"toDate"] intValue]];
        self.nameValues = [NSMutableArray array];
        for (NSDictionary *nameValue in dict[@"nameValues"]) {
            [self.nameValues addObject:[[GravityNameValue alloc] initWithDictionary:nameValue]];
        }
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat: @"GravityItem: id=%@ type=%@ title=%@ hidden=%@ fromDate=%@ toDate=%@ nameValues=%@", _Id, _type, _title, _hidden ? @"true" : @"false", _fromDate, _toDate, _nameValues];
}

+ (NSData *)itemsToJSON:(NSArray *)items {
    NSMutableArray *data = [NSMutableArray arrayWithCapacity:items.count];
    for(GravityItem *item in items) {
        NSMutableArray *nameValues = [NSMutableArray array];
        for(GravityNameValue *nameValue in item.nameValues) {
            [nameValues addObject:[nameValue dictionary]];
        }
        NSDictionary *dict = @{
                               @"itemId": item.Id,
                               @"title": item.title,
                               @"itemType": item.type,
                               @"hidden": item.hidden ? @"true" : @"false",
                               @"nameValues":nameValues
                               };
        [data addObject:dict];
    }
    return [NSJSONSerialization dataWithJSONObject:data options:0 error:nil];
}

@end
