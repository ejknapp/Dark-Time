//
//  DCClockConstants.h
//  DarkTimePhone
//
//  Created by Eric Knapp on 6/2/11.
//  Copyright 2011 Dovetail Computing, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString * const kNoSeconds;
extern NSString * const kAmDisplay;
extern NSString * const kPmDisplay;
extern NSString * const kAmPmNoDisplay;

extern NSString * const DCSettingsTableViewHeader;
extern NSString * const DCSettingsTableViewCellText;
extern NSString * const DCSettingsTableViewFooter;
extern NSString * const DCSettingsTableViewCellIdentifier;
extern NSString * const DCSettingsTableViewCell;
extern NSString * const DCSettingsTableViewSectionFooterHeight;
extern NSString * const DCSettingsTableViewSectionRowHeight;

extern NSString * const DCFontSizeCalculationString;

extern NSString * const DCSettingsViewNibNameiPad;
extern NSString * const DCSettingsViewNibNameiPhone;

typedef enum {
    DCDarkTimeSettingsRowDisplayType = 0,
    DCDarkTimeSettingsRowDisplayAmPm,
    DCDarkTimeSettingsRowDisplaySeconds,
    DCDarkTimeSettingsRowAdjustBrightness,
    DCDarkTimeSettingsRowFontSelector,
    DCDarkTimeSettingsRowSuspendSleep,
    DCDarkTimeSettingsRowHelp,
    DCDarkTimeSettingsRowChangeLog,
} DCDarkTimeSettingsRow;

typedef enum {
    DCIDarkTimeDeviceiPhone = 0,
    DCIDarkTimeDeviceiPad
} DCIDarkTimeDevice;

typedef enum {
    DCIClockDisplayType12Hour = 0,
    DCIClockDisplayType24Hour,
} DCIClockDisplayType;

extern NSUInteger const iPadAmPmSecondsFontSize;
extern NSUInteger const iPhoneAmPmSecondsFontSize;
extern NSUInteger const DCiPhoneLandscapeTimeLabelFontSize;
extern NSUInteger const DCiPhonePortraitTimeLabelsFontSize;
extern NSUInteger const DCiPadLandscapeTimeLabelFontSize;
extern NSUInteger const DCiPadPortraitTimeLabelsFontSize;

extern CGFloat const DCMinimumScreenBrightness;

extern NSInteger const DCInitialFontIndex;

@interface DCClockConstants : NSObject 

+(UIColor *)viewBackgroundColor;
+(UIColor *)cellBackgroundColor;
+(UIColor *)highlightedCellBackgroundColor;
+(UIColor *)settingsSectionFontColor;

@end
