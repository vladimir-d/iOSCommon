//
//  VDCommonUIFunctions.h
//  VDCommon
//
//  Created by Vladimir on 5/31/16.
//  Copyright (c) 2017. All rights reserved.
//

#import <Foundation/Foundation.h>

BOOL isIpad();

// based on real device type i.e. iPad even if iPhone-only app run in iPhone simulation mode
BOOL isPhysicalDeviceIpad();

@interface VDCommonUIFunctions : NSObject

@end
