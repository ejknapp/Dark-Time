//
//  DCIFont.m
//  DarkTime
//
//  Created by Eric Knapp on 2/27/12.
//  Copyright (c) 2012 Madison Area Technical College. All rights reserved.
//

#import "DCIFont.h"
#import "DCClockConstants.h"

@interface DCIFont ()

@property (strong, nonatomic, readwrite) NSString *fontName;
@property (strong, nonatomic, readwrite) NSString *displayName;
@property (assign, nonatomic) CGSize iPhoneHourFrameOffset;
@property (assign, nonatomic) CGSize iPhoneMinuteFrameOffset;
@property (assign, nonatomic) CGSize iPadHourFrameOffset;
@property (assign, nonatomic) CGSize iPadMinuteFrameOffset;

@end


@implementation DCIFont

@synthesize fontName = _fontName;
@synthesize displayName = _displayName;
@synthesize iPhoneHourFrameOffset = _iPhoneHourFrameOffset;
@synthesize iPhoneMinuteFrameOffset = _iPhoneMinuteFrameOffset;
@synthesize iPadHourFrameOffset = _iPadHourFrameOffset;
@synthesize iPadMinuteFrameOffset = _iPadMinuteFrameOffset;

- (id)initWithFontDictionary:(NSDictionary *)fontDictionary
{
    self = [super init];
    if (self) {
        _fontName = [fontDictionary objectForKey:@"fontName"];
        _displayName = [fontDictionary objectForKey:@"displayName"];
        _iPhoneHourFrameOffset = CGSizeFromString([fontDictionary objectForKey:@"iPhoneHourFrameOffset"]);
        _iPhoneMinuteFrameOffset = CGSizeFromString([fontDictionary objectForKey:@"iPhoneMinuteFrameOffset"]);
        _iPadHourFrameOffset = CGSizeFromString([fontDictionary objectForKey:@"iPadHourFrameOffset"]);
        _iPadMinuteFrameOffset = CGSizeFromString([fontDictionary objectForKey:@"iPadMinuteFrameOffset"]);
    }
    return self;
}

-(CGSize)minuteOffsetWithDevice:(DCIDarkTimeDevice)device;
{
    
    if (device == DCIDarkTimeDeviceiPad) {
        return self.iPadMinuteFrameOffset;
    } else {
        return self.iPhoneMinuteFrameOffset;
    }
}

-(CGSize)hourOffsetWithDevice:(DCIDarkTimeDevice)device;
{
    if (device == DCIDarkTimeDeviceiPad) {
        return self.iPadHourFrameOffset;
    } else {
        return self.iPhoneHourFrameOffset;
    }
    
}



-(NSString *)description
{
    return [[NSString alloc] initWithFormat:@"DCIFont: %@, %@, %@, %@, %@, %@", 
            self.fontName,
            self.displayName,
            NSStringFromCGSize(self.iPhoneHourFrameOffset), 
            NSStringFromCGSize(self.iPhoneMinuteFrameOffset),
            NSStringFromCGSize(self.iPadHourFrameOffset), 
            NSStringFromCGSize(self.iPadMinuteFrameOffset)];
}


@end





