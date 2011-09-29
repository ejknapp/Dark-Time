//
//  DCDarkClockViewController_iPad.m
//  DarkTime
//
//  Created by Eric Knapp on 9/20/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import "DCDarkClockViewController_iPad.h"
#import "DCClockState.h"
#import "DCClockConstants.h"
#import "DCDarkClockViewController.h"
#import "DCSettingsTableViewController.h"
#import "DCSettingsViewController.h"
#import "DCInfoViewController.h"

@interface DCDarkClockViewController_iPad()




@end


@implementation DCDarkClockViewController_iPad


-(void)updateDisplayFont
{
    
    [self updateDisplayFontWithFontSize:iPadAmPmSecondsFontSize];
        
}


#pragma mark - View lifecycle


- (void)viewDidLoad
{
    
    self.modalStyle = UIModalPresentationFormSheet;
    self.settingsViewNib = DCSettingsViewNibNameiPad;
    
    [super viewDidLoad];
        
    [self updateDisplayFont];
}




@end
