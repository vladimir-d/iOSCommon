//
//  UIView+VDCommon.m
//  VDCommon
//
//  Created by Vladimir on 10/7/11.
//  Copyright (c) 2017 Vlad. All rights reserved.
//


#import "UIView+VDCommon.h"
#import "VDCommon.h"


@interface UIView (Common_Private) 

+ (void) printChildsForView:(UIView*) view withInd:(NSUInteger) ind;

@end

@implementation UIView (VDCommon)

@dynamic bottomRightPoint;
@dynamic origin;
@dynamic size;
@dynamic originX;
@dynamic originY;
@dynamic width;
@dynamic height;

#pragma mark - Creating

+ (UIView *)newWithFrame:(CGRect)frame{
    return [[self alloc] initWithFrame:frame];
}

+ (UIView *)newWithFrame:(CGRect)frame backgroundColor:(UIColor *)color{
    UIView * view = [[self alloc] initWithFrame:frame];
    view.backgroundColor = color;
    return view;
}

+ (instancetype)newFromNib{
    NSArray * nibViews = [[NSBundle mainBundle] loadNibNamed:[self className] owner:nil options:nil];
    NSLog(@"nibViews:%@", nibViews);
    return [nibViews firstObject];
}


#pragma mark - Working with subviews / superviews

- (void) removeSubviewsWithTag:(NSInteger) tag {
	UIView *viewToRemove = nil;
	while ( (viewToRemove = [self viewWithTag:tag]) ) {
		[viewToRemove removeFromSuperview];
	}
	
}

- (void) addAutoresizedToBoundsSubview:(UIView *)aView{
    aView.frame = self.bounds;
    aView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:aView];
}

- (NSArray *) superviewsChain{
    NSMutableArray * tmpArray = [NSMutableArray new];
    for(UIView * sv = [self superview]; sv != nil; sv = [sv superview]){
        [tmpArray addObject:sv];
    }
    return [NSArray arrayWithArray:tmpArray];
}


- (UIView *) subviewWithClass:(Class) subViewClass{
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:subViewClass]){
            return view;
        }
    }
    return  nil;
}

- (UIView *) recursiveSubviewWithClass:(Class) subViewClass{
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:subViewClass]){
            return view;
        }
        else{
            UIView * rSubView = [view recursiveSubviewWithClass:subViewClass];
            if (rSubView != nil){
                return rSubView;
            }
        }
    }
    return  nil;
}

- (UIView *) subviewWithClassName:(NSString *) className{
    for (UIView * view in self.subviews) {
        if ([NSStringFromClass([view class]) isEqualToString:className]){
            return view;
        }
    }
    return  nil;
}

- (UIView *) superviewOfClass:(Class) superViewClass{
	
	UIView *currentSuperView = self.superview;
	while ( currentSuperView != nil && ![currentSuperView isKindOfClass:superViewClass] ) {
		currentSuperView = currentSuperView.superview;
	}
	
	return currentSuperView;
}


- (void) bringToFront{
    [[self superview] bringSubviewToFront:self];
}

- (void) sendToBack{
    [[self superview] sendSubviewToBack:self];
}


- (UIViewController*)viewController {
    Class vcClass = [UIViewController class];
	for (UIView* next = self; next; next = next.superview) {
		UIResponder* nextResponder = [next nextResponder];
		if ([nextResponder isKindOfClass:vcClass]) {
			return (UIViewController*)nextResponder;
		}
	}
	return nil;
}

- (UIViewController *)ownViewContoller{
    return [UIViewController castObject:self.nextResponder];
}


- (void)recursiveSubviewsAction:(BOOL (^)(UIView * view))action{
    if (action){
        for(UIView * subview in self.subviews){
            BOOL stop = action(subview);
            if (stop){
                break;
            }
            else{
                [subview recursiveSubviewsAction:action];
            }
        }
    }
}


#pragma mark - Accessing frame elements

- (CGPoint) origin{
	return self.frame.origin;
}

- (void) setOrigin:(CGPoint)aPoint{
	self.frame = CGRectMake(aPoint.x, aPoint.y, self.frame.size.width, self.frame.size.height);
}

- (CGSize) size{
	return self.frame.size;
}

