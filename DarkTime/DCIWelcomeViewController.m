//
//  DCIWelcomeViewController.m
//  DarkTime
//
//  Created by Eric Knapp on 5/1/12.
//  Copyright (c) 2012 Madison Area Technical College. All rights reserved.
//

#import "DCIWelcomeViewController.h"
#import "DCDarkClockViewController.h"

@interface DCIWelcomeViewController ()


@end

@implementation DCIWelcomeViewController

@synthesize mainController = _mainController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
                                         duration:(NSTimeInterval)duration
{
    [self.view layoutIfNeeded];
}

-(void)doneButtonTapped
{
    [self.mainController switchToOrientationView:self.interfaceOrientation];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
