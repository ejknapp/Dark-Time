//
//  DCClockState.m
//  DarkTimePhone
//
//  Created by Eric Knapp on 6/2/11.
//  Copyright 2011 Dovetail Computing, Inc. All rights reserved.
//

#import "DCClockState.h"
#import "DCClockConstants.h"
#import "DCIFontManager.h"

@interface DCClockState ()

@property (nonatomic, strong) UIColor *displayBackgroundColor;
@property (nonatomic, strong) UIColor *timeTextColor;
@property (nonatomic, strong) UIColor *savedColorForClock;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, strong) NSDate *previousNow;
@property (nonatomic, assign) BOOL savedDisplaySeconds;
@property (nonatomic, assign) BOOL savedDisplayAmPm;
@property (nonatomic, assign) BOOL screenWantsSoftwareDimming;
@property (nonatomic, strong) NSArray *fontChoices;
@property (nonatomic, assign) CGPoint startingDragLocation;
@property (nonatomic, assign) NSInteger displayLabelY;
@property (nonatomic, assign) CGPoint displayCenter;
@property (nonatomic, strong) NSArray *fontNames;



-(void)createFontsArray;
- (NSString *)applicationDocumentsDirectory;

@end


@implementation DCClockState


-(instancetype)init
{
    
    self = [super init];
    
    if (self) {
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setTimeStyle:NSDateFormatterShortStyle];
        
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _clockBrightnessLevel = 0.6;
        _currentOrientation = UIInterfaceOrientationPortrait;
        
        _displayAmPm = YES;
        _displaySeconds = YES;
        _suspendSleep = YES;
        _fontEditorDisplayed = NO;
        _infoPageViewDisplayed = NO;
        
        [self createFontsArray];
        
        _version = @"1.1";
        
        [self addObserver:self 
               forKeyPath:@"suspendSleep" 
                  options:NSKeyValueObservingOptionNew
                  context:NULL];

    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath 
                      ofObject:(id)object 
                        change:(NSDictionary *)change 
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"suspendSleep"]) {
        [[UIApplication sharedApplication] setIdleTimerDisabled:self.suspendSleep];
    }
}

-(void)changeFontWithFontIndex:(NSInteger)index
{

    self.fontManager.currentFontIndex = index;
    CGFloat fontSize;

//    NSLog(@"currentOrientation in changeFontWithFontIndex: %d", self.currentOrientation);
    if (UIInterfaceOrientationIsPortrait(self.currentOrientation)) {
//        NSLog(@"is portrait");
        fontSize = self.fontSizePortrait;
    } else {
//        NSLog(@"is landscape");
        fontSize = self.fontSizeLandscape;
    }
    
    self.fontManager.currentFont = [UIFont fontWithName:[self.fontManager
                                                         fontNameAtIndex:self.fontManager.currentFontIndex]
                                                         size:fontSize];
//    NSLog(@"font size when setting %f", fontSize);
    
}

-(void)createFontsArray 
{
    self.fontManager = [[DCIFontManager alloc] init];
    self.fontManager.clockState = self;
    [self.fontManager loadFontDictionaries];

    self.fontManager.currentFontIndex = DCInitialFontIndex;
    [self changeFontWithFontIndex:DCInitialFontIndex];
    
}

- (NSString *)applicationDocumentsDirectory
{
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *basePath = ([paths count] > 0) ? paths[0] : nil;
     return basePath;
 }


-(NSString *)currentTimeString
{
    
    NSDate *now = [NSDate date];
    NSString *timeString;
    
    NSInteger hour = [[self.calendar components:NSCalendarUnitHour fromDate:now] hour];
    NSInteger minute = [[self.calendar components:NSCalendarUnitMinute fromDate:now] minute];
    
    NSInteger displayHour = hour;
    
    
    if (hour > 12) {
        displayHour -= 12;
    }
    
    if (displayHour == 0) {
        displayHour = 12;
    }
    
    if (self.clockDisplayType == DCIClockDisplayType24Hour) {
        timeString = [NSString stringWithFormat:@"%02d:%02d", (int) hour, (int) minute];
    } else {
        timeString = [[NSString alloc] initWithFormat:@"%d:%02d", (int) displayHour, (int) minute];
    }
    
    return timeString;
//    return @"20:58";
}

