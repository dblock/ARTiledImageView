//
//  ARAppDelegate.m
//  ARTiledImageView
//
//  Created by Daniel Doubrovkine on 3/10/14.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import "ARAppDelegate.h"

#import "ARMasterViewController.h"

@implementation ARAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    ARMasterViewController *masterViewController = [[ARMasterViewController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];

    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
