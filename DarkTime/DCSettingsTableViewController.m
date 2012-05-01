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
@property (nonatomic, strong) UITableViewCell *fontCell;
@property (nonatomic, strong) UITableViewCell *helpCell;
@property (nonatomic, strong) UISlider *brightnessSlider;

- (void)createAmPmCell:(NSIndexPath *)indexPath 
                  cell:(UITableViewCell *)cell;

- (void)createSecondsCell:(NSIndexPath *)indexPath 
                     cell:(UITableViewCell *)cell;

- (void)createBrightnessCell:(NSIndexPath *)indexPath 
                     cell:(UITableViewCell *)cell;

- (void)createFontSelectionCell:(UITableViewCell *)cell;

- (void)createSuspendSleepCell:(NSIndexPath *)indexPath 
                          cell:(UITableViewCell *)cell;

- (void)createHelpSelectionCell:(UITableViewCell *)cell 
                      indexPath:(NSIndexPath *)indexPath;

- (void)createChangeLogCell:(UITableViewCell *)cell 
                  indexPath:(NSIndexPath *)indexPath;
@end

@implementation DCSettingsTableViewController

@synthesize clockState = _clockState;
@synthesize settingsArray = _settingsArray;
@synthesize fontCell = _fontCell;
@synthesize helpCell = _helpCell;
@synthesize brightnessSlider = _brightnessSlider;

@synthesize clockViewController = _clockViewController;

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

    
    
    NSDictionary *ampmSection = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"AM/PM", DCSettingsTableViewHeader,
                                 @"Display AM/PM", DCSettingsTableViewCellText,
                                 @"", DCSettingsTableViewFooter,
                                 @"switch", DCSettingsTableViewCellIdentifier,
                                 nil];

    NSDictionary *secondsSection = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"Seconds", DCSettingsTableViewHeader,
                                 @"Display Seconds", DCSettingsTableViewCellText,
                                 @"", DCSettingsTableViewFooter,
                                 @"switch", DCSettingsTableViewCellIdentifier,
                                 nil];

    NSDictionary *brightnessSection = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    @"Brightness", DCSettingsTableViewHeader,
                                    @"", DCSettingsTableViewCellText,
                                    @"You can also swipe left and right on the clock screen to adjust brightness.", DCSettingsTableViewFooter,
                                    @"slider", DCSettingsTableViewCellIdentifier,
                                    nil];

    NSDictionary *fontSection = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    @"Select Font", DCSettingsTableViewHeader,
                                    @"", DCSettingsTableViewCellText,
                                    @"", DCSettingsTableViewFooter,
                                    @"disclosure", DCSettingsTableViewCellIdentifier,
                                    nil];

    NSDictionary *sleepSection = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"Sleep", DCSettingsTableViewHeader,
                                 @"Suspend Sleep", DCSettingsTableViewCellText,
                                 @"Caution: this may affect battery life if not using power source.", DCSettingsTableViewFooter,
                                 @"switch", DCSettingsTableViewCellIdentifier,
                                 nil];

    NSDictionary *helpSection = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  @"Help", DCSettingsTableViewHeader,
                                  @"Dark Time Help", DCSettingsTableViewCellText,
                                  @"", DCSettingsTableViewFooter,
                                  @"disclosure", DCSettingsTableViewCellIdentifier,
                                  nil];

    NSDictionary *changeLogSection = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"Change Log", DCSettingsTableViewHeader,
                                 @"Current Version: ", DCSettingsTableViewCellText,
                                 @"", DCSettingsTableViewFooter,
                                 @"disclosure", DCSettingsTableViewCellIdentifier,
                                 nil];

    
    self.settingsArray = [[NSArray alloc] initWithObjects:
                         ampmSection, 
                         secondsSection, 
                         brightnessSection,
                         fontSection,
                         sleepSection,
                         helpSection,
                         changeLogSection,
                         nil];
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.settingsArray = nil;
    self.fontCell = nil;
    self.helpCell = nil;
    self.brightnessSlider = nil;
    
    
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

#pragma mark - Cell Configuration

