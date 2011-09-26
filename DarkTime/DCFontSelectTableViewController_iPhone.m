//
//  DCFontSelectTableViewController_iPhone.m
//  DarkTime
//
//  Created by Eric Knapp on 9/25/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import "DCFontSelectTableViewController_iPhone.h"
#import "DCFontSelectTableViewController.h"
#import "DCDarkClockViewController_iPhone.h"
#import "DCClockState.h"

@implementation DCFontSelectTableViewController_iPhone


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger selectedRow = indexPath.row;
    UITableViewCell *tappedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    self.currentCheckedCell.accessoryType = UITableViewCellAccessoryNone;
    
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    [self.clockState changeFontWithFontIndex:selectedRow viewWidth:screenRect.size.height];
    
    tappedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.currentCheckedCell = tappedCell;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
