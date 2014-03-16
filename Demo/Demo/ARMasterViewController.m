//
//  ARMasterViewController.m
//  ARTiledImageView
//
//  Created by Daniel Doubrovkine on 3/10/14.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import "ARMasterViewController.h"
#import "ARTiledImageDemoViewController.h"

@implementation ARMasterViewController

- (void)viewDidLoad
{
    self.title = @"ARTiledImageView Demo";
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
            cell.textLabel.text = @"Armory 2014 (w/Grid)";
            break;
        case 2:
            cell.textLabel.text = @"Goya: Señora Sabasa Garcia";
            break;
        default:
            break;
    }

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ARTiledImageDemoViewController *vc = [[ARTiledImageDemoViewController alloc] init];
        vc.tilesURL = [NSURL URLWithString:@"https://raw.github.com/dblock/ARTiledImageView/master/Demo/Tiles/Armory2014"];
        vc.tiledSize = CGSizeMake(5000, 5389);
        vc.minTileLevel = 11;
        vc.maxTileLevel = 13;
        [self.navigationController pushViewController:vc animated:YES];

    } else if (indexPath.row == 1) {
        ARTiledImageDemoViewController *vc = [[ARTiledImageDemoViewController alloc] init];
        vc.tilesURL = [NSURL URLWithString:@"https://raw.github.com/dblock/ARTiledImageView/master/Demo/Tiles/Armory2014"];
        vc.tiledSize = CGSizeMake(5000, 5389);
        vc.minTileLevel = 11;
        vc.maxTileLevel = 13;
        vc.displayTileBorders = YES;
        [self.navigationController pushViewController:vc animated:YES];

    } else if (indexPath.row == 2) {
        ARTiledImageDemoViewController *vc = [[ARTiledImageDemoViewController alloc] init];
        // https://artsy.net/artwork/francisco-jose-de-goya-y-lucientes-senora-sabasa-garcia
        // (Courtesy National Gallery of Art, Washington)
        vc.tilesURL = [NSURL URLWithString:@"https://raw.github.com/dblock/ARTiledImageView/master/Demo/Tiles/SenoraSabasaGarcia"];
        vc.tiledSize = CGSizeMake(2383, 2933);
        vc.minTileLevel = 11;
        vc.maxTileLevel = 12;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