- (void) setSize:(CGSize)aSize{
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, aSize.width, aSize.height);
}

- (CGFloat) originX {
	return self.frame.origin.x;
}

- (void) setOriginX:(CGFloat)aX{
	CGRect r = self.frame;
	r.origin.x = aX;
	self.frame = r;
}

- (CGFloat) originY {
	return self.frame.origin.y;
}

- (void) setOriginY:(CGFloat)aY{
	CGRect r = self.frame;
	r.origin.y = aY;
	self.frame = r;
}

- (CGFloat) height{
	return self.frame.size.height;
}

- (void) setHeight:(CGFloat)aHeight{
	CGRect r = self.frame;
	r.size.height = aHeight;
	self.frame = r;
}

- (CGFloat) width{
	return self.frame.size.width;
}

- (void) setWidth:(CGFloat)aWidth{
	CGRect r = self.frame;
	r.size.width = aWidth;
	self.frame = r;
}

- (void) setBottomRightPoint:(CGPoint)aPoint{
    [self setOrigin:CGPointMake(aPoint.x - self.frame.size.width, aPoint.y - self.frame.size.height)];
}

- (CGPoint) bottomRightPoint {
    return CGPointMake(self.frame.origin.x + self.frame.size.width, self.frame.origin.y + self.frame.size.height);
}

- (CGFloat) bottomY {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat) rightX {
    return self.frame.origin.x + self.frame.size.width;
}

#pragma mark - Positioning

- (void) centerViewByX:(BOOL) centerByX byY:(BOOL) centerByY {
	
	if ( !centerByX && !centerByY  ) {
		return;
	}
	
	CGRect viewFrame = self.frame;
	CGRect superviewBounds = [self superview].bounds;
	
	if ( centerByX ) {
		viewFrame.origin.x = roundf((superviewBounds.size.width / 2.0f - viewFrame.size.width / 2.0f));
	}

	if ( centerByY ) {
		viewFrame.origin.y = roundf((superviewBounds.size.height / 2.0f - viewFrame.size.height / 2.0f));		
	}

	self.frame = viewFrame;
	
}

- (void) expandSizeBy:(CGSize)size mode:(UIViewContentMode)mode{
    CGRect r = self.frame;
    r.size.width += size.width;
    r.size.height += size.height;
    
	if (mode < UIViewContentModeCenter || mode > UIViewContentModeBottomRight){
		return;
	}
	if (mode == UIViewContentModeCenter || mode == UIViewContentModeTop || mode == UIViewContentModeBottom){
		r.origin.x -= size.width / 2.0; 
	}
	else if (mode == UIViewContentModeRight || mode == UIViewContentModeTopRight || mode == UIViewContentModeBottomRight){
		r.origin.x -= size.width; 
	}
	
	if (mode == UIViewContentModeCenter || mode == UIViewContentModeLeft || mode == UIViewContentModeRight){
		r.origin.y -= size.height / 2.0; 
	}
	else if (mode == UIViewContentModeBottomRight || mode == UIViewContentModeBottom || mode == UIViewContentModeBottomLeft){
		r.origin.y -= size.height;   
	}
	self.frame = r;
}

- (void) placeInSuperViewMode:(UIViewContentMode)aMode{
    [self placeInRectOfSize:self.superview.bounds.size mode:aMode offset:CGPointZero];
}

- (void) placeInSuperViewMode:(UIViewContentMode)aMode offset:(CGPoint)aOffset{
	[self placeInRectOfSize:self.superview.bounds.size mode:aMode offset:aOffset];
}

- (void) placeInRect:(CGRect)rect mode:(UIViewContentMode)aMode offset:(CGPoint)aOffset{
    CGPoint origOffset = CGPointMake(rect.origin.x + aOffset.x, rect.origin.y + aOffset.y);
    [self placeInRectOfSize:rect.size mode:aMode offset:origOffset];
}

