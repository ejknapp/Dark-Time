//
//  DCHelpViewController.m
//  DarkTime
//
//  Created by Eric Knapp on 9/30/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import "DCHelpViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DCHelpViewController()

@property (nonatomic, retain) UIView *baseView;

@end


@implementation DCHelpViewController

@synthesize scrollView = _scrollView;
@synthesize baseView = _baseView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect viewRect = self.parentViewController.view.frame;

    NSLog(@"%@", NSStringFromCGRect(viewRect));
    
    CGSize scrollSize = CGSizeMake(viewRect.size.width, 700);
    self.scrollView.contentSize = scrollSize;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 10, viewRect.size.width - 20, 680)];
    view.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1.0];
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    view.layer.borderWidth = 1;
    
    self.baseView = view;
    [view release];
    
    [self.scrollView addSubview:self.baseView];
    
    UILabel *welcome = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 460, 35)];
    welcome.text = @"Welcome to Dark Time";
    welcome.textAlignment = UITextAlignmentCenter;
    welcome.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    welcome.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1.0];
    welcome.font = [UIFont boldSystemFontOfSize:40];
    
    [self.baseView addSubview:welcome];
    [welcome release];
    
    NSString *path = [[NSBundle mainBundle] 
            pathForResource:@"logo" 
            ofType:@"png"];
    
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
    UIImageView *logo = [[UIImageView alloc] initWithImage:image];
    logo.center = CGPointMake(75, 140);
    
    [self.baseView addSubview:logo];
    [path release];
    [image release];
    [logo release];
    
    UITextView *firstText = [[UITextView alloc] initWithFrame:CGRectMake(140, 85, 320, 125)];
    firstText.text = @"   Dark Time is a simple clock. It has one simple goal, to allow you to see the time, especially when it's dark. It doesn't try to look like a physical clock. It uses a very readable font";
    firstText.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
//    firstText.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1.0];
    firstText.backgroundColor = [UIColor clearColor];
    firstText.font = [UIFont systemFontOfSize:18];
    firstText.editable = NO;

    
    [self.baseView addSubview:firstText];
    [firstText release];

    
    UITextView *secondText = [[UITextView alloc] initWithFrame:CGRectMake(10, 195, 450, 100)];
    secondText.text = @"and color scheme to make the time as readable as possible.";
    secondText.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    //    secondText.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1.0];
    secondText.backgroundColor = [UIColor clearColor];
    secondText.font = [UIFont systemFontOfSize:18];
    secondText.editable = NO;
    
    [self.baseView addSubview:secondText];
    [secondText release];

    
    UILabel *dark = [[UILabel alloc] initWithFrame:CGRectMake(148, 88, 100, 24)];
    dark.text = @"Dark Time";
    dark.textColor = [UIColor colorWithRed:0.8 green:0.0 blue:0.0 alpha:1.0];
    dark.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1.0];
    dark.font = [UIFont boldSystemFontOfSize:20];
    
    [self.baseView addSubview:dark];
    [dark release];
    
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [_scrollView release];
    [super dealloc];
}
@end
