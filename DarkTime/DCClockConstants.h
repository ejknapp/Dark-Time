//
//  DCClockConstants.h
//  DarkTimePhone
//
//  Created by Eric Knapp on 6/2/11.
//  Copyright 2011 Dovetail Computing, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString * const kNoSeconds;
extern NSString * const kAmDisplay;
extern NSString * const kPmDisplay;
extern NSString * const kAmPmNoDisplay;

typedef enum {
    DCDarkTimeSettingsRowDisplayAmPm = 0,
    DCDarkTimeSettingsRowDisplaySeconds,
    DCDarkTimeSettingsRowFontSelector,
    DCDarkTimeSettingsRowSuspendSleep,
    DCDarkTimeSettingsRowHelp,
} DCDarkTimeSettingsRow;


@interface DCClockConstants : NSObject {
    
}

@end
