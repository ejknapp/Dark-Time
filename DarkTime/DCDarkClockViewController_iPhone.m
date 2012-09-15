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


- (void)adjustHourMinuteLabelsForScreenHeight
{
    CGFloat halfHeight = [[UIScreen mainScreen]applicationFrame].size.height / 2;
    CGFloat width = [[UIScreen mainScreen]applicationFrame].size.width;

    CGFloat adjustFactor = 20.0;
    
    CGRect hourFrame = CGRectMake(0,
                                  adjustFactor,
                                  width,
                                  halfHeight - adjustFactor);
    CGRect minuteFrame = CGRectMake(0,
                                    halfHeight - (adjustFactor / 2),
                                    width,
                                    halfHeight - adjustFactor);
    
    self.timeLabelHoursPortrait.frame = hourFrame;
    self.timeLabelMinutesPortrait.frame = minuteFrame;
}

-(void)adjustDashedLiveViewForScreenHeight
{
    CGFloat halfHeight = [[UIScreen mainScreen]applicationFrame].size.height / 2;
    CGFloat width = [[UIScreen mainScreen]applicationFrame].size.width;

    CGFloat dashedViewY = halfHeight - 17;
    
    CGRect dashedViewFrame = CGRectMake(9,
                                        dashedViewY,
                                        width, 20);
    
    self.dottedLine.frame = dashedViewFrame;
}

-(void)viewDidLoad
{
    [super viewDidLoad];

    self.landscapeView.frame = self.view.frame;
    self.portraitView.frame = self.view.frame;
    
    [self adjustHourMinuteLabelsForScreenHeight];
    [self adjustDashedLiveViewForScreenHeight];
    
    
    self.modalStyle = UIModalPresentationFormSheet;
    self.settingsViewNib = DCSettingsViewNibNameiPhone;
    self.clockState.fontSizePortrait = DCiPhonePortraitTimeLabelsFontSize;
    self.clockState.fontSizeLandscape = DCiPhoneLandscapeTimeLabelFontSize;
    self.clockState.device = DCIDarkTimeDeviceiPhone;
    self.clockState.timeLabelPortraitFrame = self.timeLabelMinutesPortrait.frame;
    self.clockState.timeHourLabelPortraitFrame = self.timeLabelHoursPortrait.frame;
    
    [self updateDisplayFontWithFontSize:iPhoneAmPmSecondsFontSize];
    

}


- (void) updateDisplayFont
{
    
    [self updateDisplayFontWithFontSize:iPhoneAmPmSecondsFontSize];
    
}



@end













