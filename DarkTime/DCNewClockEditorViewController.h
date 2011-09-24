//
//  DCNewClockEditorViewController.h
//  DarkTimePhone
//
//  Created by Eric Knapp on 6/27/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCClockState;


@interface DCNewClockEditorViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, retain) DCClockState *clockState;

@property (nonatomic, retain) UIPickerView *fontPicker;
@property (nonatomic, retain) UILabel *ampmLabel;
@property (nonatomic, retain) UILabel *secondsLabel;


@end
