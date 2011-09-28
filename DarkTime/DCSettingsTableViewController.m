//
//  DCSettingsTableViewController.m
//  DarkTime
//
//  Created by Eric Knapp on 9/23/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import "DCSettingsTableViewController.h"
#import "DCClockState.h"
#import "DCClockConstants.h"
#import "DCSettingsViewController.h"
#import "DCFontSelectTableViewController.h"
#import "DCInfoViewController.h"

@interface DCSettingsTableViewController()

@property (nonatomic, retain) NSArray *settingsArray;
@property (nonatomic, retain) UITableViewCell *fontCell;
@property (nonatomic, retain) UITableViewCell *helpCell;


- (void)createAmPmCell:(NSIndexPath *)indexPath 
                  cell:(UITableViewCell *)cell;

- (void)createSecondsCell:(NSIndexPath *)indexPath 
                     cell:(UITableViewCell *)cell;

- (void)createFontSelectionCell:(UITableViewCell *)cell;

- (void)createSuspendSleepCell:(NSIndexPath *)indexPath 
                          cell:(UITableViewCell *)cell;

- (void)createHelpSelectionCell:(UITableViewCell *)cell 
                      indexPath:(NSIndexPath *)indexPath;
@end

@implementation DCSettingsTableViewController

@synthesize clockState = _clockState;
@synthesize settingsArray = _settingsArray;
@synthesize fontCell = _fontCell;
@synthesize helpCell = _helpCell;


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
    
    
    NSDictionary *ampmSection = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"AM/PM", @"header",
                                 @"Display AM/PM", @"cellText",
                                 @"", @"footer",
                                 @"YES", @"display",
                                 @"switch", @"cell-identifier",
                                 nil];

    NSDictionary *secondsSection = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"Seconds", @"header",
                                 @"Display Seconds", @"cellText",
                                 @"", @"footer",
                                 @"YES", @"display",
                                 @"switch", @"cell-identifier",
                                 nil];

    NSDictionary *fontSection = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    @"Select Font", @"header",
                                    @"", @"cellText",
                                    @"", @"footer",
                                    @"disclosure", @"cell-identifier",
                                    nil];

    NSDictionary *sleepSection = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"Sleep", @"header",
                                 @"Suspend Sleep", @"cellText",
                                 @"Caution: this may affect battery life if not using power source.", @"footer",
                                 @"switch", @"cell-identifier",
                                 nil];

    NSDictionary *helpSection = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  @"Help", @"header",
                                  @"Dark Time Help", @"cellText",
                                  @"", @"footer",
                                  @"disclosure", @"cell-identifier",
                                  nil];

    NSArray *sections = [[NSArray alloc] initWithObjects:
                         ampmSection, 
                         secondsSection, 
                         fontSection,
                         sleepSection,
                         helpSection,
                         nil];

    self.settingsArray = sections;
    
    
    [ampmSection release];
    [secondsSection release];
    [fontSection release];
    [sleepSection release];
    [helpSection release];
    [sections release];
}


