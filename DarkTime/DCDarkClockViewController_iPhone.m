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

@implementation DCDarkClockViewController_iPhone


-(void)viewDidLoad
{
    
    self.modalStyle = UIModalPresentationFormSheet;
    self.settingsViewNib = DCSettingsViewNibNameiPhone;
    
    [super viewDidLoad];
    
//    [self updateDisplayFont];
}


- (void) updateDisplayFont
{
    
    [self updateDisplayFontWithFontSize:iPhoneAmPmSecondsFontSize];
    
}



@end













