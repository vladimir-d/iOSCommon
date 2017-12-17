//
//  BlockerViewManager.h
//  VDCommon
//
//  Created by Vladimir on 11/24/15.
//  Copyright (c) 2017 Vlad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VDBlockerViewManager : NSObject

+(VDBlockerViewManager*)sharedInstance;

@property(weak, nonatomic) Class defaultBlockerViewClass;
- (void) showBlockerView:(UIView *)blockerView onView:(UIView *)parentView;
- (void) showBlockerView:(UIView *)blockerView withName:(NSString *)name onView:(UIView *)parentView;
- (void) showBlockerView:(UIView *)blockerView withName:(NSString *)name onView:(UIView *)parentView timeout:(NSTimeInterval)timeout;
- (void) hideBlockerWithName:(NSString *)name onView:(UIView *)parentView;
- (void) hideBlockerOnView:(UIView *)parentView;
- (void) bringBlockerToFrontOnView:(UIView *)parentView;
@end


@interface UIViewController (BlockerViewManager)

- (void) showBlockerView:(UIView *)blockerView withName:(NSString *)name;
- (void) hideBlockerWithName:(NSString *)name;

- (void) showBlocker;
- (void) showBlockerOnView;
- (void) showBlockerView:(UIView *)blockerView;
- (void) showBlockerView:(UIView *)blockerView onView:(UIView *)view;
- (void) bringBlockerToFront;
- (void) hideBlocker;
- (void) hideBlockerOnView:(UIView *)view;

@end
