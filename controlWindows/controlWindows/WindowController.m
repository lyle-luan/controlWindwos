//
//  WindowController.m
//  controlWindows
//
//  Created by APP on 14-8-18.
//  Copyright (c) 2014年 ll. All rights reserved.
//

#import "WindowController.h"

@interface WindowController(WindowControllerPrivate)

+ (NSWindow *)retrospectTopWindow:(NSWindow *)thisWindow;
+ (BOOL)isWindowShouldIgnored:(NSWindow *)aWindow;

@end

@implementation WindowController

+ (NSWindow *)currentWindow
{
    NSWindow* currentWindowMaybe = nil;
    
    currentWindowMaybe = [self retrospectTopWindow:[NSApp keyWindow]];
    if (currentWindowMaybe != nil)
    {
        if (![self isWindowShouldIgnored:currentWindowMaybe])
        {
            return currentWindowMaybe;
        }
    }
	
    currentWindowMaybe = [self retrospectTopWindow:[NSApp mainWindow]];
    if (currentWindowMaybe != nil)
    {
        if (![self isWindowShouldIgnored:currentWindowMaybe])
        {
            return currentWindowMaybe;
        }
    }
    
    for (NSWindow *windowIndex in [NSApp orderedWindows])
    {
        currentWindowMaybe = [self retrospectTopWindow:windowIndex];
        if (![self isWindowShouldIgnored:currentWindowMaybe])
        {
            return currentWindowMaybe;
        }
    }
    
    return nil;
}

+ (void)notBotherMeWindow
{
    NSWindow *currentWindow = [WindowController currentWindow];
    
    [WindowController reLayout:currentWindow];
    [WindowController keepPinnedToDesktop:YES forWindow:[WindowController currentWindow] andResponseToUserInteraction:YES withAnimation:YES];
    [WindowController canotMoveWindow:currentWindow];
    [WindowController canotResizeWindow:currentWindow];
}

+ (void)botherMeAgainWindow
{
    NSWindow *currentWindow = [WindowController currentWindow];
}

+ (void)reLayout: (NSWindow *)aWindow
{
    [aWindow setFrame:[WindowController getNewWindowFrame:aWindow] display:YES animate:YES];
}

+ (void)restoreLayout
{
    
}

+ (void)keepPinnedToDesktop:(BOOL)keepPinned forWindow:(NSWindow *)aWindow andResponseToUserInteraction:(BOOL)interacted withAnimation:(BOOL)animated
{
    //TODO: interact to user
    //TODO: with animation
    [aWindow setLevel:keepPinned ? kCGDesktopIconWindowLevel+1:NSNormalWindowLevel];
}

+ (void)canotMoveWindow: (NSWindow *)aWindow
{
    [aWindow setMovable:NO];
}

+ (void)canotResizeWindow: (NSWindow *)aWindow
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSWindowDidResizeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidResize:) name:NSWindowDidResizeNotification object:nil];
}

+ (NSRect)getNewWindowFrame: (NSWindow *)aWindow
{
    NSRect frame = [aWindow frame];
    frame.origin.x = 0;
    frame.origin.y = 0;
    return frame;
}

+ (void)windowDidResize:(NSNotification *)notification
{
    NSLog(@"resize back");
}

@end

@implementation WindowController(WindowControllerPrivate)

+ (NSWindow *)retrospectTopWindow:(NSWindow *)thisWindow
{
    while ([thisWindow parentWindow])
    {
        thisWindow = [thisWindow parentWindow];
    }
    
    return thisWindow;
}

+ (BOOL)isWindowShouldIgnored:(NSWindow *)aWindow
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

@end

