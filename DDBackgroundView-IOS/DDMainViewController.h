//
//  DDMainViewController.h
//  DDBackgroundView-IOS
//
//  Created by Dominik Pich on 27/04/14.
//  Copyright (c) 2014 Dominik Pich. All rights reserved.
//

#import "DDFlipsideViewController.h"

@class DDBackgroundView;

@interface DDMainViewController : UIViewController <DDFlipsideViewControllerDelegate, UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *testme;
@property (weak) IBOutlet DDBackgroundView *backgroundView;
@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@end
