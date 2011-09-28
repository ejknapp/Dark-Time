//
//  DCInfoViewController.m
//  DarkTimePhone
//
//  Created by Eric Knapp on 6/22/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import "DCInfoViewController.h"
#import "DCClockState.h"

@interface DCInfoViewController ()

-(void)doneButtonTapped:(id)sender;

@end


@implementation DCInfoViewController

@synthesize clockState = _clockState;
@synthesize infoWebView = _infoWebView;

-(id)initWithViewFrame:(CGRect)viewFrame
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
    
    UIView *newView = [[UIView alloc] initWithFrame:CGRectZero];
    newView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view = newView;
    [newView release];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *pathToHtml = [resourcePath stringByAppendingPathComponent:@"Info"];
    NSURL *baseURL = [[NSURL alloc] initFileURLWithPath:pathToHtml isDirectory:YES];

    
    NSString *html = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle]    
                                                         pathForResource:@"info" ofType:@"html"                                                                                                                       
                                                         inDirectory:@"Info"] 
                                               encoding:NSUTF8StringEncoding error:nil];
    
    UIWebView *newWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    newWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.infoWebView = newWebView;

    self.infoWebView.delegate = self;
    [newWebView release];
    
    self.infoWebView.backgroundColor = [UIColor blackColor];
    
    [self.infoWebView loadHTMLString:html baseURL:baseURL];
    [self.view addSubview:self.infoWebView];
    
    [html release];
    [baseURL release];

}

-(void)doneButtonTapped:(id)sender
{
    self.clockState.infoPageViewDisplayed = NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    self.infoWebView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft 
            || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
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

-(void)dealloc
{
    [_clockState release];

    [_infoWebView release];
    
    [super dealloc];
}

@end
