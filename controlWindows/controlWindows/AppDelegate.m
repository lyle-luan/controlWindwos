//
//  AppDelegate.m
//  controlWindows
//
//  Created by ll on 14-8-2.
//  Copyright (c) 2014年 ll. All rights reserved.
//

#import "AppDelegate.h"
#import "HotKeyController.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [HotKeyController engineHotKeyListen];
}



@end
