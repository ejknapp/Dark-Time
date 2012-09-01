//
//  DCSettingsTableViewController.m
//  DarkTime
//
//  Created by Eric Knapp on 9/23/11.
//  Copyright 2011 Dovetail Computing, Inc.. All rights reserved.
//

#import "DCSettingsTableViewController.h"
#import "DCClockState.h"
#import "DCClockConstants.h"
#import "DCSettingsViewController.h"
#import "DCFontSelectTableViewController.h"
#import "DCInfoViewController.h"
#import "DCDarkClockViewController.h"
#import "DCIFontManager.h"
#import "DCIWelcomeViewController.h"


@interface DCSettingsTableViewController()

@property (nonatomic, strong) NSArray *settingsArray;

@property (weak, nonatomic) IBOutlet  UITableViewCell *displayTypeCell;
@property (strong, nonatomic) IBOutlet UISegmentedControl *displayTypeSegmentedControl;

@property (nonatomic, strong) IBOutlet UISwitch *ampmSwitch;
@property (strong, nonatomic) IBOutlet UITableViewCell *ampmCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *secondsDisplayCell;
@property (strong, nonatomic) IBOutlet UISwitch *secondsDisplaySwitch;

@property (weak, nonatomic) IBOutlet UITableViewCell *brightnessCell;
@property (nonatomic, strong) IBOutlet UISlider *brightnessSlider;

@property (nonatomic, weak) IBOutlet UITableViewCell *fontCell;
@property (strong, nonatomic) IBOutlet UILabel *fontCellLabel;

@property (nonatomic, weak) IBOutlet UITableViewCell *suspendSleepCell;
@property (strong, nonatomic) IBOutlet UISwitch *suspendSleepSwitch;

@property (nonatomic, weak) IBOutlet UITableViewCell *helpCell;

@property (nonatomic, weak) IBOutlet UITableViewCell *changeLogCell;


@end

@implementation DCSettingsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    

    self.title = @"Clock Settings";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" 
                                                                              style:UIBarButtonItemStylePlain 
                                                                             target:self 
                                                                             action:@selector(doneButtonTapped)];

    NSDictionary *timeDisplaySection = @{
        DCSettingsTableViewHeader : @"Clock Display Type",
        DCSettingsTableViewCellText : @"",
        DCSettingsTableViewFooter : @"",
        DCSettingsTableViewCellIdentifier : @"segment",
        DCSettingsTableViewCell : self.displayTypeCell
    };

    NSDictionary *ampmSection = @{
        DCSettingsTableViewHeader : @"AM/PM",
        DCSettingsTableViewCellText : @"Display AM/PM",
        DCSettingsTableViewFooter : @"",
        DCSettingsTableViewCellIdentifier : @"switch",
        DCSettingsTableViewCell : self.ampmCell
    };

    NSDictionary *secondsSection = @{
        DCSettingsTableViewHeader : @"Seconds",
        DCSettingsTableViewCellText : @"Display Seconds",
        DCSettingsTableViewFooter : @"",
        DCSettingsTableViewCellIdentifier : @"switch",
        DCSettingsTableViewCell : self.secondsDisplayCell
    };

    NSDictionary *brightnessSection = @{
        DCSettingsTableViewHeader : @"Brightness",
        DCSettingsTableViewCellText : @"Display Seconds",
        DCSettingsTableViewFooter : @"You can also swipe left and right on the clock screen to adjust brightness.",
        DCSettingsTableViewCellIdentifier : @"slider",
        DCSettingsTableViewCell : self.brightnessCell
    };
    
    NSDictionary *fontSection = @{
        DCSettingsTableViewHeader : @"Select Font",
        DCSettingsTableViewCellText : @"",
        DCSettingsTableViewFooter : @"",
        DCSettingsTableViewCellIdentifier : @"disclosure",
        DCSettingsTableViewCell : self.fontCell
    };

    NSDictionary *sleepSection = @{
        DCSettingsTableViewHeader : @"Sleep",
        DCSettingsTableViewCellText : @"Suspend Sleep",
        DCSettingsTableViewFooter : @"Caution: this may affect battery life if not using power source.",
        DCSettingsTableViewCellIdentifier : @"switch",
        DCSettingsTableViewCell : self.suspendSleepCell
    };
    
    NSDictionary *helpSection = @{
        DCSettingsTableViewHeader : @"Help",
        DCSettingsTableViewCellText : @"Dark Time Help",
        DCSettingsTableViewFooter : @"",
        DCSettingsTableViewCellIdentifier : @"disclosure",
        DCSettingsTableViewCell : self.helpCell
    };

    NSDictionary *changeLogSection = @{
        DCSettingsTableViewHeader : @"Change Log",
        DCSettingsTableViewCellText : @"Current Version",
        DCSettingsTableViewFooter : @"",
        DCSettingsTableViewCellIdentifier : @"disclosure",
        DCSettingsTableViewCell : self.changeLogCell
    };

    
    self.settingsArray = @[
        timeDisplaySection,
        ampmSection,
        secondsSection,
        brightnessSection,
        fontSection,
        sleepSection,
        helpSection,
        changeLogSection
    ];
    
    
}

