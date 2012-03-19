//
//  DCIFontManager.h
//  DarkTime
//
//  Created by Eric Knapp on 2/27/12.
//  Copyright (c) 2012 Madison Area Technical College. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DCClockState;
@class DCIFont;

@interface DCIFontManager : NSObject

@property (strong, nonatomic) UIFont *currentFont;
@property (assign, nonatomic) NSInteger currentFontIndex;
@property (weak, nonatomic) DCClockState *clockState;

-(void)loadFontDictionaries;
-(NSString *)currentFontDisplayName;
-(NSString *)fontNameAtIndex:(NSUInteger)index;
-(DCIFont *)fontAtIndex:(NSUInteger)index;
-(NSInteger)fontCount;

-(CGRect)adjustHourFrame:(CGRect)frame withFont:(UIFont *)font;
-(CGRect)adjustMinuteFrame:(CGRect)frame withFont:(UIFont *)font;

@end
