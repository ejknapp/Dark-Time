//
//  DCIFont.h
//  DarkTime
//
//  Created by Eric Knapp on 2/27/12.
//  Copyright (c) 2012 Madison Area Technical College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCClockConstants.h"

@interface DCIFont : NSObject

@property (strong, nonatomic, readonly) NSString *fontName;
@property (strong, nonatomic, readonly) NSString *displayName;

- (instancetype)initWithFontDictionary:(NSDictionary *)fontDictionary;
-(CGSize)minuteOffsetWithDevice:(DCIDarkTimeDevice)device;
-(CGSize)hourOffsetWithDevice:(DCIDarkTimeDevice)device;

@end
