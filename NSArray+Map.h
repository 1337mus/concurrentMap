//
//  NSArray+Map.h
//  BlockTest
//
//  Created by Rajath Shanbag on 7/11/13.
//  Copyright (c) 2013 Rajath Shanbag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Map)
-(NSDictionary*) mapArrayToDictusingBlock:(id(^)(id obj))block;
@end
