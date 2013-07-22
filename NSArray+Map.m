//
//  NSArray+Map.m
//  BlockTest
//
//  Created by Rajath Shanbag on 7/11/13.
//  Copyright (c) 2013 Rajath Shanbag. All rights reserved.
//

#import "NSArray+Map.h"

@implementation NSArray (Map)

-(NSDictionary*) mapArrayToDictusingBlock:(id (^)(id object))block{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSMutableDictionary* result = [NSMutableDictionary dictionaryWithCapacity:self.count];
    //Using Fast Enumeration
    //__block NSUInteger i = 0;
    for (id obj in self) {
        NSBlockOperation* blockOp = [NSBlockOperation blockOperationWithBlock:^{
            NSString *key;
            if ([obj isKindOfClass:[NSString class]]) {
                key = obj;
            }else{
                key = [obj description];
            }
            // *key = [NSString stringWithFormat:@"%d", i++];
            @synchronized(self){ //Synchronize the result Dictionary as it is being accessed by Multiple Threads
                /*if ([obj isKindOfClass:[NSNumber class]]){
                    [result setValue:[NSString stringWithFormat:@"%d", 2*[obj integerValue]] forKey:key];
                }else{
                    [result setValue:block(obj) forKey:key];
                }*/
                [result setValue:block(obj) forKey:key];
            }
        }];
        [queue addOperation:blockOp];
    }
    [queue waitUntilAllOperationsAreFinished];
    
    return result;
}

@end
