//
//  DDAppDelegate.m
//  DDBackgroundView-OSX
//
//  Created by Dominik Pich on 27/04/14.
//  Copyright (c) 2014 Dominik Pich. All rights reserved.
//

#import "DDAppDelegate.h"
#import "DDBackgroundView.h"
#if !USE_NATIVE_NSGRADIENT
#import "CTGradient.h"
#endif

@implementation DDAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    [[NSColorPanel sharedColorPanel] setShowsAlpha:YES];
    [self apply:nil];
}

- (IBAction)apply:(id)sender {
    NSLog(@"Sender: %@", sender);
    [self applyTo:self.backgroundView];
    [self applyTo:self.backgroundView2];
}

- (void)applyTo:(DDBackgroundView*)bg {
    bg.alphaValue = self.viewAlpha.doubleValue;
    bg.backgroundCornerRadius = self.viewCornerRadius.doubleValue;

    if(self.useBackgroundColor.state == NSOnState)
        bg.backgroundColor = self.backgroundColor.color;
    else
        bg.backgroundColor = nil;
    
    if(self.usePatternImage.state == NSOnState)
        [bg setBackgroundPattern:self.patternImage.image withAlpha:self.patternAlpha.doubleValue];
    else
        bg.backgroundPattern = nil;
    
    if(self.useGradient.state == NSOnState) {
#if USE_NATIVE_NSGRADIENT
        NSGradient *g = [[NSGradient alloc] initWithStartingColor:self.gradientColor1.color endingColor:self.gradientColor2.color];
#else
        CTGradient *g = [CTGradient gradientWithBeginningColor:self.gradientColor1.color endingColor:self.gradientColor2.color];
#endif
        
        if(self.gradientRadial.state == NSOnState)
            [bg setBackgroundGradient:g withAngle:DDBackgroundViewGradientRadialAngle];
        else
            [bg setBackgroundGradient:g withAngle:self.gradientAngle.doubleValue];
    }
    else
        bg.backgroundGradient = nil;

    if(self.useImage.state == NSOnState) {
        [bg setBackgroundImage:self.image.image withAlpha:self.imageAlpha.doubleValue withScaleMode:self.imageScaling.selectedTag];
    }
    else
        bg.backgroundImage = nil;

    if(self.useBorder.state == NSOnState) {
        [bg setBorderColor:self.borderColor.color withWidth:self.borderWidth.doubleValue];
    }
    else
        bg.borderColor = nil;
}

@end
