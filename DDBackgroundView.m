//
//  DDBackgroundView.h
//  Written by D.Pich
//  Based on DBBackgroundView by Dave Batton
//  http://www.Mere-Mortal-Software.com/
//
//  Copyright 2014. Some rights reserved.
//  This work is licensed under a Creative Commons license:
//  http://creativecommons.org/licenses/by/2.5/
//
#import "DDBackgroundView.h"
#if TARGET_OS_IPHONE || !USE_NATIVE_NSGRADIENT
#import "CTGradient.h"
#endif

@implementation DDBackgroundView {
	Color *_backgroundPatternColor;
}

- (id)initWithFrame:(Rect)frameRect {
	self = [super initWithFrame:frameRect];
	if (self) {
		[self clearBackground];
	}
	return self;
}

- (void)awakeFromNib {
	[self clearBackground];
}

- (void)clearBackground {
    self.backgroundCornerRadius = 0;

	self.backgroundColor = nil;

    self.backgroundPatternAlpha = 1;
    self.backgroundPattern = nil;
    
	self.backgroundGradientAngle = 90;
	self.backgroundGradient = nil;
    
    self.backgroundImageScaleMode = DDBackgroundViewImageScaleProportionallyUpOrDown;
	self.backgroundImageAlpha = 1;
	self.backgroundImage = nil;

    self.borderWidth = 1;
    self.borderColor = nil;
}

#pragma mark -
#pragma mark Configuration Methods

- (void)setBackgroundCornerRadius:(CGFloat)aRadius {
	_backgroundCornerRadius = aRadius;
#if TARGET_OS_IPHONE
    self.layer.cornerRadius = _backgroundCornerRadius;
    self.layer.masksToBounds = YES;
#else
    setNeedsDisplay;
#endif
}

- (void)setBackgroundColor:(Color *)aColor {
	_backgroundColor = aColor;
#if TARGET_OS_IPHONE
    [super setBackgroundColor:aColor];
#else
	setNeedsDisplay;
#endif
}

#pragma mark -

- (void)setBackgroundPatternAlpha:(CGFloat)backgroundPatternAlpha {
    _backgroundPatternAlpha = backgroundPatternAlpha;
    setNeedsDisplay;
}

- (void)setBackgroundPattern:(Image *)anImage {
    [self setBackgroundPattern:anImage withAlpha:self.backgroundPatternAlpha];
}

- (void)setBackgroundPattern:(Image *)anImage withAlpha:(CGFloat)anAlpha {
	if (anImage) {
		_backgroundPatternColor = [Color colorWithPatternImage:anImage];
	}
	else {
		_backgroundPatternColor = nil;
	}
    _backgroundPatternAlpha = anAlpha;
	setNeedsDisplay;
}

#pragma mark -

- (void)setBackgroundGradientAngle:(CGFloat)backgroundGradientAngle {
    _backgroundGradientAngle = backgroundGradientAngle;
    setNeedsDisplay;
}

- (void)setBackgroundGradient:(id)aGradient {
	[self setBackgroundGradient:aGradient withAngle:90];
}

- (void)setBackgroundGradient:(Gradient *)aGradient withAngle:(CGFloat)anAngle {
	_backgroundGradient = aGradient;
	_backgroundGradientAngle = anAngle;
	setNeedsDisplay;
}

#pragma mark -

- (void)setBackgroundImageAlpha:(CGFloat)backgroundImageAlpha {
    _backgroundImageAlpha = backgroundImageAlpha;
    setNeedsDisplay;
}

- (void)setBackgroundImageScaleMode:(DDBackgroundViewImageScaling)backgroundImageScaleMode {
    _backgroundImageScaleMode = backgroundImageScaleMode;
    setNeedsDisplay;
}

- (void)setBackgroundImage:(Image *)anImage {
	[self setBackgroundImage:anImage withAlpha:self.backgroundImageAlpha];
}

- (void)setBackgroundImage:(Image *)anImage withAlpha:(CGFloat)anAlpha {
    [self setBackgroundImage:anImage withAlpha:anAlpha withScaleMode:self.backgroundImageScaleMode];
}

- (void)setBackgroundImage:(Image *)anImage withAlpha:(CGFloat)anAlpha withScaleMode:(DDBackgroundViewImageScaling)scaleMode {
	_backgroundImage = anImage;
	_backgroundImageAlpha = anAlpha;
    _backgroundImageScaleMode = scaleMode;
	setNeedsDisplay;
}

#pragma mark - 

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
#if TARGET_OS_IPHONE
    self.layer.borderWidth = _borderWidth;
#else
    setNeedsDisplay;
#endif
}

- (void)setBorderColor:(Color *)borderColor {
    [self setBorderColor:borderColor withWidth:self.borderWidth];
}

- (void)setBorderColor:(Color *)borderColor withWidth:(CGFloat)width {
    _borderColor = borderColor;
    _borderWidth = width;
#if TARGET_OS_IPHONE
    self.layer.borderColor = _borderColor.CGColor;
    self.layer.borderWidth = _borderWidth;
#else
    setNeedsDisplay;
#endif
}

#pragma mark -
#pragma mark Drawing Routines


- (BOOL)isOpaque {
    return NO;
}

