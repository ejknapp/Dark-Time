//
//  DCNewClockEditorViewController.m
//  DarkTimePhone
//
//  Created by Eric Knapp on 6/27/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import "DCNewClockEditorViewController.h"
#import "DCClockState.h"
    

@interface DCNewClockEditorViewController ()



-(void)createToolBar;
-(void)createFontPicker;
-(void)createAmPmSwitch;
-(void)createSecondsSwitch;


@end

@implementation DCNewClockEditorViewController



@synthesize clockState = _clockState;

@synthesize fontPicker = _fontPicker;
@synthesize ampmLabel = _ampmLabel;
@synthesize secondsLabel = _secondsLabel;

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

- (void)loadView
{
    NSLog(@"In font editor loadView");
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
    self.view = baseView;
    [baseView release];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self createToolBar];
    [self createFontPicker];
    [self createAmPmSwitch];
    [self createSecondsSwitch];
    
    NSLog(@"In font editor end of loadView");

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.fontPicker = nil;
    self.ampmLabel = nil;
    self.secondsLabel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft 
            || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark - Interface creation methods

-(void)createSecondsSwitch
{

    UILabel *display = [[UILabel alloc] initWithFrame:CGRectMake(306, 245, 125, 40)];
    display.text = @"Display Seconds";
    display.textColor = [UIColor grayColor];
    display.backgroundColor = [UIColor blackColor];
    display.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:16];
    
    [self.view addSubview:display];
    [display release];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(415, 259, 61, 61)];
    label.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:35];
    label.text = @"57";
    label.textColor = [UIColor redColor];
    label.backgroundColor = [UIColor clearColor];
    self.secondsLabel = label;
    [label release];
    
    [self.view addSubview:self.secondsLabel];
    
    
    UISwitch *secondsSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(315, 276, 94, 27)];
    [secondsSwitch addTarget:self action:@selector(secondsSwitchTapped:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:secondsSwitch];
    [secondsSwitch release];
    
    if (self.clockState.displaySeconds) {
        self.secondsLabel.alpha = 1.0;
        secondsSwitch.on = YES;
    } else {
        self.secondsLabel.alpha = 0.2;
        secondsSwitch.on = NO;
    }
    
}

-(void)createAmPmSwitch
{
    UILabel *display = [[UILabel alloc] initWithFrame:CGRectMake(61, 245, 150, 40)];
    display.text = @"Display AM/PM";
    display.textColor = [UIColor grayColor];
    display.backgroundColor = [UIColor clearColor];
    display.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:16];
    
    [self.view addSubview:display];
    [display release];


    UILabel *ampmLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 259, 61, 61)];
    ampmLabel.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:35];
    ampmLabel.text = @"AM";
    ampmLabel.textColor = [UIColor redColor];
    ampmLabel.backgroundColor = [UIColor clearColor];
    self.ampmLabel = ampmLabel;
    [ampmLabel release];
    
    [self.view addSubview:self.ampmLabel];
    
    
    
    UISwitch *amPmSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(70, 276, 94, 27)];
    [amPmSwitch addTarget:self 
                   action:@selector(amPmSwitchTapped:) 
         forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:amPmSwitch];
    [amPmSwitch release];

    if (self.clockState.displayAmPm) {
        self.ampmLabel.alpha = 1.0;
        amPmSwitch.on = YES;
    } else {
        self.ampmLabel.alpha = 0.4;
        amPmSwitch.on = NO;
    }
    
}

-(void)createFontPicker
{
    UILabel *display = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 480, 30)];
    display.text = @"Scroll to Select Font";
    display.textColor = [UIColor grayColor];
    display.backgroundColor = [UIColor blackColor];
    display.textAlignment = UITextAlignmentCenter;
    display.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:18];
    
    [self.view addSubview:display];
    [display release];

    
    NSString *fontName = self.clockState.currentFontName;
    NSUInteger index = [self.clockState.fontNames indexOfObject:fontName];
        
    NSInteger rowSelection = index + ([self.clockState.fontNames count] * 500);
    
    UIView *pickerBacker = [[UIView alloc] initWithFrame:CGRectMake(0, 79, 480, 162)];
    pickerBacker.backgroundColor = [UIColor whiteColor];
    
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 480, 162)];
    self.fontPicker = picker;
    [picker release];
    
    self.fontPicker.delegate = self;
    self.fontPicker.dataSource = self;
    [self.fontPicker selectRow:rowSelection inComponent:0 animated:NO];
    
    [pickerBacker addSubview:picker];
    
    [self.view addSubview:pickerBacker];
    
    [pickerBacker release];

}

