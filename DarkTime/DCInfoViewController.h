//
//  DCInfoViewController.h
//  DarkTimePhone
//
//  Created by Eric Knapp on 6/22/11.
//  Copyright 2011 Eric Knapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCClockState;

@interface DCInfoViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) DCClockState *clockState;
@property (nonatomic, strong) UIWebView *infoWebView;

-(id)initWithViewFrame:(CGRect)viewFrame;

@end
