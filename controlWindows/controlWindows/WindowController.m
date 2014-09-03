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
- (void)spinCurrentWindowToDesktopUnderIcon:(BOOL)isUnderIcon responseToUserInteraction:(BOOL)interacted;
- (void)cantMoveCurrentWindow;
- (void)canMoveCurrentWindow;
- (void)reLayoutWindowTopAlways;
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
    [self backupOriginalState];
    [self reLayoutWindows];
    [self spinCurrentWindowToDesktopUnderIcon:NO responseToUserInteraction:YES];
    [self cantMoveCurrentWindow];
}

- (void)comeBackWindow
{
    self.currentWindow = [self topWindow];
    OriginalWindowStateItem *originalWindowStateItem = [[OriginalWindowStateManager getInstance] originalWindowStateItemOfCurrentWindow: self.currentWindow];
    if (originalWindowStateItem != nil)
    {
        [self.currentWindow setFrame:originalWindowStateItem.originalFrame display:YES animate:YES];
        [self.currentWindow setLevel:originalWindowStateItem.originalWindowLevel];
        [self.currentWindow setMovable:originalWindowStateItem.isMovable];
        [[OriginalWindowStateManager getInstance] removeElement:originalWindowStateItem];
    }
}

- (void)needAlltimeWindow
{
    self.currentWindow = [self topWindow];
    [self backupOriginalState];
    [self reLayoutWindowTopAlways];
    [self floatCurrentWindowTop];
    [self canMoveCurrentWindow];
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

- (void)reLayoutWindowTopAlways
{
    [WindowPositionManager reLayoutWindowPositionToRight];
}

- (void)spinCurrentWindowToDesktopUnderIcon:(BOOL)isUnderIcon responseToUserInteraction:(BOOL)interacted
{
    if (isUnderIcon == NO)
    {
        [self.currentWindow setLevel:kCGDesktopIconWindowLevel+1];
    }
}

- (void)floatCurrentWindowTop
{
    [self.currentWindow setLevel:NSFloatingWindowLevel];
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