- (void) placeInRectOfSize:(CGSize)aSize mode:(UIViewContentMode)aMode offset:(CGPoint)aOffset{
	CGPoint viewPoint = CGPointZero;
	CGSize viewSize = self.bounds.size;
	if (aMode < UIViewContentModeCenter || aMode > UIViewContentModeBottomRight){
		return;
	}
	if (aMode == UIViewContentModeCenter || aMode == UIViewContentModeTop || aMode == UIViewContentModeBottom){
		viewPoint.x = aSize.width/2.0 - viewSize.width / 2.0; 
	}
	else if (aMode == UIViewContentModeRight || aMode == UIViewContentModeTopRight || aMode == UIViewContentModeBottomRight){
		viewPoint.x = aSize.width - viewSize.width; 
	}
	
	if (aMode == UIViewContentModeCenter || aMode == UIViewContentModeLeft || aMode == UIViewContentModeRight){
		viewPoint.y = aSize.height /2.0 - viewSize.height / 2.0; 
	}
	else if (aMode == UIViewContentModeBottomRight || aMode == UIViewContentModeBottom || aMode == UIViewContentModeBottomLeft){
		viewPoint.y = aSize.height - viewSize.height;
	}
	self.center = CGPointMake(viewPoint.x + viewSize.width / 2.0 + aOffset.x, viewPoint.y + viewSize.height / 2.0 + aOffset.y);
}

- (void) placeOutSuperViewMode:(UIViewContentMode)aMode{
    [self placeOutOfRect:self.superview.bounds mode:aMode offset:CGPointZero];
}

- (void) placeOutSuperViewMode:(UIViewContentMode)aMode offset:(CGPoint)aOffset{
	[self placeOutOfRect:self.superview.bounds mode:aMode offset:aOffset];
}

- (void) placeOutOfRect:(CGRect)rect mode:(UIViewContentMode)aMode offset:(CGPoint)aOffset{
	CGPoint viewPoint = CGPointZero;
	CGSize viewSize = self.bounds.size;
	if (aMode < UIViewContentModeCenter || aMode > UIViewContentModeBottomRight){
		return;
	}
	if (aMode == UIViewContentModeCenter || aMode == UIViewContentModeTop || aMode == UIViewContentModeBottom){
		viewPoint.x = rect.origin.x + (rect.size.width - viewSize.width) / 2.0;
	}
	else if (aMode == UIViewContentModeRight || aMode == UIViewContentModeTopRight || aMode == UIViewContentModeBottomRight){
		viewPoint.x = CGRectGetMaxX(rect);
	}
    else if (aMode == UIViewContentModeLeft || aMode == UIViewContentModeTopLeft || aMode == UIViewContentModeBottomLeft){
		viewPoint.x = rect.origin.x - viewSize.width;
	}
	
	if (aMode == UIViewContentModeCenter || aMode == UIViewContentModeLeft || aMode == UIViewContentModeRight){
		viewPoint.y = rect.origin.y + (rect.size.height - viewSize.height) / 2.0;
	}
	else if (aMode == UIViewContentModeBottomRight || aMode == UIViewContentModeBottom || aMode == UIViewContentModeBottomLeft){
		viewPoint.y = CGRectGetMaxY(rect);
	}
    else if (aMode == UIViewContentModeTopRight || aMode == UIViewContentModeTop || aMode == UIViewContentModeTopLeft){
		viewPoint.y = rect.origin.y - viewSize.height;
	}
	self.center = CGPointMake(viewPoint.x + viewSize.width / 2.0 + aOffset.x, viewPoint.y + viewSize.height / 2.0 + aOffset.y);
}

- (void) placeOutRectOfSize:(CGSize)aSize mode:(UIViewContentMode)aMode offset:(CGPoint)aOffset{
	CGPoint viewPoint = CGPointZero;
	CGSize viewSize = self.bounds.size;
	if (aMode < UIViewContentModeCenter || aMode > UIViewContentModeBottomRight){
		return;
	}
	if (aMode == UIViewContentModeCenter || aMode == UIViewContentModeTop || aMode == UIViewContentModeBottom){
		viewPoint.x = aSize.width/2.0 - viewSize.width / 2.0;
	}
	else if (aMode == UIViewContentModeRight || aMode == UIViewContentModeTopRight || aMode == UIViewContentModeBottomRight){
		viewPoint.x = aSize.width;
	}
    else if (aMode == UIViewContentModeLeft || aMode == UIViewContentModeTopLeft || aMode == UIViewContentModeBottomLeft){
		viewPoint.x = -viewSize.width;
	}
	
	if (aMode == UIViewContentModeCenter || aMode == UIViewContentModeLeft || aMode == UIViewContentModeRight){
		viewPoint.y = aSize.height /2.0 - viewSize.height / 2.0;
	}
	else if (aMode == UIViewContentModeBottomRight || aMode == UIViewContentModeBottom || aMode == UIViewContentModeBottomLeft){
		viewPoint.y = aSize.height;
	}
    else if (aMode == UIViewContentModeTopRight || aMode == UIViewContentModeTop || aMode == UIViewContentModeTopLeft){
		viewPoint.y = -viewSize.height;
	}
	self.center = CGPointMake(viewPoint.x + viewSize.width / 2.0 + aOffset.x, viewPoint.y + viewSize.height / 2.0 + aOffset.y);
}

