//
//  DCDarkClockViewController_iPhone.m
//  DarkTime
//
//  Created by Eric Knapp on 9/20/11.
//  Copyright 2011 Dovetail Computing, Inc.. All rights reserved.
//

#import "DCDarkClockViewController_iPhone.h"
#import "DCDarkClockViewController.h"
#import "DCSettingsViewController.h"
#import "DCClockState.h"
#import "DCClockConstants.h"
#import "DCInfoViewController.h"
#import "DCIDashedDividerView.h"

@implementation DCDarkClockViewController_iPhone


-(void)viewDidLoad
{
    [super viewDidLoad];

    [self adjustHourMinuteLabelsForScreenHeight];
        
    self.modalStyle = UIModalPresentationFormSheet;
    self.settingsViewNib = DCSettingsViewNibNameiPhone;
    self.clockState.fontSizePortrait = DCIiPhonePortraitTimeLabelsFontSize;
    self.clockState.fontSizeLandscape = DCIiPhoneLandscapeTimeLabelFontSize;
    self.clockState.device = DCIDarkTimeDeviceiPhone;
    self.clockState.timeLabelPortraitFrame = self.timeLabelMinutesPortrait.frame;
    self.clockState.timeHourLabelPortraitFrame = self.timeLabelHoursPortrait.frame;
    self.clockState.dashedlineHeight = DCIDashedLineHeightiPhone;

    [self adjustDashedLiveViewForScreenHeight];

    [self updateDisplayFontWithFontSize:DCIiPhoneAmPmSecondsFontSize];
    

}


- (void) updateDisplayFont
{
    
    [self updateDisplayFontWithFontSize:DCIiPhoneAmPmSecondsFontSize];
    
}



@end













