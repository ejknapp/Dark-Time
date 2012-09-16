//
//  DCClockState.h
//  DarkTimePhone
//
//  Created by Eric Knapp on 6/2/11.
//  Copyright 2011 Dovetail Computing, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCClockConstants.h"

@class DCIFontManager;

@interface DCClockState : NSObject

@property (assign, nonatomic) DCIClockDisplayType clockDisplayType;
@property (nonatomic, assign) CGFloat clockBrightnessLevel;
@property (nonatomic, assign) BOOL displaySeconds;
@property (nonatomic, assign) BOOL suspendSleep;
@property (nonatomic, assign) BOOL displayAmPm;
@property (nonatomic, assign, getter = isFontEditorDisplayed) BOOL fontEditorDisplayed;
@property (nonatomic, assign, getter = isInfoPageViewDisplayed) BOOL infoPageViewDisplayed;
@property (nonatomic, weak) NSString *version;
@property (assign, nonatomic) UIInterfaceOrientation currentOrientation;
@property (nonatomic, assign) NSUInteger fontSizeLandscape;
@property (nonatomic, assign) NSUInteger fontSizePortrait;
@property (assign, nonatomic) CGRect timeLabelPortraitFrame;
@property (assign, nonatomic) CGRect timeHourLabelPortraitFrame;
@property (assign, nonatomic) DCIDarkTimeDevice device;
@property (strong, nonatomic) DCIFontManager *fontManager;
@property (assign, nonatomic) NSUInteger dashedlineHeight;



-(void)loadClockState;
-(void)saveClockState;

-(NSString *)currentTimeString;
-(NSString *)currentHourString;
-(NSString *)currentMinutesString;
-(NSString *)currentSecondsString;
-(NSString *)currentAmPmString;

-(void)changeFontWithFontIndex:(NSInteger)index;


@end