+ (NSArray*) layoutRects:(NSArray *)rects
      horizontallyInRect:(CGRect)rect
              leftMargin:(CGFloat)leftMargin
             rightMargin:(CGFloat)rightMargin
               topMargin:(CGFloat)topMargin
            bottomMargin:(CGFloat)bottomMargin
                 spacing:(CGFloat)spacing {

    NSArray *outRects = [[NSMutableArray alloc] init];

    NSUInteger count = [rects count];

    const CGFloat availableHeight = rect.size.height - topMargin - bottomMargin;
    CGFloat availableWidth = rect.size.width;

    if (count) {
        for (NSValue *value in rects) {
            CGRect rect = [value CGRectValue];
            if (rect.size.width != 0) {
                availableWidth -= rect.size.width;
            }
        }

        availableWidth -= (leftMargin + rightMargin);
        availableWidth -= spacing * (count - 1);

        const CGFloat itemWidth = MAX(0, availableWidth / count);

        CGFloat x = rect.origin.x + leftMargin;

        for (NSValue *value in rects) {
            CGRect itemRect = [value CGRectValue];

            itemRect.origin.x = roundf(x);
            itemRect.origin.y = rect.origin.y + topMargin + (availableHeight - itemRect.size.height) / 2;

            if (itemRect.size.width == 0) {
                itemRect.size.width = itemWidth;
            }

            outRects = [outRects arrayByAddingObject:[NSValue valueWithCGRect:itemRect]];

            x += itemRect.size.width + spacing;
        }
    }

    return outRects;
}

+ (NSArray*) layoutRects:(NSArray *)rects
        verticallyInRect:(CGRect)rect
              leftMargin:(CGFloat)leftMargin
             rightMargin:(CGFloat)rightMargin
               topMargin:(CGFloat)topMargin
            bottomMargin:(CGFloat)bottomMargin
                 spacing:(CGFloat)spacing {

    NSArray *outRects = [[NSMutableArray alloc] init];

    NSUInteger count = [rects count];

    const CGFloat availableWidth = rect.size.width - leftMargin - rightMargin;
    CGFloat availableHeight = rect.size.height;

    if (count) {
        for (NSValue *value in rects) {
            CGRect rect = [value CGRectValue];
            if (rect.size.height != 0) {
                availableHeight -= rect.size.height;
            }
        }

        availableHeight -= (topMargin + bottomMargin);
        availableHeight -= spacing * (count - 1);

        const CGFloat itemHeight = MAX(0, availableHeight / count);

        CGFloat y = rect.origin.y + topMargin;

        for (NSValue *value in rects) {
            CGRect itemRect = [value CGRectValue];

            itemRect.origin.x = rect.origin.x + leftMargin + (availableWidth - itemRect.size.width) / 2.0;
            itemRect.origin.y = roundf(y);

            if (itemRect.size.height == 0) {
                itemRect.size.height = itemHeight;
            }

            outRects = [outRects arrayByAddingObject:[NSValue valueWithCGRect:itemRect]];
            
            y += itemRect.size.height + spacing;
        }
    }
    
    return outRects;
}

