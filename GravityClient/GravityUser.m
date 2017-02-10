//
//  GravityUser.m
//  GravityClient
//
//  Created by Laszlo Fanaczan on 27/06/16.
//  Copyright © 2016 fea. All rights reserved.
//

#import "GravityUser.h"
#import "GravityNameValue.h"

@implementation GravityUser

- (id)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.userId = dict[@"userId"];
        self.hidden = [dict[@"hidden"] boolValue];
        NSMutableArray *nameValues = [NSMutableArray arrayWithCapacity:[dict[@"nameValues"] count]];
        for(NSDictionary *itemDict in dict[@"nameValues"]) {
            GravityNameValue *nameValue = [[GravityNameValue alloc] initWithDictionary:itemDict];
            [nameValues addObject:nameValue];
        }
        self.nameValues = [NSArray arrayWithArray:nameValues];
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
    return [NSString stringWithFormat: @"GravityUser: userId=%@ hidden=%@ nameValues=%@", _userId, _hidden ? @"true" : @"false", _nameValues];
}

+ (NSData *)usersToJSON:(NSArray *)users {
    NSMutableArray *data = [NSMutableArray arrayWithCapacity:users.count];
    for(GravityUser *user in users) {
        NSMutableArray *nameValues = [NSMutableArray array];
        for(GravityNameValue *nameValue in user.nameValues) {
            [nameValues addObject:[nameValue dictionary]];
        }
        NSDictionary *dict = @{
                               @"userId": user.userId,
                               @"hidden": user.hidden ? @"true" : @"false",
                               @"nameValues":nameValues
                               };
        [data addObject:dict];
    }
    return [NSJSONSerialization dataWithJSONObject:data options:0 error:nil];
}

@end