-(void)updateFontCellDisplay
{
//    NSLog(@"updateFontCellDisplay: for DCSettingsTableViewController");
        
    if (self.fontCell) {
        self.fontCell.textLabel.text = self.clockState.currentFontName;
        self.fontCell.textLabel.font = [self.clockState.currentFont fontWithSize:18];
    }

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.settingsArray = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *sectionDictionary = [self.settingsArray objectAtIndex:section];
    
    return [sectionDictionary objectForKey:@"header"];

}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSDictionary *sectionDictionary = [self.settingsArray objectAtIndex:section];
    
    return [sectionDictionary objectForKey:@"footer"];
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
    UISwitch *cellSwitch = [[[UISwitch alloc] initWithFrame:CGRectZero] autorelease];
    cell.textLabel.text = [[self.settingsArray objectAtIndex:indexPath.section] 
                           objectForKey:@"cellText"];
    
    [cellSwitch addTarget:self 
                   action:@selector(toggleAmPm:) 
         forControlEvents:UIControlEventValueChanged];
    
    cellSwitch.on = self.clockState.displayAmPm;
    cell.accessoryView = cellSwitch;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)createSecondsCell:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell
{
    UISwitch *cellSwitch = [[[UISwitch alloc] initWithFrame:CGRectZero] autorelease];
    cell.textLabel.text = [[self.settingsArray objectAtIndex:indexPath.section] 
                           objectForKey:@"cellText"];
    
    [cellSwitch addTarget:self 
                   action:@selector(toggleSeconds:) 
         forControlEvents:UIControlEventValueChanged];
    
    cellSwitch.on = self.clockState.displaySeconds;
    cell.accessoryView = cellSwitch;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)createFontSelectionCell:(UITableViewCell *)cell
{
//    NSLog(@"in createFontSelectionCell: %@", self.clockState.currentFontName);
    cell.textLabel.text = self.clockState.currentFontName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.textLabel.font = [self.clockState.currentFont fontWithSize:18];
    self.fontCell = cell;

}

- (void)createSuspendSleepCell:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell
{
    UISwitch *cellSwitch = [[[UISwitch alloc] initWithFrame:CGRectZero] autorelease];
    cell.textLabel.text = [[self.settingsArray objectAtIndex:indexPath.section] 
                           objectForKey:@"cellText"];
    
    [cellSwitch addTarget:self 
                   action:@selector(toggleSuspendSleep:) 
         forControlEvents:UIControlEventValueChanged];
    
    cellSwitch.on = self.clockState.suspendSleep;
    cell.accessoryView = cellSwitch;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)createHelpSelectionCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"in createFontSelectionCell: %@", self.clockState.currentFontName);
    cell.textLabel.text = [[self.settingsArray objectAtIndex:indexPath.section] 
                           objectForKey:@"cellText"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    self.helpCell = cell;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [[self.settingsArray objectAtIndex:indexPath.section] 
                                objectForKey:@"cell-identifier"];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == DCDarkTimeSettingsRowDisplayAmPm) {
        [self createAmPmCell:indexPath cell:cell];
    } else if (indexPath.section == DCDarkTimeSettingsRowDisplaySeconds) {
        [self createSecondsCell:indexPath cell:cell];
    } else if (indexPath.section == DCDarkTimeSettingsRowFontSelector) {
        [self createFontSelectionCell:cell];
    } else if (indexPath.section == DCDarkTimeSettingsRowSuspendSleep) {
        [self createSuspendSleepCell:indexPath cell:cell];
    } else if (indexPath.section == DCDarkTimeSettingsRowHelp) {
        [self createHelpSelectionCell:cell indexPath:indexPath];
    }
        
    return cell;
}

-(void)toggleAmPm:(id)sender
{
    UISwitch *ampmSwitch = (UISwitch *)sender;

    self.clockState.displayAmPm = ampmSwitch.on;
}

-(void)toggleSeconds:(id)sender
{
    UISwitch *secondsSwitch = (UISwitch *)sender;
    self.clockState.displaySeconds = secondsSwitch.on;
}

-(void)toggleSuspendSleep:(id)sender
{
    UISwitch *sleepSwitch = (UISwitch *)sender;
    self.clockState.suspendSleep = sleepSwitch.on;
}

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        
        DCFontSelectTableViewController *controller = [[DCFontSelectTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        controller.clockState = self.clockState;
        
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    } else if (indexPath.section == 4) {
        DCInfoViewController *controller = [[DCInfoViewController alloc] initWithNibName:nil bundle:nil];
        
        [self.navigationController pushViewController:controller animated:YES];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
         
}

-(void)dealloc
{
    [_fontCell release];
    [_clockState release];
    [_settingsArray release];
    
    [super dealloc];
}

@end
