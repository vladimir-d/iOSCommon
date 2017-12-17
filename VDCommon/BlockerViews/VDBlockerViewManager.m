//
//  BlockerViewManager.m
//  VDCommon
//
//  Created by Vladimir on 11/24/15.
//  Copyright (c) 2017 Vlad. All rights reserved.
//

#import "VDBlockerViewManager.h"
#import "VDBlockerSpinnerView.h"
#import "UIKit+VDCommon.h"

static NSString * const kDefaultBlockerName = @"kDefaultBlockerName";

@interface VDBlockerWrapper:NSObject

@property(strong, nonatomic) NSMutableDictionary * items;
@property(strong, nonatomic) UIView * blockerView;
@property(weak, nonatomic) UIView * hostView;
@property(assign, nonatomic) NSTimeInterval timeoutStamp;

@end

@implementation VDBlockerWrapper

- (instancetype)initWithHostView:(UIView *)view
{
    self = [super init];
    if (self) {
        _items = [NSMutableDictionary new];
        _hostView = view;
    }
    return self;
}
+ (instancetype) newWithHostView:(UIView *)view{
    return [[self alloc] initWithHostView:view];
}

@end

@interface VDBlockerViewManager(){
    NSMutableDictionary * _blockersByView;
}

@end


@implementation VDBlockerViewManager

#pragma mark - Shared access & init

+(VDBlockerViewManager*)sharedInstance
{
    static dispatch_once_t predicate;
    static VDBlockerViewManager *sharedInstance = nil;
    
    dispatch_once(&predicate, ^{
        sharedInstance = [VDBlockerViewManager new];
    });
    
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _blockersByView = [NSMutableDictionary new];
		self.defaultBlockerViewClass = [VDBlockerSpinnerView class];
		
    }
    return self;
}

#pragma mark - Private methods

- (VDBlockerWrapper *)blockerWrapperForView:(UIView *)parentView{
    if (parentView == nil){
        return nil;
    }
    NSValue * viewValue = [NSValue valueWithNonretainedObject: parentView];
    VDBlockerWrapper * blockerWrapper = _blockersByView[viewValue];
    return blockerWrapper;
}

#pragma mark - Public methods

- (void) showBlockerView:(UIView *)blockerView onView:(UIView *)parentView{
    [self showBlockerView:blockerView withName:kDefaultBlockerName onView:parentView];
}

- (void) showBlockerView:(UIView *)blockerView onView:(UIView *)parentView timeout:(NSTimeInterval)timeout{
    [self showBlockerView:blockerView withName:kDefaultBlockerName onView:parentView timeout:timeout];
}

- (void) showBlockerView:(UIView *)blockerView withName:(NSString *)name onView:(UIView *)parentView{
    [self showBlockerView:blockerView withName:name onView:parentView timeout:-1];
}

- (void) showBlockerWithName:(NSString *)name onView:(UIView *)parentView timeout:(NSTimeInterval)timeout{
    [self showBlockerView:nil withName:name onView:parentView timeout:timeout];
}

- (void) showBlockerView:(UIView *)blockerView withName:(NSString *)name onView:(UIView *)parentView timeout:(NSTimeInterval)timeout{
    if (parentView == nil){
        return;
    }
    NSValue * viewValue = [NSValue valueWithNonretainedObject: parentView];
    VDBlockerWrapper * blockerWrapper = _blockersByView[viewValue];
    if (blockerWrapper == nil){
        blockerWrapper = [VDBlockerWrapper newWithHostView:parentView];
        _blockersByView[viewValue] = blockerWrapper;
    }
    if (name == nil){
        name = kDefaultBlockerName;
    }
    id blokerItem = blockerWrapper.items[name];
    if (blokerItem == nil){
        blokerItem = @{};
        blockerWrapper.items[name] = blokerItem;
        if (blockerView == nil){
            blockerView = [self.defaultBlockerViewClass new];
        }
        blockerWrapper.blockerView = blockerView;
        [self addBlockerView:blockerView toView:parentView];
    }
    else{
        
    }

}


- (void) hideBlockerOnView:(UIView *)parentView{
    [self hideBlockerWithName:kDefaultBlockerName onView:parentView];
}

- (void) hideBlockerWithName:(NSString *)name onView:(UIView *)parentView{
    if (parentView == nil){
        return;
    }
    NSValue * viewValue = [NSValue valueWithNonretainedObject: parentView];
    VDBlockerWrapper * blockerWrapper = _blockersByView[viewValue];
    if (blockerWrapper != nil){
        [blockerWrapper.items removeObjectForKey:name];
        if ([blockerWrapper.items count] == 0){
            [blockerWrapper.blockerView removeFromSuperview];
            [_blockersByView removeObjectForKey:viewValue];
        }
    }
}

- (void) bringBlockerToFrontOnView:(UIView *)parentView{
    UIView * blockerView = [self blockerWrapperForView:parentView].blockerView;
    [blockerView bringToFront];
}

- (void) addBlockerView:(UIView *)blockerView toView:(UIView *)parentView{
    blockerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    blockerView.frame = parentView.bounds;
    [parentView addSubview:blockerView];
    if ([blockerView respondsToSelector:@selector(startAnimating)]){
        [(id)blockerView startAnimating];
    }
}

@end

@implementation UIViewController (VDBlockerViewManager)

- (void) showBlockerView:(UIView *)blockerView withName:(NSString *)name{
    [[VDBlockerViewManager sharedInstance] showBlockerView:blockerView withName:name onView:self.view];
}

- (void) showBlocker{
    [[VDBlockerViewManager sharedInstance] showBlockerView:nil onView:self.view];
}

- (void) showBlockerOnView:(UIView *)view{
    [[VDBlockerViewManager sharedInstance] showBlockerView:nil onView:view];
}

- (void) showBlockerView:(UIView *)blockerView{
   [[VDBlockerViewManager sharedInstance] showBlockerView:blockerView onView:self.view];
}

- (void) showBlockerView:(UIView *)blockerView onView:(UIView *)view{
    [[VDBlockerViewManager sharedInstance] showBlockerView:blockerView onView:view];
}

- (void) hideBlockerWithName:(NSString *)name{
    [[VDBlockerViewManager sharedInstance] hideBlockerWithName:name onView:self.view];
}

- (void) hideBlocker{
    [[VDBlockerViewManager sharedInstance] hideBlockerOnView:self.view];
}

- (void) hideBlockerOnView:(UIView *)view{
    [[VDBlockerViewManager sharedInstance] hideBlockerOnView:view];
}

- (void) bringBlockerToFront{
    [[VDBlockerViewManager sharedInstance] bringBlockerToFrontOnView:self.view];
}

@end
