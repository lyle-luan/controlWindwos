//
//  AppDelegate.m
//  controlWindows
//
//  Created by ll on 14-8-2.
//  Copyright (c) 2014年 ll. All rights reserved.
//

#import "AppDelegate.h"
#import <Carbon/Carbon.h>

OSStatus hotKeyEventHandler(EventHandlerCallRef handlerCall, EventRef event, void *data);

OSStatus hotKeyEventHandler(EventHandlerCallRef handlerCall, EventRef event, void *data)
{
    EventHotKeyID hotKeyID;
    
    OSStatus error = GetEventParameter(event, kEventParamDirectObject, typeEventHotKeyID, NULL, sizeof(EventHotKeyID), NULL, &hotKeyID);
    
    if (error)
    {
        return error;
    }
    
    if (hotKeyID.id == 1)
    {
        switch (GetEventKind(event))
        {
            case kEventHotKeyPressed:
            {
                NSLog(@"z pressed");
                break;
            }
            default:
            {
                break;
            }
        }
    }
    return noErr;
}

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self registerHotKey];
    [self installHotKeyEventHandler];
}

- (void)installHotKeyEventHandler
{
    EventTypeSpec typeSpec;
    
    typeSpec.eventClass = kEventClassKeyboard;
    typeSpec.eventKind = kEventHotKeyPressed;
    
    InstallApplicationEventHandler(&hotKeyEventHandler, 1, &typeSpec, NULL, NULL);
}

- (void)registerHotKey
{
    EventHotKeyID hotKeyID;
    EventHotKeyRef hotKeyRef;
    
    OSStatus error;
    
    hotKeyID.signature = 'rt2h';
    hotKeyID.id = 1;
    
    error = RegisterEventHotKey((UInt32)6, (UInt32)controlKey, hotKeyID, GetEventDispatcherTarget(), 0, &hotKeyRef);
    
    if (error)
    {
        NSLog(@"There was a problem registering hot key %d.", 6);
    }
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

@end
