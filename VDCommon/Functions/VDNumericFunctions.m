//
//  VDNumericFunctions.m
//  VDCommon
//
//  Created by Vladimir Dudkin on 11/1/16.
//  Copyright (c) 2017. All rights reserved.
//

#import "VDNumericFunctions.h"

static double const kNeglectableDoubleDelta = 1e-7;

double randomDoubleBetween(double minValue, double maxValue){
    double delta = maxValue - minValue;
    return  (double)arc4random() / NSUIntegerMax  * delta + minValue;
}

double doubleFraction(double value){
    return  value - ((long)value);
}

BOOL isDoubleEqual(double v1, double v2){
    return  fabs(v1 - v2) < kNeglectableDoubleDelta;
}

NSUInteger randomUInteger(NSUInteger maxLimit){
    return  arc4random() % maxLimit;
}
