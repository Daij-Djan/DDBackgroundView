//
//  DDAppDelegate.h
//  DDBackgroundView-OSX
//
//  Created by Dominik Pich on 27/04/14.
//  Copyright (c) 2014 Dominik Pich. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DDBackgroundView;

@interface DDAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet DDBackgroundView *backgroundView;
@property (weak) IBOutlet DDBackgroundView *backgroundView2;

@property (weak) IBOutlet NSButton *useBackgroundColor;
@property (weak) IBOutlet NSButton *usePatternImage;
@property (weak) IBOutlet NSButton *useGradient;
@property (weak) IBOutlet NSButton *useImage;
@property (weak) IBOutlet NSButton *useBorder;

@property (weak) IBOutlet NSSlider *viewAlpha;
@property (weak) IBOutlet NSTextField *viewCornerRadius;
@property (weak) IBOutlet NSColorWell *backgroundColor;
@property (weak) IBOutlet NSImageView *patternImage;
@property (weak) IBOutlet NSSlider *patternAlpha;
@property (weak) IBOutlet NSTextField *gradientAngle;
@property (weak) IBOutlet NSButton *gradientRadial;
@property (weak) IBOutlet NSColorWell *gradientColor1;
@property (weak) IBOutlet NSColorWell *gradientColor2;
@property (weak) IBOutlet NSImageView *image;
@property (weak) IBOutlet NSSlider *imageAlpha;
@property (weak) IBOutlet NSButton *imageScaling;
@property (weak) IBOutlet NSColorWell *borderColor;
@property (weak) IBOutlet NSTextField *borderWidth;

- (IBAction)apply:(id)sender;

@end
