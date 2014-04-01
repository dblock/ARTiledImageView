//
//  ARMasterViewController.m
//  ARTiledImageView
//
//  Created by Daniel Doubrovkine on 3/10/14.
//  Copyright (c) 2014 Artsy. All rights reserved.
//
// Goya painting, Courtesy National Gallery of Art, Washington, via Artsy
// https://artsy.net/artwork/francisco-jose-de-goya-y-lucientes-senora-sabasa-garcia

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
    return 4;
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
            cell.textLabel.text = @"Armory 2014 (Web)";
            break;
        case 1:
            cell.textLabel.text = @"Armory 2014 (Web, w/Grid)";
            break;
        case 2:
            cell.textLabel.text = @"Goya: Señora S. Garcia (Local)";
            break;
        case 3:
            cell.textLabel.text = @"Goya: Señora S. Garcia (Web)";
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
        vc.tilesURL = [NSURL URLWithString:@"https://raw.github.com/dblock/ARTiledImageView/master/Tiles/Armory2014"];
        vc.tiledSize = CGSizeMake(5000, 5389);
        vc.minTileLevel = 11;
        vc.maxTileLevel = 13;
        [self.navigationController pushViewController:vc animated:YES];

    } else if (indexPath.row == 1) {
        ARTiledImageDemoViewController *vc = [[ARTiledImageDemoViewController alloc] init];
        vc.tilesURL = [NSURL URLWithString:@"https://raw.github.com/dblock/ARTiledImageView/master/Tiles/Armory2014"];
        vc.tiledSize = CGSizeMake(5000, 5389);
        vc.minTileLevel = 11;
        vc.maxTileLevel = 13;
        vc.displayTileBorders = YES;
        [self.navigationController pushViewController:vc animated:YES];

    } else if (indexPath.row == 2) {
        ARTiledImageDemoViewController *vc = [[ARTiledImageDemoViewController alloc] init];
        vc.tilesPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Tiles/SenoraSabasaGarcia"];
        vc.tiledSize = CGSizeMake(2383, 2933);
        vc.minTileLevel = 11;
        vc.maxTileLevel = 12;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row == 3) {
        ARTiledImageDemoViewController *vc = [[ARTiledImageDemoViewController alloc] init];
        vc.tilesURL = [NSURL URLWithString:@"https://raw.github.com/dblock/ARTiledImageView/master/Tiles/SenoraSabasaGarcia"];
        vc.tiledSize = CGSizeMake(2383, 2933);
        vc.minTileLevel = 11;
        vc.maxTileLevel = 12;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