+ (void) layoutViews:(NSArray *)views
  horizontallyInRect:(CGRect)rect
          leftMargin:(CGFloat)leftMargin
         rightMargin:(CGFloat)rightMargin
           topMargin:(CGFloat)topMargin
        bottomMargin:(CGFloat)bottomMargin
             spacing:(CGFloat)spacing {

    NSArray* rects = [[NSArray alloc] init];

    for (UIView *view in views) {
        rects = [rects arrayByAddingObject:[NSValue valueWithCGRect:view.frame]];
    }

    rects = [UIView layoutRects:rects
             horizontallyInRect:rect
                     leftMargin:leftMargin
                    rightMargin:rightMargin
                      topMargin:topMargin
                   bottomMargin:bottomMargin
                        spacing:spacing];

    NSInteger i = 0;
    for (UIView *view in views) {
        CGRect rect = [[rects objectAtIndex:i] CGRectValue];
        view.frame = rect;
        ++i;
    }
}

+ (void) layoutViews:(NSArray *)views
    verticallyInRect:(CGRect)rect
          leftMargin:(CGFloat)leftMargin
         rightMargin:(CGFloat)rightMargin
           topMargin:(CGFloat)topMargin
        bottomMargin:(CGFloat)bottomMargin
             spacing:(CGFloat)spacing {

    NSArray* rects = [[NSArray alloc] init];

    for (UIView *view in views) {
        rects = [rects arrayByAddingObject:[NSValue valueWithCGRect:view.frame]];
    }

    rects = [UIView layoutRects:rects
               verticallyInRect:rect
                     leftMargin:leftMargin
                    rightMargin:rightMargin
                      topMargin:topMargin
                   bottomMargin:bottomMargin
                        spacing:spacing];

    NSInteger i = 0;
    for (UIView *view in views) {
        CGRect rect = [[rects objectAtIndex:i] CGRectValue];
        view.frame = rect;
        ++i;
    }
}

+ (void) layoutViews:(NSArray *)views
verticallyCenteredInRect:(CGRect)rect
          leftMargin:(CGFloat)leftMargin
         rightMargin:(CGFloat)rightMargin
           topMargin:(CGFloat)topMargin
        bottomMargin:(CGFloat)bottomMargin
             spacing:(CGFloat)spacing {

    [UIView layoutViews:views verticallyInRect:rect leftMargin:leftMargin rightMargin:rightMargin topMargin:topMargin bottomMargin:bottomMargin spacing:spacing];

    UIView* firstView = [views firstObject];
    UIView* lastView = [views lastObject];

    CGFloat height = lastView.bottomY - firstView.originY;
    CGFloat offset = (rect.size.height - topMargin - bottomMargin - height) / 2.0;

    for (UIView *view in views) {
        view.originY += offset;
    }
}

+ (void) layoutInRect:(CGRect)rect rowViews:(NSArray *)views gap:(CGFloat)gap{
    NSUInteger count = [views count];
    if (!count){
        return;
    }
    CGFloat allGaps = (count - 1) * gap;
    if (allGaps > rect.size.width){
        return;
    }
    CGFloat viewWidth = (rect.size.width - allGaps) / count;
    CGFloat stepWidth = viewWidth + gap;
    viewWidth = roundf(viewWidth);
    CGFloat viewHeight = rect.size.height;
    CGFloat originY = rect.origin.y;
    [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj setFrame:CGRectMake(roundf(rect.origin.x + stepWidth * idx), originY, viewWidth, viewHeight)];
    }];
}

+ (void) layoutDistributedInRect:(CGRect)rect rowViews:(NSArray *)views withMargin:(CGFloat)margin{
    NSUInteger count = [views count];
    if (!count){
        return;
    }
    if (count == 1){
        UIView * view = views[0];
        view.center = CGPointMake(CGRectGetMidX(rect), view.center.y);
    }
    else{
        CGFloat viewsWidth = 0.0;
        for(UIView * view in views){
            viewsWidth += view.width;
        }
        CGFloat remainWidth = rect.size.width - margin * 2.0 - viewsWidth;
        CGFloat gap = remainWidth / (count - 1);
        __block CGFloat curx = margin;
        [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIView * view = obj;
            [view setOriginX:roundf(curx)];
            curx += view.width + gap;
        }];
    }
}

#pragma mark - Layer

