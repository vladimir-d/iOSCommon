//
//  VDCommonUIFunctions.m
//  VDCommon
//
//  Created by Vladimir on 5/31/16.
//  Copyright (c) 2017. All rights reserved.
//

#import "VDCommonUIFunctions.h"
#import <sys/utsname.h>
#import "VDCommon.h"

BOOL isIpad(){
    return UIUserInterfaceIdiomPad == [UIDevice currentDevice].userInterfaceIdiom;
}

BOOL isPhysicalDeviceIpad(){
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *devStr = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
    return [devStr rangeOfString:@"iPad"].length > 0;
}

@implementation VDCommonUIFunctions

@end
