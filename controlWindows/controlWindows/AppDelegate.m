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
//    NSLog(@"window title: %@", [self currentWindow].title);
//    [self keepPinnedToDesktop:YES forWindow:[self currentWindow] andResponseToUserInteraction:YES withAnimation:YES];
    [self performTimerBasedUpdate];
}

- (NSWindow*) currentWindow
{
    NSWindow* currentWindowMaybe = nil;

    currentWindowMaybe = [self topWindowFor:[NSApp keyWindow]];
    if (currentWindowMaybe != nil)
    {
        NSLog(@"key window");
        if (![self isWindowShouldIgnored:currentWindowMaybe])
        {
            return currentWindowMaybe;
        }
    }
    
	
    currentWindowMaybe = [self topWindowFor:[NSApp mainWindow]];
    if (currentWindowMaybe != nil)
    {
        NSLog(@"main window");
        if (![self isWindowShouldIgnored:currentWindowMaybe])
        {
            return currentWindowMaybe;
        }
    }
    
    NSLog(@"%lu", (unsigned long)[[NSApp orderedWindows] count]);
    for (NSWindow *windowIndex in [NSApp orderedWindows])
    {
        NSLog(@"order window");
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
    if ([aWindow isKindOfClass:[NSPanel class]])
    {
        NSLog(@"nspanel");
        return YES;
    }
    if (![aWindow isVisible])
    {
        NSLog(@"not isvisible");
        return YES;
    }
    return NO;
}

- (void)keepPinnedToDesktop:(BOOL)keepPinned forWindow:(NSWindow *)aWindow andResponseToUserInteraction:(BOOL)interacted withAnimation:(BOOL)animated
{
    //TODO: interact to user
    //TODO: with animation
    [aWindow setLevel:keepPinned ? kCGDesktopWindowLevel:NSNormalWindowLevel];
    [aWindow acceptsMouseMovedEvents];
}

- (void)updateCurrentUIElement
{
    NSWindow *window = [self currentWindow];
    
    NSLog(@"window title: %@", window.title);
    //[self keepPinnedToDesktop:YES forWindow:[self currentWindow] andResponseToUserInteraction:YES withAnimation:YES];
}

- (void)performTimerBasedUpdate
{
    [self updateCurrentUIElement];
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(performTimerBasedUpdate) userInfo:nil repeats:NO];
}

@end