- (void)createAmPmCell:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell
{
    UISwitch *cellSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    cell.textLabel.text = [[self.settingsArray objectAtIndex:indexPath.section] 
                           objectForKey:DCSettingsTableViewCellText];
    
    [cellSwitch addTarget:self 
                   action:@selector(toggleAmPm:) 
         forControlEvents:UIControlEventValueChanged];
    
    cellSwitch.on = self.clockState.displayAmPm;
    cell.accessoryView = cellSwitch;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)createSecondsCell:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell
{
    UISwitch *cellSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    cell.textLabel.text = [[self.settingsArray objectAtIndex:indexPath.section] 
                           objectForKey:DCSettingsTableViewCellText];
    
    [cellSwitch addTarget:self 
                   action:@selector(toggleSeconds:) 
         forControlEvents:UIControlEventValueChanged];
    
    cellSwitch.on = self.clockState.displaySeconds;
    cell.accessoryView = cellSwitch;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)createBrightnessCell:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell
{

    //UIInterfaceOrientation orientation = 
    
    CGRect sliderRect;
    if (!self.brightnessSlider) {
        sliderRect = CGRectMake(10, 0, 295, 45);
        
        self.brightnessSlider               = [[UISlider alloc] initWithFrame:sliderRect];
        self.brightnessSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.brightnessSlider.minimumValue  = 0.0;
        self.brightnessSlider.maximumValue  = 1.0;
    }

    
    NSString *path = [[NSBundle mainBundle] 
                      pathForResource:@"brightness-dim" 
                      ofType:@"png"];

    UIImage *dim = [[UIImage alloc] initWithContentsOfFile:path];
    
    self.brightnessSlider.minimumValueImage = dim;
    
    path = [[NSBundle mainBundle] 
            pathForResource:@"brightness-bright" 
            ofType:@"png"];
    
    UIImage *bright = [[UIImage alloc] initWithContentsOfFile:path];
    
    self.brightnessSlider.maximumValueImage = bright;
    

    cell.textLabel.text = [[self.settingsArray objectAtIndex:indexPath.section] 
                           objectForKey:DCSettingsTableViewCellText];
    
    [self.brightnessSlider addTarget:self 
                   action:@selector(adjustBrightness:) 
         forControlEvents:UIControlEventValueChanged];
    
    self.brightnessSlider.value = self.clockState.clockBrightnessLevel;
    
    [cell.contentView addSubview:self.brightnessSlider];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)createFontSelectionCell:(UITableViewCell *)cell
{
    cell.textLabel.text = [self.clockState.fontManager currentFontDisplayName];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.textLabel.font = [self.clockState.fontManager.currentFont fontWithSize:18];
    self.fontCell = cell;

}

- (void)createSuspendSleepCell:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell
{
    UISwitch *cellSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    cell.textLabel.text = [[self.settingsArray objectAtIndex:indexPath.section] 
                           objectForKey:DCSettingsTableViewCellText];
    
    [cellSwitch addTarget:self 
                   action:@selector(toggleSuspendSleep:) 
         forControlEvents:UIControlEventValueChanged];
    
    cellSwitch.on = self.clockState.suspendSleep;
    cell.accessoryView = cellSwitch;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    

}

- (void)createHelpSelectionCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = [[self.settingsArray objectAtIndex:indexPath.section] 
                           objectForKey:DCSettingsTableViewCellText];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    self.helpCell = cell;
    
}

- (void)createChangeLogCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    NSString *appVersion = self.clockState.version;
    
    NSString *cellPrefix = [[self.settingsArray objectAtIndex:indexPath.section] 
                            objectForKey:DCSettingsTableViewCellText];
    NSString *cellText = [NSString stringWithFormat:@"%@ %@", cellPrefix, appVersion];
    
    cell.textLabel.text = cellText;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [[self.settingsArray objectAtIndex:indexPath.section] 
                                objectForKey:DCSettingsTableViewCellIdentifier];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == DCDarkTimeSettingsRowDisplayAmPm) {
        [self createAmPmCell:indexPath cell:cell];
    } else if (indexPath.section == DCDarkTimeSettingsRowDisplaySeconds) {
        [self createSecondsCell:indexPath cell:cell];
    } else if (indexPath.section == DCDarkTimeSettingsRowAdjustBrightness) {
        [self createBrightnessCell:indexPath cell:cell];
    } else if (indexPath.section == DCDarkTimeSettingsRowFontSelector) {
        [self createFontSelectionCell:cell];
    } else if (indexPath.section == DCDarkTimeSettingsRowSuspendSleep) {
        [self createSuspendSleepCell:indexPath cell:cell];
    } else if (indexPath.section == DCDarkTimeSettingsRowHelp) {
        [self createHelpSelectionCell:cell indexPath:indexPath];
    } else if (indexPath.section == DCDarkTimeSettingsRowChangeLog) {
        [self createChangeLogCell:cell indexPath:indexPath];
    }
        
    return cell;
}

#pragma mark - Interface Action Methods

-(void)toggleAmPm:(id)sender
{
    self.clockState.displayAmPm = ((UISwitch *)sender).on;
}

-(void)toggleSeconds:(id)sender
{
    self.clockState.displaySeconds = ((UISwitch *)sender).on;
}

-(void)adjustBrightness:(id)sender
{
    CGFloat brightness = ((UISlider *)sender).value;
    
    
    if (brightness <= DCMinimumScreenBrightness) {
        [UIScreen mainScreen].brightness = DCMinimumScreenBrightness;
    } else {
        [UIScreen mainScreen].brightness = brightness;
    }
    
    self.clockState.clockBrightnessLevel = brightness;
    [self.clockViewController updateClockDisplayColorWithBrightness:brightness];
    [[NSUserDefaults standardUserDefaults] setFloat:brightness forKey:@"clockBrightnessLevel"];
}

-(void)toggleSuspendSleep:(id)sender
{
    self.clockState.suspendSleep = ((UISwitch *)sender).on;
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