-(void)doneButtonTapped
{
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}


-(void)updateFontCellDisplay
{

    if (self.fontCell) {
        self.fontCell.textLabel.text = [self.clockState.fontManager currentFontDisplayName];
        self.fontCell.textLabel.font = [self.clockState.fontManager.currentFont fontWithSize:18];
    }

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation 
                                duration:(NSTimeInterval)duration
{
    self.clockState.currentOrientation = toInterfaceOrientation;
    
    [self.clockViewController switchToOrientationView:self.clockState.currentOrientation];
    
    [self.clockViewController.view layoutIfNeeded];

}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *sectionDictionary = [self.settingsArray objectAtIndex:section];
    
    return [sectionDictionary objectForKey:DCSettingsTableViewHeader];

}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSDictionary *sectionDictionary = [self.settingsArray objectAtIndex:section];
    
    return [sectionDictionary objectForKey:DCSettingsTableViewFooter];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return [self.settingsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.clockState.clockDisplayType == DCIClockDisplayType24Hour) {
        self.displayTypeSegmentedControl.selectedSegmentIndex = 1;
        self.ampmSwitch.on = NO;
        self.ampmSwitch.enabled = NO;
    } else {
        self.displayTypeSegmentedControl.selectedSegmentIndex = 0;
        self.ampmSwitch.enabled = YES;
        self.ampmSwitch.on = self.clockState.displayAmPm;
    } 
    
    self.secondsDisplaySwitch.on = self.clockState.displaySeconds;
    
    self.brightnessSlider.value = self.clockState.clockBrightnessLevel;

    self.fontCellLabel.text = [self.clockState.fontManager currentFontDisplayName];
    self.fontCellLabel.font = [self.clockState.fontManager.currentFont fontWithSize:18];
    
    NSDictionary *section = [self.settingsArray objectAtIndex:indexPath.section];
    return [section objectForKey:DCSettingsTableViewCell];       

}

#pragma mark - Interface Action Methods

- (IBAction)timeDisplaySegmentTapped:(UISegmentedControl *)sender
{
    self.clockState.clockDisplayType = sender.selectedSegmentIndex;
    
    if (self.clockState.clockDisplayType == DCIClockDisplayType24Hour) {
        self.clockState.displayAmPm = NO;
        self.ampmSwitch.on = NO;
        self.ampmSwitch.enabled = NO;
    } else {
        self.ampmSwitch.enabled = YES;
    }
}

-(IBAction)toggleAmPm:(UISwitch *)sender
{
    self.clockState.displayAmPm = sender.on;
}

-(IBAction)toggleSeconds:(UISwitch *)sender
{
    self.clockState.displaySeconds = sender.on;
}

-(IBAction)adjustBrightness:(UISlider *)sender
{
    CGFloat brightness = sender.value;
    
    if (brightness <= DCMinimumScreenBrightness) {
        [UIScreen mainScreen].brightness = DCMinimumScreenBrightness;
    } else {
        [UIScreen mainScreen].brightness = brightness;
    }
    
    self.clockState.clockBrightnessLevel = brightness;
    [self.clockViewController updateClockDisplayColorWithBrightness:brightness];
    [[NSUserDefaults standardUserDefaults] setFloat:brightness forKey:@"clockBrightnessLevel"];
}

-(IBAction)toggleSuspendSleep:(UISwitch *)sender
{
    self.clockState.suspendSleep = sender.on;
}

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == DCDarkTimeSettingsRowFontSelector) {
        
        DCFontSelectTableViewController *controller = [[DCFontSelectTableViewController alloc] 
                                                       initWithStyle:UITableViewStyleGrouped];
        controller.clockState = self.clockState;
        controller.clockViewController = self.clockViewController;
        
        [self.navigationController pushViewController:controller animated:YES];
        
    } else if (indexPath.section == DCDarkTimeSettingsRowHelp) {
        DCInfoViewController *controller = [[DCInfoViewController alloc] 
                                            initWithNibName:nil 
                                            bundle:nil];
        controller.clockViewController = self.clockViewController;
        controller.clockState = self.clockState;
        
        [self.navigationController pushViewController:controller animated:YES];
        
    } else if (indexPath.section == DCDarkTimeSettingsRowChangeLog) {
        DCIWelcomeViewController *welcomeController = [[DCIWelcomeViewController alloc] 
                                                       initWithNibName:@"DCIWelcomeViewController" 
                                                       bundle:nil];
        [self.navigationController pushViewController:welcomeController animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
         
}

@end
