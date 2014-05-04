//
//  DDFlipsideViewController.h
//  DDBackgroundView-IOS
//
//  Created by Dominik Pich on 27/04/14.
//  Copyright (c) 2014 Dominik Pich. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDFlipsideViewController;

@protocol DDFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(DDFlipsideViewController *)controller;
@end

@interface DDFlipsideViewController : UIViewController

@property (weak, nonatomic) id <DDFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
