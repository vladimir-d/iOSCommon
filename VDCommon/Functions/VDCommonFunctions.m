//
//  VDCommonFunctions.m
//
//  Created by Vladimir Dudkin on 10/7/11.
//  Copyright (c) 2017. All rights reserved.
//

#import "VDCommonFunctions.h"

void gcdAsyncOnMainQueue(dispatch_block_t block){
    dispatch_async(dispatch_get_main_queue(), block);
}

void gcdAfterOnMainQueue(NSTimeInterval delayInSeconds, dispatch_block_t block){
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

BOOL equallStrings(NSString * str1, NSString * str2){
    if ([str1 length] > 0){
        return [str1 isEqualToString:str2];
    }
    else{
        return ([str2 length] == 0);
    }
}

id alt(id obj, id defaultObj){
    return (obj != nil) ? obj : defaultObj;
}


