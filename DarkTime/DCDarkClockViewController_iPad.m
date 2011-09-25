//
//  DCDarkClockViewController_iPad.m
//  DarkTime
//
//  Created by Eric Knapp on 9/20/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import "DCDarkClockViewController_iPad.h"
#import "DCClockState.h"
#import "DCDarkClockViewController.h"
#import "DCSettingsTableViewController.h"
#import "DCSettingsViewController.h"

@interface DCDarkClockViewController_iPad()

@property (nonatomic, retain) UIPopoverController *settingsPopover;

@end


@implementation DCDarkClockViewController_iPad

@synthesize settingsPopover = _settingsPopover;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)updateDisplayFont
{
    [super updateDisplayFont];
    NSLog(@"in iPad updateDisplayFont");
    self.timeLabel.font = self.clockState.currentFont;
    self.ampmLabel.font = [self.clockState.currentFont fontWithSize:64];
    self.secondsLabel.font = [self.clockState.currentFont fontWithSize:64];

    [self changeDisplayBrightnessWithBrightness:self.clockState.clockBrightnessLevel];
    
    NSLog(@"font %@", self.clockState.currentFont);
}

- (IBAction)settingsButtonTapped:(id)sender 
{
    self.clockState.fontEditorDisplayed = YES;
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

    [self updateDisplayFont];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



@end
