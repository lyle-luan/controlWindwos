//
//  WindowController.m
//  controlWindows
//
//  Created by APP on 14-8-18.
//  Copyright (c) 2014年 ll. All rights reserved.
//

#import "WindowController.h"
#import "WindowStateItem.h"
#import "WindowStateManager.h"
#import "WindowPositionManager.h"

@interface WindowController(WindowControllerPrivate)

- (NSWindow *)topWindow;
- (void)backupCurrentWindowState;
- (void)reLayoutWindowsbottomAlways;
- (void)spinCurrentWindowToDesktopUnderIcon:(BOOL)isUnderIcon responseToUserInteraction:(BOOL)interacted;
- (void)cantMoveCurrentWindow;
- (void)canMoveCurrentWindow;
- (void)reLayoutWindowsTopAlways;
- (void)floatCurrentWindowTop;

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
    [self backupCurrentWindowState];
    [self reLayoutWindowsbottomAlways];
    [self spinCurrentWindowToDesktopUnderIcon:NO responseToUserInteraction:YES];
    [self cantMoveCurrentWindow];
}

- (void)needAlltimeWindow
{
    self.currentWindow = [self topWindow];
    [self backupCurrentWindowState];
    [self reLayoutWindowsTopAlways];
    [self floatCurrentWindowTop];
    [self canMoveCurrentWindow];
}

- (void)notNeedAlltimeWindow
{
    
}

- (void)comeBackWindow
{
    self.currentWindow = [self topWindow];
    WindowStateItem *originalWindowStateItem = [[WindowStateManager getInstance] originalWindowStateItemOfCurrentWindow: self.currentWindow];
    if (originalWindowStateItem != nil)
    {
        [WindowPositionManager resumeWindowStateAccordingWindowStateItem:originalWindowStateItem];
        [[WindowStateManager getInstance] removeElement:originalWindowStateItem];
    }
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

- (void)backupCurrentWindowState
{
    [[WindowStateManager getInstance] addCurrentWindowToManager:self.currentWindow];
}

- (void)reLayoutWindowsbottomAlways
{
    [WindowPositionManager reLayoutBottomWindowsPositionWhenThisWindowBottom:self.currentWindow];
}

- (void)reLayoutWindowsTopAlways
{
    [WindowPositionManager reLayoutTopWindowsPositionWhenThisWindowTop:self.currentWindow];
}

- (void)spinCurrentWindowToDesktopUnderIcon:(BOOL)isUnderIcon responseToUserInteraction:(BOOL)interacted
{
    if (isUnderIcon == NO)
    {
        [self.currentWindow setLevel:kCGDesktopIconWindowLevel];
    }
}

- (void)floatCurrentWindowTop
{
    [self.currentWindow setLevel:kCGFloatingWindowLevel];
}

- (void)cantMoveCurrentWindow
{
    [self.currentWindow setMovable:NO];
}

- (void)canMoveCurrentWindow
{
    [self.currentWindow setMovable:YES];
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

