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

@synthesize statusItem;
@synthesize welcomeWindow;
@synthesize statusItemMenu;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength: NSVariableStatusItemLength];
    NSImage *statusImage = [NSImage imageNamed:@"StatusItem"];
    [statusImage setTemplate:YES];
    statusItem.image = statusImage;
    statusItem.highlightMode = YES;
    [statusItem setMenu:statusItemMenu];
    
    [HotKeyController engineHotKeyListen];
    if (YES)
    {
        [[NSApplication sharedApplication] runModalForWindow:self.welcomeWindow];
    }
}

- (IBAction)okButtonPushed:(id)sender
{
    [self.welcomeWindow orderOut:self];
}

- (IBAction)aboutMenuItemPushed:(id)sender
{
    NSLog(@"about");
}

- (IBAction)updateMenuItem:(id)sender
{
    NSLog(@"update");
}

@end
