//
//  AppDelegate.m
//  controlWindows
//
//  Created by ll on 14-8-2.
//  Copyright (c) 2014年 ll. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSLog(@"window title: %@", [self currentWindow].title);
    [self keepPinnedToDesktop:YES forWindow:[self currentWindow] andResponseToUserInteraction:YES withAnimation:YES];
}

- (NSWindow*) currentWindow
{
    NSWindow* currentWindowMaybe = nil;

    currentWindowMaybe = [self topWindowFor:[NSApp keyWindow]];
    if (![self isWindowShouldIgnored:currentWindowMaybe])
    {
        return currentWindowMaybe;
    }
	
    currentWindowMaybe = [self topWindowFor:[NSApp mainWindow]];
    if (![self isWindowShouldIgnored:currentWindowMaybe])
    {
        return currentWindowMaybe;
    }

    for (NSWindow *windowIndex in [NSApp orderedWindows])
    {
        currentWindowMaybe = [self topWindowFor:windowIndex];
        if (![self isWindowShouldIgnored:currentWindowMaybe])
        {
            return currentWindowMaybe;
        }
    }

    return nil;
}

- (NSWindow *)topWindowFor:(NSWindow *)thisWindow;
{
    while ([thisWindow parentWindow])
    {
        thisWindow = [thisWindow parentWindow];
    }

    return thisWindow;
}

- (BOOL)isWindowShouldIgnored:(NSWindow *)aWindow
{
	return [aWindow isKindOfClass:[NSPanel class]] || ![aWindow isVisible];
}

- (void)keepPinnedToDesktop:(BOOL)keepPinned forWindow:(NSWindow *)aWindow andResponseToUserInteraction:(BOOL)interacted withAnimation:(BOOL)animated
{
    //TODO: interact to user
    //TODO: with animation
    [aWindow setLevel:keepPinned ? kCGDesktopWindowLevel:NSNormalWindowLevel];
}

@end
