//
//  DDBackgroundView.h
//  Written by D.Pich
//
//  Based on DBBackgroundView by Dave Batton
//  http://www.Mere-Mortal-Software.com/
//
//  Copyright 2014. Some rights reserved.
//  This work is licensed under a Creative Commons license:
//  http://creativecommons.org/licenses/by/2.5/
//
#if !__has_feature(objc_arc)
#error This class requires automatic reference counting
#endif

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#define View UIView
#define Color UIColor
#define Point CGPoint
#define Image UIImage
#define BezierPath UIBezierPath
#define Rect CGRect
#define setNeedsDisplay [self setNeedsDisplay]
#define EqualSizes CGSizeEqualToSize
#define InsetRect CGRectInset
#else
#import <Cocoa/Cocoa.h>
#define View NSView
#define Color NSColor
#define Point NSPoint
#define Image NSImage
#define BezierPath NSBezierPath
#define Rect NSRect
#define setNeedsDisplay [self setNeedsDisplay:YES]
#define EqualSizes NSEqualSizes
#define InsetRect NSInsetRect

#define USE_NATIVE_NSGRADIENT 1
#endif

#if TARGET_OS_IPHONE || !USE_NATIVE_NSGRADIENT
@class CTGradient;
#define Gradient CTGradient
#else
#define Gradient NSGradient
#endif

enum {
    DDBackgroundViewImageScaleProportionallyDown = 0,
    DDBackgroundViewImageScaleAxesIndependently,
    DDBackgroundViewImageScaleNone,
    DDBackgroundViewImageScaleProportionallyUpOrDown
};
typedef NSUInteger DDBackgroundViewImageScaling;

//
// Class
//
@interface DDBackgroundView : View

@property (nonatomic, assign) CGFloat backgroundCornerRadius;

@property (nonatomic, retain) Color *backgroundColor;

@property (nonatomic, assign) CGFloat backgroundPatternAlpha;
@property (nonatomic, retain) Image *backgroundPattern;
- (void)setBackgroundPattern:(Image *)anImage withAlpha:(CGFloat)anAlpha;

@property (nonatomic, assign) CGFloat backgroundGradientAngle;
@property (nonatomic, retain) Gradient *backgroundGradient;
- (void)setBackgroundGradient:(Gradient *)aGradient withAngle:(CGFloat)anAngle;

@property (nonatomic, assign) CGFloat backgroundImageAlpha;
@property (nonatomic, assign) DDBackgroundViewImageScaling backgroundImageScaleMode;
@property (nonatomic, retain) Image *backgroundImage;
- (void)setBackgroundImage:(Image *)anImage withAlpha:(CGFloat)anAlpha;
- (void)setBackgroundImage:(Image *)anImage withAlpha:(CGFloat)anAlpha withScaleMode:(DDBackgroundViewImageScaling)scaleMode;

@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, retain) Color *borderColor;
- (void)setBorderColor:(Color *)borderColor withWidth:(CGFloat)width;

@end

static NSUInteger DDBackgroundViewGradientRadialAngle = -1;