- (void) makeRoundCorners{
    CGSize size = self.bounds.size;
    CGFloat r = MIN(size.width, size.height) / 2.0;
    self.layer.cornerRadius = r;
}

#pragma mark - Animations

-(void)animateAlphaTo:(CGFloat)endAlpha duration:(NSTimeInterval)duration{
    [UIView animateWithDuration:duration animations:^{
        self.alpha = endAlpha;
    }];
}

-(void)fadeShow{
    self.alpha = 0.0;
    [self animateAlphaTo:1.0 duration:0.3];
}

-(void)fadeHide{
    [self animateAlphaTo:0.0 duration:0.3];
}

- (void)fadeAddToView:(UIView *)view{
    [view addSubview:self];
    [self fadeShow];
}

-(void)fadeRemove{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    }
    completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark - Autolayout
- (void) scaleAllConstraintsFromSize:(CGSize)size{
    [self scaleAllConstraintsExcept:nil fromSize:size];
}

- (NSArray *) whConstraints{
    NSMutableArray * resConstraints = [NSMutableArray new];
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeWidth || constraint.firstAttribute == NSLayoutAttributeHeight){
            [resConstraints addObject:constraint];
        }
    }
    return [NSArray arrayWithArray:resConstraints];
    
}

- (void) scaleAllConstraintsExcept:(NSArray *)exceptConstraints fromSize:(CGSize)size{
    //NSLog(@"exceptConstraints:%@", exceptConstraints);
    CGSize deviceSize = [UIScreen mainScreen].bounds.size;
    CGFloat scaleFactor = deviceSize.width / size.width;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (![exceptConstraints containsObject:constraint]){
            if (constraint.constant != 0 && constraint.multiplier == 1.0){
                switch (constraint.firstAttribute) {
                    case NSLayoutAttributeWidth:
                    case NSLayoutAttributeLeft:
                    case NSLayoutAttributeRight:
                    case NSLayoutAttributeLeading:
                    case NSLayoutAttributeTrailing:
                    case NSLayoutAttributeCenterX:
                    case NSLayoutAttributeLeftMargin:
                    case NSLayoutAttributeRightMargin:
                    case NSLayoutAttributeLeadingMargin:
                    case NSLayoutAttributeTrailingMargin:
                    case NSLayoutAttributeCenterXWithinMargins:
                        //NSLog(@"- constraint.constant:%@ -> new value:%@\n\n", @(constraint.constant), @(constraint.constant * deviceSize.width / size.width));
                        constraint.constant *= scaleFactor;
                        break;
                        
                    case NSLayoutAttributeHeight:
                    case NSLayoutAttributeTop:
                    case NSLayoutAttributeBottom:
                    case NSLayoutAttributeCenterY:
                    case NSLayoutAttributeTopMargin:
                    case NSLayoutAttributeBottomMargin:
                    case NSLayoutAttributeCenterYWithinMargins:
                    case NSLayoutAttributeBaseline:
                    case NSLayoutAttributeFirstBaseline:
                        //NSLog(@"- constraint.constant:%@ -> new value:%@\n\n", @(constraint.constant), @(constraint.constant * deviceSize.width / size.width));
                        constraint.constant *= scaleFactor;
                        break;
                        
                    default:
                        break;
                }
            }
        }
    }
    for(UIView * subview in self.subviews){
        [subview scaleAllConstraintsExcept:exceptConstraints fromSize:size];
    }
}


- (NSString *)allConstraintDescription{
    NSMutableString * str = [NSMutableString new];
    [self addConstraintsInfoWithLevel:0 toString:str];
    return [NSString stringWithString:str];
}


- (void) addConstraintsInfoWithLevel:(NSUInteger)level toString:(NSMutableString *)string{
    NSMutableString *indentationText = [NSMutableString new];
    int i;
    
    for (i = 0; i < level; i++) {
        [indentationText appendString:@"\t"];
    }
    [string appendFormat:@"\n%@***view:%@",indentationText, [self description]];
    for (NSLayoutConstraint *constraint in self.constraints) {
        [string appendFormat:@"\n%@%@",indentationText, [constraint description]];
    }
    for(UIView * subview in self.subviews){
        [subview addConstraintsInfoWithLevel:level + 1 toString:string];
    }
}



@end
