//
//  DarkSpinnerView.m
//  VDCommon
//
//  Created by Vladimir on 11/24/15.
//  Copyright (c) 2017 Vlad. All rights reserved.
//

#import "DarkSpinnerView.h"

@implementation DarkSpinnerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.7];
    }
    return self;
}

@end
