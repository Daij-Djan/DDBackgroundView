//
//  CTGradient.h
//
//  Created by Chad Weider on 2/14/07.
//  Writtin by Chad Weider.
//
//  Released into public domain on 4/10/08.
//
//  Version: 1.8
#if !__has_feature(objc_arc)
#error This class requires automatic reference counting
#endif

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>

#define Color UIColor
#define Rect CGRect
#define BezierPath UIBezierPath

#define MinX CGRectGetMinX
#define MidX CGRectGetMidX
#define MaxX CGRectGetMaxX
#define MinY CGRectGetMinY
#define MidY CGRectGetMidY
#define MaxY CGRectGetMaxY
#define Width CGRectGetWidth
#define Height CGRectGetHeight
#else
#import <Cocoa/Cocoa.h>

#define Color NSColor
#define Rect NSRect
#define BezierPath NSBezierPath

#define MinX NSMinX
#define MidX NSMidX
#define MaxX NSMaxX
#define MinY NSMinY
#define MidY NSMidY
#define MaxY NSMaxY
#define Width NSWidth
#define Height NSHeight
#endif

typedef struct _CTGradientElement
{
	CGFloat red, green, blue, alpha;
	CGFloat position;
    
	struct _CTGradientElement *nextElement;
} CTGradientElement;

typedef enum  _CTBlendingMode {
	CTLinearBlendingMode,
	CTChromaticBlendingMode,
	CTInverseChromaticBlendingMode
} CTGradientBlendingMode;


@interface CTGradient : NSObject <NSCopying, NSCoding>
{
	CTGradientElement *elementList;
	CTGradientBlendingMode blendingMode;
    
	CGFunctionRef gradientFunction;
}

+ (id)gradientWithBeginningColor:(Color *)begin endingColor:(Color *)end;

+ (id)aquaSelectedGradient;
+ (id)aquaNormalGradient;
+ (id)aquaPressedGradient;

+ (id)unifiedSelectedGradient;
+ (id)unifiedNormalGradient;
+ (id)unifiedPressedGradient;
+ (id)unifiedDarkGradient;

+ (id)sourceListSelectedGradient;
+ (id)sourceListUnselectedGradient;

+ (id)rainbowGradient;
+ (id)hydrogenSpectrumGradient;

- (CTGradient *)gradientWithAlphaComponent:(CGFloat)alpha;

- (CTGradient *)addColorStop:(Color *)color atPosition:(CGFloat)position; //positions given relative to [0,1]
- (CTGradient *)removeColorStopAtIndex:(NSUInteger)index;
- (CTGradient *)removeColorStopAtPosition:(CGFloat)position;

- (CTGradientBlendingMode)blendingMode;
- (Color *)colorStopAtIndex:(NSUInteger)index;
- (Color *)colorAtPosition:(CGFloat)position;


- (void)drawSwatchInRect:(Rect)rect;
- (void)fillRect:(Rect)rect angle:(CGFloat)angle;                 //fills rect with axial gradient
//	angle in degrees
- (void)radialFillRect:(Rect)rect;                              //fills rect with radial gradient
//  gradient from center outwards
- (void)fillBezierPath:(BezierPath *)path angle:(CGFloat)angle;
- (void)radialFillBezierPath:(BezierPath *)path;

@end
