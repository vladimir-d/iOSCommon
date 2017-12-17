//
//  VVDBlockerSpinnerView.m
//  VDCommon
//
//  Created by Vladimir on 11/24/15.
//  Copyright (c) 2017 Vlad. All rights reserved.
//

#import "VDBlockerSpinnerView.h"
#import "UIKit+VDCommon.h"

static UIActivityIndicatorViewStyle defaultIndicatorStyle = UIActivityIndicatorViewStyleWhite;

@interface VDBlockerSpinnerView()

@property (strong, nonatomic) UIActivityIndicatorView * activityView;

@end

@implementation VDBlockerSpinnerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:defaultIndicatorStyle];
        self.activityView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:self.activityView];
        
    }
    return self;
}

- (void) startAnimating{
    [self.activityView startAnimating];
}

- (void) stopAnimating{
    [self.activityView stopAnimating];
}

- (void)layoutSubviews{
    [self.activityView placeInSuperViewMode:UIViewContentModeCenter];
}

+ (void) setDefaultIndicatorStyle:(UIActivityIndicatorViewStyle)indicatorStyle{
    defaultIndicatorStyle = indicatorStyle;
}

@end
