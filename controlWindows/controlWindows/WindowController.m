//
//  WindowController.m
//  controlWindows
//
//  Created by APP on 14-8-18.
//  Copyright (c) 2014年 ll. All rights reserved.
//

#import "WindowController.h"
#import "OriginalWindowStateItem.h"
#import "OriginalWindowStateManager.h"
#import "WindowPositionManager.h"

@interface WindowController(WindowControllerPrivate)

- (NSWindow *)topWindow;
- (void)backupOriginalState;
- (void)reLayoutWindows;
- (void)spinCurrentWindowToDesktop:(BOOL)spinned isUnderIcon:(BOOL)underIcon responseToUserInteraction:(BOOL)interacted;
- (void)dontMoveCurrentWindow;
- (void)dontResizeCurrentWindow;

@end

@implementation WindowController

+ (WindowController *)getInstance
{
    static WindowController *windowController = nil;
    if (windowController == nil)
    {
        windowController = [[super allocWithZone:nil] init];
    }
    return windowController;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self getInstance];
}

- (void)dontBotherMeWindow
{
    self.currentWindow = [self topWindow];
    [self backupOriginalState];
    [self reLayoutWindows];
    [self spinCurrentWindowToDesktop:YES isUnderIcon:NO responseToUserInteraction:YES];
    [self dontMoveCurrentWindow];
    [self dontResizeCurrentWindow];
}

- (void)canBotherMeAgainWindow
{
    
}

- (void)needAlltimeWindow
{
    
}

- (void)notNeedAlltimeWindow
{
    
}

@end

@implementation WindowController(WindowControllerPrivate)

- (NSWindow *)topWindow
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

- (void)backupOriginalState
{
    OriginalWindowStateItem *newItem = nil;
    newItem = [[OriginalWindowStateItem alloc] initWithNSWindow:self.currentWindow];
    [[OriginalWindowStateManager getInstance] addElement:newItem];
}

- (void)reLayoutWindows
{
    [WindowPositionManager reLayoutWindowsPosition];
}

- (void)spinCurrentWindowToDesktop:(BOOL)spinned isUnderIcon:(BOOL)underIcon responseToUserInteraction:(BOOL)interacted
{
    if (spinned == YES)
    {
        [self.currentWindow setLevel:kCGDesktopIconWindowLevel+1];
    }
    else
    {
        [self.currentWindow setLevel:NSNormalWindowLevel];
    }
}

- (void)dontMoveCurrentWindow
{
    [self.currentWindow setMovable:NO];
}

- (void)dontResizeCurrentWindow
{
    [self.currentWindow setShowsResizeIndicator:NO];
    [[self.currentWindow standardWindowButton:NSWindowZoomButton] setHidden:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSWindowDidResizeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidResize:) name:NSWindowDidResizeNotification object:nil];
}

- (void)windowDidResize:(NSNotification *)notification
{
    NSLog(@"resize back");
}

+ (void)resizeWindow: (NSWindow *)aWindow
{
    NSRect frame = [aWindow frame];
    frame.origin.x = 0;
    frame.origin.y = 0;
    [aWindow setFrame:frame display:YES animate:YES];
}

- (NSWindow *)retrospectTopWindow:(NSWindow *)thisWindow
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

@end

