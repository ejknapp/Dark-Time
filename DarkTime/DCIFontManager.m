//
//  DCIFontManager.m
//  DarkTime
//
//  Created by Eric Knapp on 2/27/12.
//  Copyright (c) 2012 Madison Area Technical College. All rights reserved.
//

#import "DCIFontManager.h"
#import "DCClockState.h"
#import "DCIFont.h"

@interface DCIFontManager ()

@property (strong, nonatomic) NSArray *fontDictionaries;
@property (strong, nonatomic) NSMutableDictionary *fonts;

@end


@implementation DCIFontManager


-(void)loadFontDictionaries
{
    NSString *fontDataPath = [[NSBundle mainBundle] pathForResource:@"fontData" ofType:@"plist"];
    self.fontDictionaries = [[NSArray alloc] initWithContentsOfFile:fontDataPath];
    
    self.fonts = [[NSMutableDictionary alloc] init];
    
    [self.fontDictionaries enumerateObjectsUsingBlock:^(NSDictionary *fontDictionary,
                                                        NSUInteger idx,
                                                        BOOL *stop) {
        DCIFont *newFont = [[DCIFont alloc] initWithFontDictionary:fontDictionary];
        [self.fonts setObject:newFont forKey:newFont.fontName];
    }];
    
}

-(NSString *)currentFontDisplayName
{
    DCIFont *font = [self.fonts objectForKey:self.currentFont.fontName];
    
    return font.displayName;
}


-(DCIFont *)fontAtIndex:(NSUInteger)index
{
    return [self.fonts objectForKey:[self fontNameAtIndex:index]];
}

-(NSString *)fontNameAtIndex:(NSUInteger)index
{
    return [[self.fontDictionaries objectAtIndex:index] objectForKey:@"fontName"];
}


-(NSInteger)fontCount
{
    return [self.fonts count];
}

-(CGRect)adjustHourFrame:(CGRect)frame withFont:(UIFont *)font
{
    DCIFont *dciFont = [self.fonts objectForKey:font.fontName];
    
    CGSize offset = [dciFont hourOffsetWithDevice:self.clockState.device];
    
    CGRect rect = CGRectMake(frame.origin.x + offset.width, 
                             frame.origin.y + offset.height, 
                             frame.size.width, 
                             frame.size.height);
    
    return rect;
}

-(CGRect)adjustMinuteFrame:(CGRect)frame withFont:(UIFont *)font
{
    DCIFont *dciFont = [self.fonts objectForKey:font.fontName];
    
    CGSize offset = [dciFont minuteOffsetWithDevice:self.clockState.device];
    
    CGRect rect = CGRectMake(frame.origin.x + offset.width, 
                             frame.origin.y + offset.height, 
                             frame.size.width, 
                             frame.size.height);
    
    return rect;
}


@end






