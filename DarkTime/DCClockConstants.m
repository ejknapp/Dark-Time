//
//  DCClockConstants.m
//  DarkTimePhone
//
//  Created by Eric Knapp on 6/2/11.
//  Copyright 2011 Dovetail Computing, Inc. All rights reserved.
//

#import "DCClockConstants.h"

NSString * const kNoSeconds = @"";
NSString * const kAmDisplay = @"AM";
NSString * const kPmDisplay = @"PM";
NSString * const kAmPmNoDisplay = @"";

NSString * const DCSettingsTableViewHeader = @"header";
NSString * const DCSettingsTableViewCellText = @"cellText";
NSString * const DCSettingsTableViewFooter = @"footer";
NSString * const DCSettingsTableViewCellIdentifier = @"cell-identifier";
NSString * const DCSettingsTableViewCell = @"custom-cell";
NSString * const DCSettingsTableViewSectionFooterHeight = @"section-footer-height";
NSString * const DCSettingsTableViewSectionRowHeight = @"section-row-height";

NSString * const DCFontSizeCalculationString = @"8:88";

NSString * const DCSettingsViewNibNameiPad = @"DCSettingsTableViewController";
NSString * const DCSettingsViewNibNameiPhone = @"DCSettingsTableViewController";

NSUInteger const iPadAmPmSecondsFontSize = 64;
NSUInteger const iPhoneAmPmSecondsFontSize = 36;
NSUInteger const DCiPhoneLandscapeTimeLabelFontSize = 260;
NSUInteger const DCiPhonePortraitTimeLabelsFontSize = 220;
NSUInteger const DCiPadLandscapeTimeLabelFontSize = 500;
NSUInteger const DCiPadPortraitTimeLabelsFontSize = 500;


CGFloat const DCMinimumScreenBrightness = 0.005;

NSInteger const DCInitialFontIndex = 6;

@implementation DCClockConstants

+(UIColor *)viewBackgroundColor
{
    return [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
}

+(UIColor *)cellBackgroundColor
{
    return [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
}

+(UIColor *)highlightedCellBackgroundColor
{
    return [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
}

+(UIColor *)settingsSectionFontColor
{
    return [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
}


@end






