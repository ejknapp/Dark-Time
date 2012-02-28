//
//  DCDarkClockViewController_iPad.m
//  DarkTime
//
//  Created by Eric Knapp on 9/20/11.
//  Copyright 2011 Dovetail Computing, Inc.. All rights reserved.
//

#import "DCDarkClockViewController_iPad.h"
#import "DCClockState.h"
#import "DCClockConstants.h"
#import "DCDarkClockViewController.h"
#import "DCSettingsTableViewController.h"
#import "DCSettingsViewController.h"
#import "DCInfoViewController.h"


@implementation DCDarkClockViewController_iPad


-(void)updateDisplayFont
{
    NSLog(@"\n\tFunction\t=>\t%s\n\tLine\t\t=>\t%d", __func__, __LINE__);
    [self updateDisplayFontWithFontSize:iPadAmPmSecondsFontSize];
        
}


#pragma mark - View lifecycle


- (void)viewDidLoad
{
    
    self.modalStyle = UIModalPresentationFormSheet;
    self.settingsViewNib = DCSettingsViewNibNameiPad;
    self.clockState.fontSizePortrait = DCiPadPortraitTimeLabelsFontSize;
    self.clockState.fontSizeLandscape = DCiPadLandscapeTimeLabelFontSize;
    self.clockState.device = DCIDarkTimeDeviceiPad;
    self.clockState.timeLabelPortraitFrame = self.timeLabelMinutesPortrait.frame;
    self.clockState.timeHourLabelPortraitFrame = self.timeLabelHoursPortrait.frame;

    NSLog(@"\n\tFunction\t=>\t%s\n\tLine\t\t=>\t%d", __func__, __LINE__);
    [self updateDisplayFontWithFontSize:iPadAmPmSecondsFontSize];
    
    [super viewDidLoad];
    
}




@end