- (void)drawRect:(__unused Rect)rect {
#if TARGET_OS_IPHONE
	BezierPath *aPath = [BezierPath bezierPathWithRect:self.bounds]; ///clipping is applied to layer
#else
	[[Color clearColor] set];
	NSRectFillUsingOperation(self.bounds, NSCompositeSourceOver);
	BezierPath *aPath = [BezierPath bezierPathWithRoundedRect:self.bounds xRadius:_backgroundCornerRadius yRadius:_backgroundCornerRadius];
	[self drawColor:aPath]; //for ios, this is implicit
#endif
    
	[self drawPattern:aPath];
	[self drawGradient:aPath];
	[self drawImage:aPath];

#if TARGET_OS_IPHONE
#else
    [self drawBorder:aPath]; //drawn by layer
#endif
}

- (void)drawColor:(BezierPath *)aPath {
	if (_backgroundColor) {
		[_backgroundColor set];
		[aPath fill];
	}
}

- (void)drawPattern:(BezierPath *)aPath {
	if (_backgroundPatternColor) {
#if TARGET_OS_IPHONE
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
#else
        CGContextRef currentContext = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
#endif
        CGContextSaveGState(currentContext);
        
        //draw the pattern
        CGContextSetAlpha(currentContext, _backgroundPatternAlpha);
        
        [aPath addClip];
        [_backgroundPatternColor set];
        [aPath fill];

        CGContextRestoreGState(currentContext);
    }
}

- (void)drawGradient:(BezierPath *)aPath {
	if (_backgroundGradient) {
#if TARGET_OS_IPHONE
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
#else
        CGContextRef currentContext = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
#endif
        CGContextSaveGState(currentContext);

		if (_backgroundGradientAngle == DDBackgroundViewGradientRadialAngle) {
#if TARGET_OS_IPHONE || !USE_NATIVE_NSGRADIENT
            [_backgroundGradient radialFillBezierPath:aPath];
#else
            [_backgroundGradient drawInBezierPath:aPath relativeCenterPosition:NSZeroPoint];
#endif
		}
		else {
#if TARGET_OS_IPHONE || !USE_NATIVE_NSGRADIENT
            [_backgroundGradient fillBezierPath:aPath angle:_backgroundGradientAngle];
#else
			[_backgroundGradient drawInBezierPath:aPath angle:_backgroundGradientAngle];
#endif
		}
        
        CGContextRestoreGState(currentContext);
    }
}

- (void)drawImage:(BezierPath *)aPath {
	if (_backgroundImage) {
        Rect bounds = aPath.bounds;
        Rect target;
        
        //center if needed
        if(!EqualSizes(bounds.size, _backgroundImage.size)) {
            // If the image is not as big as the view, we need center of a new image that is.
            // Find the point at which to draw the image so it's centered.
            CGPoint backgroundCenter;
            backgroundCenter.x = bounds.size.width / 2;
            backgroundCenter.y = bounds.size.height / 2;
            
            target.size = _backgroundImage.size;
            
            Point drawPoint = backgroundCenter;
            drawPoint.x -= target.size.width / 2;
            drawPoint.y -= target.size.height / 2;
            target.origin = drawPoint;
        }
        
        //set target based on scaling
        if(_backgroundImageScaleMode == DDBackgroundViewImageScaleAxesIndependently) {
            target = bounds;
        }
        else if(_backgroundImageScaleMode == DDBackgroundViewImageScaleProportionallyUpOrDown ||
                _backgroundImageScaleMode == DDBackgroundViewImageScaleProportionallyDown) {
            BOOL fitIn = YES;
            if(_backgroundImageScaleMode == DDBackgroundViewImageScaleProportionallyDown) {
                if(_backgroundImage.size.height < bounds.size.height ||
                   _backgroundImage.size.width < bounds.size.width) {
                    fitIn = NO;
                }
            }
            
            if(fitIn) {
                CGFloat xRatio = _backgroundImage.size.width / bounds.size.width;
                CGFloat yRatio = _backgroundImage.size.height / bounds.size.height;
                
                CGFloat aspectRatio = _backgroundImage.size.width / _backgroundImage.size.height;
                
                //fit sizes
                if (xRatio >= yRatio) {
                    target.size.width = bounds.size.width;
                    target.size.height = target.size.width / aspectRatio;
                }
                else {
                    target.size.height = bounds.size.height;
                    target.size.width = target.size.height * aspectRatio;
                }
                
                //center rect
                target.origin.x = bounds.origin.x + (bounds.size.width - target.size.width)*0.5f;
                target.origin.y = bounds.origin.y + (bounds.size.height - target.size.height)*0.5f;
            }
        }

        //save
#if TARGET_OS_IPHONE
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
#else
        CGContextRef currentContext = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
#endif
        CGContextSaveGState(currentContext);
        
        // Draw the image into the view with the specified transparency.
        [aPath addClip];
#if TARGET_OS_IPHONE
        [_backgroundImage drawInRect:target blendMode:kCGBlendModeSourceAtop alpha:_backgroundImageAlpha];
#else
        [_backgroundImage drawInRect:target fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:_backgroundImageAlpha];
#endif
        
        //restore
        CGContextRestoreGState(currentContext);
	}
}

- (void)drawBorder:(BezierPath *)aPath {
	if (_borderColor && _borderWidth) {
        [_borderColor setStroke];
        aPath.lineWidth = _borderWidth;
        [aPath stroke];
    }
}

@end
