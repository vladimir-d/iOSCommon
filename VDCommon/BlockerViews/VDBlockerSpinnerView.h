//
//  VVDBlockerSpinnerView.h
//  VDCommon
//
//  Created by Vladimir on 11/24/15.
//  Copyright (c) 2017 Vlad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VDBlockerSpinnerView : UIView

- (void) startAnimating;
- (void) stopAnimating;

+ (void) setDefaultIndicatorStyle:(UIActivityIndicatorViewStyle)indicatorStyle;
@end
