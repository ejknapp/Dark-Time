//
//  DCInfoViewController.m
//  DarkTimePhone
//
//  Created by Eric Knapp on 6/22/11.
//  Copyright 2011 Dovetail Computing, Inc.. All rights reserved.
//

#import "DCInfoViewController.h"
#import "DCClockState.h"
#import "DCDarkClockViewController.h"

@interface DCInfoViewController ()

-(void)doneButtonTapped:(id)sender;

@end


@implementation DCInfoViewController

-(instancetype)initWithViewFrame:(CGRect)viewFrame
{
    
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)loadView
{
    
    self.view = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *pathToHtml = [resourcePath stringByAppendingPathComponent:@"Info"];
    NSURL *baseURL = [[NSURL alloc] initFileURLWithPath:pathToHtml isDirectory:YES];

    
    NSString *html = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle]    
                                                         pathForResource:@"info" ofType:@"html"                                                                                                                       
                                                         inDirectory:@"Info"] 
                                               encoding:NSUTF8StringEncoding error:nil];
    NSMutableString *mutableHTML = [[NSMutableString alloc] initWithString:html];
    
    NSString *logoName;
    
    if([[UIScreen mainScreen] scale] >= 2.0) {
        /* We have a retina display. */
        logoName = @"logo@2x.png";
    } else {
        /* We do not. */
        logoName = @"logo.png";
    }

    NSRange logoImageRange = [mutableHTML rangeOfString:@"LOGO_IMAGE"];

    [mutableHTML replaceCharactersInRange:logoImageRange withString:logoName];
    
    self.infoWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    self.infoWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.infoWebView.delegate = self;
    self.infoWebView.backgroundColor = [UIColor blackColor];
    
    [self.infoWebView loadHTMLString:mutableHTML baseURL:baseURL];
    [self.view addSubview:self.infoWebView];
    

}

-(void)doneButtonTapped:(id)sender
{
    self.clockState.infoPageViewDisplayed = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation 
                                duration:(NSTimeInterval)duration
{

    self.clockState.currentOrientation = toInterfaceOrientation;
    [self.clockViewController switchToOrientationView:self.clockState.currentOrientation];
    
    [self.clockViewController.view layoutIfNeeded];
    
}

- (BOOL)webView:(UIWebView *)webView 
shouldStartLoadWithRequest:(NSURLRequest *)request 
 navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    
    return YES;
}


@end
