//
//  NSNull+VDCommon.h
//  VDCommon
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017. All rights reserved.
//

#import <Foundation/Foundation.h>

//This category makes NSNull safe to use
// any message can be sent to NSNull instance without exception

@interface NSNull (VDCommon)

- (BOOL) isNull;

@end
