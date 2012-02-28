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
@property (assign, nonatomic) NSInteger currentFontIndex;
@property (strong, nonatomic) NSMutableDictionary *fonts;

-(void)loadFontDictionaries;

@end


@implementation DCIFontManager

@synthesize fontDictionaries = _fontDictionaries;
@synthesize currentFontIndex = _currentFontIndex;
@synthesize currentFont = _currentFont;
@synthesize fonts = _fonts;


- (id)init {
    self = [super init];
    if (self) {
        [self loadFontDictionaries];
    }
    return self;
}

-(void)loadFontDictionaries
{
    NSString *fontDataPath = [[NSBundle mainBundle] pathForResource:@"fontData" ofType:@"plist"];
    self.fontDictionaries = [[NSArray alloc] initWithContentsOfFile:fontDataPath];
    
    self.fonts = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *fontDictionary in self.fontDictionaries) {
        DCIFont *newFont = [[DCIFont alloc] initWithFontDictionary:fontDictionary];
        [self.fonts setObject:newFont forKey:newFont.fontName];
    }
    
    NSLog(@"fonts %@", self.fonts);
    self.currentFontIndex = DCInitialFontIndex;

}


@end
