//
//  ARMasterViewController.m
//  ARTiledImage
//
//  Created by Daniel Doubrovkine on 3/10/14.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import "ARMasterViewController.h"
#import "ARTiledImageDemoViewController.h"

@implementation ARMasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"ARTiledImageView";
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Armory 2014 Map";
            break;
        case 1:
            cell.textLabel.text = @"Armory 2014 (w/ borders)";
            break;
        default:
            break;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        ARTiledImageDemoViewController *vc = [[ARTiledImageDemoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        ARTiledImageDemoViewController *vc = [[ARTiledImageDemoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        vc.displayTileBorders = YES;
    }
}

@end
