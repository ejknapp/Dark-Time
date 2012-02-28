//
//  DCIFontManager.h
//  DarkTime
//
//  Created by Eric Knapp on 2/27/12.
//  Copyright (c) 2012 Madison Area Technical College. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DCClockState;

@interface DCIFontManager : NSObject

@property (strong, nonatomic) UIFont *currentFont;
@property (weak, nonatomic) DCClockState *clockState;

-(void)loadFontDictionaries;
-(NSString *)fontNameAtIndex:(NSUInteger)index;
-(NSInteger)fontCount;

-(CGRect)adjustHourFrame:(CGRect)frame withFont:(UIFont *)font;
-(CGRect)adjustMinuteFrame:(CGRect)frame withFont:(UIFont *)font;

@end
