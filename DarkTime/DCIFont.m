//
//  DCIFont.m
//  DarkTime
//
//  Created by Eric Knapp on 2/27/12.
//  Copyright (c) 2012 Madison Area Technical College. All rights reserved.
//

#import "DCIFont.h"

@interface DCIFont ()

@property (strong, nonatomic, readwrite) NSString *fontName;
@property (strong, nonatomic) NSNumber *iPhoneHourFrameOffsetY;
@property (strong, nonatomic) NSNumber *iPhoneMinuteFrameOffsetY;
@property (strong, nonatomic) NSNumber *iPadHourFrameOffsetY;
@property (strong, nonatomic) NSNumber *iPadMinuteFrameOffsetY;

@end


@implementation DCIFont

@synthesize fontName = _fontName;
@synthesize iPhoneHourFrameOffsetY = _iPhoneHourFrameOffsetY;
@synthesize iPhoneMinuteFrameOffsetY = _iPhoneMinuteFrameOffsetY;
@synthesize iPadHourFrameOffsetY = _iPadHourFrameOffsetY;
@synthesize iPadMinuteFrameOffsetY = _iPadMinuteFrameOffsetY;

- (id)initWithFontDictionary:(NSDictionary *)fontDictionary
{
    self = [super init];
    if (self) {
        _fontName = [fontDictionary objectForKey:@"fontName"];
        _iPhoneHourFrameOffsetY = (NSNumber *)[fontDictionary objectForKey:@"iPhoneHourFrameOffsetY"];
        _iPhoneMinuteFrameOffsetY = (NSNumber *)[fontDictionary objectForKey:@"iPhoneMinuteFrameOffsetY"];
        _iPadHourFrameOffsetY = (NSNumber *)[fontDictionary objectForKey:@"iPadHourFrameOffsetY"];
        _iPadMinuteFrameOffsetY = (NSNumber *)[fontDictionary objectForKey:@"iPadMinuteFrameOffsetY"];
    }
    return self;
}

-(NSString *)description
{
    return [[NSString alloc] initWithFormat:@"DCIFont: %@, %@, %@, %@, %@", 
            self.fontName, self.iPhoneHourFrameOffsetY, self.iPhoneMinuteFrameOffsetY,
            self.iPadHourFrameOffsetY, self.iPadMinuteFrameOffsetY];
}


@end





