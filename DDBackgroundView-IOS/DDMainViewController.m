//
//  DDMainViewController.m
//  DDBackgroundView-IOS
//
//  Created by Dominik Pich on 27/04/14.
//  Copyright (c) 2014 Dominik Pich. All rights reserved.
//

#import "DDMainViewController.h"
#import "DDBackgroundView.h"
#import "CTGradient.h"

@implementation DDMainViewController

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(DDFlipsideViewController *)controller
{
    [self applyTo:self.backgroundView from:controller];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
}

- (IBAction)togglePopover:(id)sender
{
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
}

- (void)viewDidLoad {
    [self applyTo:self.backgroundView from:nil];
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
#pragma mark - 

- (void)applyTo:(DDBackgroundView*)bg from:(DDFlipsideViewController*)controller {
    bg.alpha = 0.9;
    bg.backgroundCornerRadius = 10;
    bg.backgroundColor = [UIColor blueColor];
    bg.backgroundPattern = [UIImage imageNamed:@"pattern"];
    
    CTGradient *g = [CTGradient gradientWithBeginningColor:[UIColor redColor]
                                                endingColor:[UIColor clearColor]];
        
    [bg setBackgroundGradient:g withAngle:DDBackgroundViewGradientRadialAngle];

    [bg setBackgroundImage:[UIImage imageNamed:@"duck"]
              withAlpha:0.7
             withScaleMode:DDBackgroundViewImageScaleProportionallyDown];
    
    [bg setBorderColor:[UIColor yellowColor] withWidth:1];
}

@end