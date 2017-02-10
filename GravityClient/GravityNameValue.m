//
//  GravityNameValue.m
//  GravityClient
//
//  Created by Balazs Kiss on 7/11/13.
//  Copyright (c) 2013 Balazs Kiss. All rights reserved.
//

#import "GravityNameValue.h"

@implementation GravityNameValue

- (id)initWithName:(NSString *)name value:(NSString *)value {
    self = [super init];
    if (self) {
        self.name = name;
        self.value = value;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dict {
    NSString *name = [dict objectForKey:@"name"];
    NSString *value = [dict objectForKey:@"value"];
    return [self initWithName:name value:value];
}

- (NSDictionary *)dictionary {
    return @{@"name":self.name, @"value":self.value};
}

- (NSString *)description {
    return [NSString stringWithFormat: @"GravityNameValue: name=%@ value=%@", _name, _value];
}

+ (id)nameValueWithName:(NSString *)name value:(NSString *)value {
    return [[GravityNameValue alloc] initWithName:name value:value];
}

@end
