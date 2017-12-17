//
//  UIView+VDCommon.h
//  VDCommon
//
//  Created by Vladimir on 10/7/11.
//  Copyright (c) 2017 Vlad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (VDCommon)


@property (nonatomic, assign) CGPoint bottomRightPoint;
@property (nonatomic, readonly) CGFloat bottomY;
@property (nonatomic, readonly) CGFloat rightX;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat originX;
@property (nonatomic, assign) CGFloat originY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

+ (instancetype)newFromNib;
+ (UIView *)newWithFrame:(CGRect)frame;
+ (UIView *)newWithFrame:(CGRect)frame backgroundColor:(UIColor *)color;

- (void) removeSubviewsWithTag:(NSInteger) tag;
- (void) addAutoresizedToBoundsSubview:(UIView *)aView;
- (NSArray *) superviewsChain;
- (UIView *) superviewOfClass:(Class) superViewClass;
- (UIView *) subviewWithClass:(Class) subViewClass;
- (UIView *) subviewWithClassName:(NSString *) className;
- (UIView *) recursiveSubviewWithClass:(Class) subViewClass;
- (void)recursiveSubviewsAction:(BOOL (^)(UIView * view))action;

- (void) bringToFront;
- (void) sendToBack;
- (UIViewController*)viewController;

- (void) centerViewByX:(BOOL) centerByX byY:(BOOL) centerByY;
- (void) placeInSuperViewMode:(UIViewContentMode)aMode;
- (void) placeInSuperViewMode:(UIViewContentMode)aMode offset:(CGPoint)aOffset;
- (void) placeInRect:(CGRect)rect mode:(UIViewContentMode)aMode offset:(CGPoint)aOffset;
- (void) placeInRectOfSize:(CGSize)aSize mode:(UIViewContentMode)aMode offset:(CGPoint)aOffset;
- (void) placeOutSuperViewMode:(UIViewContentMode)aMode;
- (void) placeOutSuperViewMode:(UIViewContentMode)aMode offset:(CGPoint)aOffset;
- (void) placeOutRectOfSize:(CGSize)aSize mode:(UIViewContentMode)aMode offset:(CGPoint)aOffset;
- (void) placeOutOfRect:(CGRect)rect mode:(UIViewContentMode)aMode offset:(CGPoint)aOffset;

- (void) expandSizeBy:(CGSize)size mode:(UIViewContentMode)mode;

/// Arranges rects horizontally inside the rect.
/// Rects with zero width are automatically resized to fit free space.
/// Rects with non-zero width will not be resized.
/// All rects will be vertically centered.
+ (NSArray*) layoutRects:(NSArray *)rects
      horizontallyInRect:(CGRect)rect
              leftMargin:(CGFloat)leftMargin
             rightMargin:(CGFloat)rightMargin
               topMargin:(CGFloat)topMargin
            bottomMargin:(CGFloat)bottomMargin
                 spacing:(CGFloat)spacing;

/// Arranges rects vertically inside the rect.
/// Rects with zero height are automatically resized to fit free space.
/// Rects with non-zero height will not be resized.
/// All rects will be horizontally centered.
+ (NSArray*) layoutRects:(NSArray *)rects
        verticallyInRect:(CGRect)rect
              leftMargin:(CGFloat)leftMargin
             rightMargin:(CGFloat)rightMargin
               topMargin:(CGFloat)topMargin
            bottomMargin:(CGFloat)bottomMargin
                 spacing:(CGFloat)spacing;

/// Arranges views horizontally inside the rect. See 'layoutRectsHorizontally'.
+ (void) layoutViews:(NSArray *)views
  horizontallyInRect:(CGRect)rect
          leftMargin:(CGFloat)leftMargin
         rightMargin:(CGFloat)rightMargin
           topMargin:(CGFloat)topMargin
        bottomMargin:(CGFloat)bottomMargin
             spacing:(CGFloat)spacing;

/// Arranges views vertically inside the rect. See 'layoutRectsVertically'.
+ (void) layoutViews:(NSArray *)views
    verticallyInRect:(CGRect)rect
          leftMargin:(CGFloat)leftMargin
         rightMargin:(CGFloat)rightMargin
           topMargin:(CGFloat)topMargin
        bottomMargin:(CGFloat)bottomMargin
             spacing:(CGFloat)spacing;

/// Arranges views vertically in the middle of the rect.
+ (void) layoutViews:(NSArray *)views
verticallyCenteredInRect:(CGRect)rect
          leftMargin:(CGFloat)leftMargin
         rightMargin:(CGFloat)rightMargin
           topMargin:(CGFloat)topMargin
        bottomMargin:(CGFloat)bottomMargin
             spacing:(CGFloat)spacing;

+ (void) layoutInRect:(CGRect)rect rowViews:(NSArray *)views gap:(CGFloat)gap;
+ (void) layoutDistributedInRect:(CGRect)rect rowViews:(NSArray *)views withMargin:(CGFloat)margin;

- (void) makeRoundCorners;

- (void) animateAlphaTo:(CGFloat)endAlpha duration:(NSTimeInterval)duration;
- (void) fadeShow;
- (void) fadeHide;
- (void) fadeAddToView:(UIView *)view;
- (void) fadeRemove;

- (NSString *)allConstraintDescription;

- (void) scaleAllConstraintsFromSize:(CGSize)size;
- (void) scaleAllConstraintsExcept:(NSArray *)exceptConstraints fromSize:(CGSize)size;
- (NSArray *) whConstraints;

@end
