//
//  DCDarkClockViewController_iPhone.m
//  DarkTime
//
//  Created by Eric Knapp on 9/20/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import "DCDarkClockViewController_iPhone.h"
#import "DCDarkClockViewController.h"
#import "DCSettingsViewController.h"
#import "DCClockState.h"

@implementation DCDarkClockViewController_iPhone


- (IBAction)settingsButtonTapped:(id)sender 
{
    self.clockState.fontEditorDisplayed = YES;
}

-(void)updateDisplayFont
{
    [super updateDisplayFont];
    self.timeLabel.font = [self.clockState.currentFont fontWithSize:225];
    self.ampmLabel.font = [self.clockState.currentFont fontWithSize:36];
    self.secondsLabel.font = [self.clockState.currentFont fontWithSize:36];
    
//    self.timeLabel.frame = CGRectMake(0, self.clockState.displayLabelY, 480, 320);
    
    [self changeDisplayBrightnessWithBrightness:self.clockState.clockBrightnessLevel];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft 
            || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


@end













