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
    [self updateDisplayFontWithFontSize:DCIiPadAmPmSecondsFontSize];
        
}


#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self adjustHourMinuteLabelsForScreenHeight];

    self.modalStyle = UIModalPresentationFormSheet;
    self.settingsViewNib = DCSettingsViewNibNameiPad;
    self.clockState.fontSizePortrait = DCITimeLabelsFontSizePortraitiPad;
    self.clockState.fontSizeLandscape = DCITimeLabelFontSizeLandscapeiPad;
    self.clockState.device = DCIDarkTimeDeviceiPad;
    self.clockState.timeLabelPortraitFrame = self.timeLabelMinutesPortrait.frame;
    self.clockState.timeHourLabelPortraitFrame = self.timeLabelHoursPortrait.frame;
    self.clockState.dashedlineHeight = DCIDashedLineHeightiPad;

    [self adjustDashedLiveViewForScreenHeight];

    [self updateDisplayFontWithFontSize:DCIiPadAmPmSecondsFontSize];
    
    
}




@end
