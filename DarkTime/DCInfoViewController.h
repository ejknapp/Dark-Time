//
//  DCInfoViewController.h
//  DarkTimePhone
//
//  Created by Eric Knapp on 6/22/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCClockState;

@interface DCInfoViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, retain) DCClockState *clockState;
@property (nonatomic, retain) UIWebView *infoWebView;

-(id)initWithViewFrame:(CGRect)viewFrame;

@end