-(NSString *)currentHourString
{
    NSDate *now = [NSDate date];
    NSString *hourString;
    
    NSInteger hour = [[self.calendar components:NSCalendarUnitHour fromDate:now] hour];

    NSInteger displayHour = hour;
    
    if (hour > 12) {
        displayHour -= 12;
    }
    
    if (displayHour == 0) {
        displayHour = 12;
    }
    
    if (self.clockDisplayType == DCIClockDisplayType24Hour) {
        hourString = [NSString stringWithFormat:@"%02d", (int) hour];
    } else {
        hourString = [[NSString alloc] initWithFormat:@"%d", (int) displayHour];
    }
    
    return hourString;
    
}

-(NSString *)currentMinutesString
{
    NSDate *now = [NSDate date];
    NSString *minutesString;

    NSInteger minute = [[self.calendar components:NSCalendarUnitMinute fromDate:now] minute];

    minutesString = [[NSString alloc] initWithFormat:@"%02d", (int) minute];
    
    return minutesString;

}

-(NSString *)currentSecondsString
{
    
    NSDate *now = [NSDate date];
    NSInteger second = [[self.calendar components:NSCalendarUnitSecond fromDate:now] second];
    
    NSString *secondsString;
    
    
    if (self.displaySeconds) {
        secondsString = [NSString stringWithFormat:@"%02d", (int) second];
    } else {
        secondsString = [NSString stringWithFormat:@"%@", kNoSeconds];
    }
    
    return secondsString;

}

-(NSString *)currentAmPmString
{
    NSDate *now = [[NSDate alloc] init];
    
    NSInteger hour = [[self.calendar components:NSCalendarUnitHour fromDate:now] hour];
    
    if (self.displayAmPm) {
        if (hour < 12) {
            return kAmDisplay;
        } else {
            return kPmDisplay;
        }
    } else {
        return kAmPmNoDisplay;
    }
    
}


#pragma mark - User Settings methods

- (void)loadClockState
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            
    [UIScreen mainScreen].wantsSoftwareDimming = self.screenWantsSoftwareDimming;
    
    NSInteger displayType = [userDefaults integerForKey:@"clockDisplayType"];
    
    if (displayType) {
        self.clockDisplayType = DCIClockDisplayType24Hour;
    } else {
        self.clockDisplayType = DCIClockDisplayType12Hour;
    }
    
    NSInteger fontIndex = [userDefaults integerForKey:@"currentFontIndex"];
            
    if (fontIndex >= 0) {
        [self changeFontWithFontIndex:fontIndex];
    } else {
        [self changeFontWithFontIndex:DCInitialFontIndex];
    }
    
    BOOL ampm = [userDefaults boolForKey:@"displayAmPm"];
    
    if (ampm) {
        self.displayAmPm = YES;
    } else {
        self.displayAmPm = NO;
    }

    BOOL seconds = [userDefaults boolForKey:@"displaySeconds"];
    
    if (seconds) {
        self.displaySeconds = YES;
    } else {
        self.displaySeconds = NO;
    }

    BOOL sleep = [userDefaults boolForKey:@"suspendSleep"];
    
    if (sleep) {
        self.suspendSleep = YES;
    } else {
        self.suspendSleep = NO;
    }
}

- (void) saveClockState
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setInteger:self.clockDisplayType forKey:@"clockDisplayType"];

    [userDefaults setInteger:self.fontManager.currentFontIndex forKey:@"currentFontIndex"];
    
    [userDefaults setBool:self.displayAmPm forKey:@"displayAmPm"];
    
    [userDefaults setBool:self.displaySeconds forKey:@"displaySeconds"];
    
    [userDefaults setBool:self.suspendSleep forKey:@"suspendSleep"];

}


@end







