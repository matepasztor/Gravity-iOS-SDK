//
//  GravityEvent.m
//  GravityClient
//
//  Created by Balazs Kiss on 7/8/13.
//  Copyright (c) 2013 Balazs Kiss. All rights reserved.
//

#import "GravityEvent.h"
#import "GravityNameValue.h"

@implementation GravityEvent

- (NSString *)description {
    return [NSString stringWithFormat: @"GravityEvent: itemId=%@ userId=%@ cookieId=%@ type=%@ nameValues=%@", _itemId, _userId, _cookieId, _type, _nameValues];
}

+ (NSData *)eventsToJSON:(NSArray *)events {
    NSMutableArray *data = [NSMutableArray arrayWithCapacity:events.count];
    for(GravityEvent *event in events) {
        NSMutableArray *nameValues = [NSMutableArray array];
        for(GravityNameValue *nameValue in event.nameValues) {
            [nameValues addObject:[nameValue dictionary]];
        }
        NSDictionary *dict;
        if(event.userId && event.itemId){
            dict = @{
                    @"itemId": event.itemId,
                    @"userId": event.userId,
                    @"cookieId": event.cookieId,
                    @"eventType": event.type,
                    @"nameValues":nameValues
                };
        } else if(event.userId){
            dict = @{
                     @"userId": event.userId,
                     @"cookieId": event.cookieId,
                     @"eventType": event.type,
                     @"nameValues":nameValues
                };
        } else if(event.itemId){
            dict = @{
                    @"itemId": event.itemId,
                    @"cookieId": event.cookieId,
                    @"eventType": event.type,
                    @"nameValues":nameValues
                };
        } else{
            dict = @{
                     @"cookieId": event.cookieId,
                     @"eventType": event.type,
                     @"nameValues":nameValues
                };
        }
        [data addObject:dict];
    }
    return [NSJSONSerialization dataWithJSONObject:data options:0 error:nil];
}

- (void)setLocation:(CLLocation *)location{
    NSString *longitude = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    [self.nameValues addObject:[GravityNameValue nameValueWithName:@"longitude" value:longitude]];
    [self.nameValues addObject:[GravityNameValue nameValueWithName:@"latitude" value:latitude]];
}
@end
