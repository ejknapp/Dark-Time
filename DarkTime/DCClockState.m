//
//  DCClockState.m
//  DarkTimePhone
//
//  Created by Eric Knapp on 6/2/11.
//  Copyright 2011 Dovetail Computing, Inc. All rights reserved.
//

#import "DCClockState.h"
#import "DCClockConstants.h"

@interface DCClockState ()

-(void)createFontsArray;

@end


@implementation DCClockState

@synthesize displayBackgroundColor = _displayBackgroundColor;
@synthesize timeTextColor = _timeTextColor;
@synthesize savedColorForClock = _savedColorForClock;
@synthesize calendar = _calendar;
@synthesize clockBrightnessLevel = _clockBrightnessLevel;

@synthesize formatter = _formatter;
@synthesize previousNow = _previousNow;
@synthesize displaySeconds = _displaySeconds;
@synthesize savedDisplaySeconds = _savedDisplaySeconds;
@synthesize displayAmPm = _displayAmPm;
@synthesize savedDisplayAmPm = _savedDisplayAmPm;
@synthesize currentFont =_currentFont;
@synthesize currentFontName = _currentFontName;
@synthesize currentFontIndex = _currentFontIndex;
@synthesize fontChoices = _fontChoices;
@synthesize fontEditorDisplayed = _fontEditorDisplayed;
@synthesize startingDragLocation = _startingDragLocation;
@synthesize infoPageViewDisplayed = _infoPageViewDisplayed;
@synthesize version = _version;
@synthesize displayLabelY = _displayLabelY;
@synthesize displayCenter = _displayCenter;

@synthesize fontNames = _fontNames;

-(id)init
{
    
    self = [super init];
    
    if (self) {
        NSDateFormatter *newFormatter = [[NSDateFormatter alloc] init];
        self.formatter = newFormatter;
        [self.formatter setTimeStyle:NSDateFormatterShortStyle];
        [newFormatter release];
        
        NSCalendar *newCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        self.calendar = newCalendar;
        self.clockBrightnessLevel = 1.0;
        [newCalendar release];
        
        self.displayAmPm = YES;
        self.displaySeconds = YES;
        self.fontEditorDisplayed = NO;
        self.infoPageViewDisplayed = NO;
        
        [self createFontsArray];
        
        self.version = @"b7";
        
        self.currentFontName = @"Futura-CondensedExtraBold";
        
    }
    
    return self;
}

-(void)changeFontWithName:(NSString *)fontName
{
    
    self.currentFont = [UIFont fontWithName:fontName size:225];
    self.currentFontName = fontName;
    self.displayLabelY = (320 - self.currentFont.ascender - 107) / 2;
    
}

-(void)createFontsArray 
{
    
    UIFont *futuraFont = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:300.0];
    UIFont *palatinoFont = [UIFont fontWithName:@"Palatino-Bold" size:300.0];
    UIFont *timesNewRomanFont = [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:300.0];
    UIFont *typewriterFont = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:300.0];
    
    NSArray *newArray = [[NSArray alloc] initWithObjects: 
                         palatinoFont,
                         futuraFont,
                         timesNewRomanFont, 
                         typewriterFont, 
                         nil];
    self.fontChoices = newArray;
    [newArray release];
    
    self.currentFontIndex = 1;
    self.currentFont = [self.fontChoices objectAtIndex:self.currentFontIndex];

    NSArray *fontNamesArray = [[NSArray alloc] initWithObjects:
                               @"Cochin-Bold",
                               @"Baskerville-Bold",
                               @"Palatino-Bold",
                               @"Verdana-Bold",
                               @"MarkerFelt-Wide",
                               @"Courier-Bold",
                               @"AmericanTypewriter-Bold",
                               @"Helvetica-Bold",
                               @"Futura-CondensedExtraBold",
                               @"TimesNewRomanPS-BoldMT",
                               @"TrebuchetMS-Bold",
                               @"SnellRoundhand-Bold",
                               nil];
    
    self.fontNames = fontNamesArray;
    [fontNamesArray release];
}


-(NSString *)currentTimeString
{
    
    NSDate* now = [NSDate date];
    NSString *timeString;
    
    int hour = [[self.calendar components:NSHourCalendarUnit fromDate:now] hour];
    int minute = [[self.calendar components:NSMinuteCalendarUnit fromDate:now] minute];
    
    int displayHour = hour;
    
    
    if (hour > 12) {
        displayHour -= 12;
    }
    
    if (displayHour == 0) {
        displayHour = 12;
    }
    
    timeString = [NSString stringWithFormat:@"%d:%02d", displayHour, minute];
    
    return timeString;
//    return @":58";
}

-(NSString *)currentSecondsString
{
    
    NSDate* now = [NSDate date];
    int second = [[self.calendar components:NSSecondCalendarUnit fromDate:now] second];
    
    NSString *secondsString;
    
    
    if (self.displaySeconds) {
        secondsString = [NSString stringWithFormat:@"%02d", second];
    } else {
        secondsString = [NSString stringWithFormat:@"%@", kNoSeconds];
    }
    
    return secondsString;

}

-(NSString *)currentAmPmString
{
    NSDate* now = [[NSDate alloc] init];
    
    int hour = [[self.calendar components:NSHourCalendarUnit fromDate:now] hour];
    [now release];
    
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
    
    CGFloat brightness = [userDefaults floatForKey:@"clockBrightnessLevel"];
    
    if (brightness) {
        if (brightness >= 0.1) {
            self.clockBrightnessLevel = brightness;
        } else {
            self.clockBrightnessLevel = 1.0;
        }
    } else {
        self.clockBrightnessLevel = 1.0;
    }
        
    NSString *fontName = [userDefaults stringForKey:@"currentFontName"];    
    
    if (fontName) {
        self.currentFontName = fontName;
        [self changeFontWithName:self.currentFontName];
    } else {
        [self changeFontWithName:@"Futura-CondensedExtraBold"];
    }
    


//    self.clockBrightnessLevel = 1.0;
}

- (void) saveClockState 
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:self.currentFontName forKey:@"currentFontName"];
    
    [userDefaults setFloat:self.clockBrightnessLevel forKey:@"clockBrightnessLevel"];
    
}

- (void)dealloc
{

    [_displayBackgroundColor release];
    [_timeTextColor release];
    [_savedColorForClock release];
    [_calendar release];
    [_formatter release];
    [_previousNow release];
    [_currentFont release];
    [_currentFontName release];
    [_fontChoices release];
    [_version release];
    [_fontNames release];
    
    
    [super dealloc];
}


@end