-(void)createToolBar
{
    UIToolbar *topBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 480, 44)];
    topBar.barStyle = UIBarStyleBlack;
    topBar.translucent = NO;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" 
                                                                   style:UIBarButtonItemStyleBordered 
                                                                  target:self 
                                                                  action:@selector(doneButtonTapped:)];

    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *helpButton = [[UIBarButtonItem alloc] initWithTitle:@"Help" 
                                                                   style:UIBarButtonItemStyleBordered 
                                                                  target:self 
                                                                  action:@selector(helpButtonTapped:)];

    NSArray *items = [[NSArray alloc] initWithObjects:helpButton, flex, doneButton, nil];

    [topBar setItems:items animated:NO];

    [self.view addSubview:topBar];
    
    [doneButton release];
    [flex release];
    [helpButton release];
    [items release];
    [topBar release];

}

#pragma mark - Event handlers


-(void)helpButtonTapped:(id)sender
{
    [self.clockState setInfoPageViewDisplayed:YES];
}

-(void)doneButtonTapped:(id)sender
{

    [self dismissModalViewControllerAnimated:YES];
}

-(void)amPmSwitchTapped:(id)sender
{
//    DCClockState *clockState = [DCClockState sharedClockTimerState];
    
    UISwitch *ampmSwitch = (UISwitch *)sender;
    
    self.clockState.displayAmPm = ampmSwitch.on;
    
    if (self.clockState.displayAmPm) {
        [UIView animateWithDuration:0.4 animations:^{
            self.ampmLabel.alpha = 1.0;
        }];
    } else {
        [UIView animateWithDuration:0.4 animations:^{
            self.ampmLabel.alpha = 0.5;
        }];
    }
}

-(void)secondsSwitchTapped:(id)sender
{
//    DCClockState *clockState = [DCClockState sharedClockTimerState];
    
    UISwitch *secondsSwitch = (UISwitch *)sender;
    
    self.clockState.displaySeconds = secondsSwitch.on;
    
    if (self.clockState.displaySeconds) {
        [UIView animateWithDuration:0.4 animations:^{
            self.secondsLabel.alpha = 1.0;
        }];
    } else {
        [UIView animateWithDuration:0.4 animations:^{
            self.secondsLabel.alpha = 0.5;
        }];
    }
}

#pragma mark - Picker Delegate methods

- (void)pickerView:(UIPickerView *)pickerView 
      didSelectRow:(NSInteger)row 
       inComponent:(NSInteger)component
{
    
//    DCClockState *state = [DCClockState sharedClockTimerState];
    NSInteger realRow = row % [self.clockState.fontNames count];
    
    [self.clockState changeFontWithName:[self.clockState.fontNames objectAtIndex:realRow]];
        
}

- (CGFloat)pickerView:(UIPickerView *)pickerView 
rowHeightForComponent:(NSInteger)component
{
    return 110;
}

- (UIView *)pickerView:(UIPickerView *)pickerView 
            viewForRow:(NSInteger)row 
          forComponent:(NSInteger)component 
           reusingView:(UIView *)view
{
    
    NSInteger realRow = row % [self.clockState.fontNames count];
    
    UIView *backing;
    UILabel *label;
        
    if (view == NULL) {
        backing = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 420, 110)];
        backing.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
        label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 420, 120)] autorelease];
        label.textColor = [UIColor redColor];
        label.textAlignment = UITextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.text = @"8:58";
        label.adjustsFontSizeToFitWidth = NO;
        label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        [backing addSubview:label];
    } else {
        backing = (UILabel *)view;
        label = [[backing subviews] objectAtIndex:0];
    }
    
    label.font = [UIFont fontWithName:[self.clockState.fontNames objectAtIndex:realRow] size:135];
    
    return backing;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 420;
}

#pragma mark - Picker Datasource methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView 
numberOfRowsInComponent:(NSInteger)component
{
    return INT16_MAX;
}


-(void)dealloc
{
    
    [_clockState release];
    [_fontPicker release];
    [_ampmLabel release];
    [_secondsLabel release];

    
    [super dealloc];
}


@end



