//
//  DCIWelcomeViewController.h
//  DarkTime
//
//  Created by Eric Knapp on 5/1/12.
//  Copyright (c) 2012 Madison Area Technical College. All rights reserved.
//

@import UIKit;

@class DCDarkClockViewController;

@interface DCIWelcomeViewController : UIViewController

@property (weak, nonatomic) DCDarkClockViewController *mainController;

-(void)doneButtonTapped;

@end
