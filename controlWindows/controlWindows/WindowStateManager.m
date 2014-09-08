//
//  WindowStateManager.m
//  controlWindows
//
//  Created by APP on 14-8-19.
//  Copyright (c) 2014年 ll. All rights reserved.
//

//TODO: read disk file

#import "WindowStateManager.h"
#import "WindowStateItem.h"

@interface WindowStateManager(WindowStateItemPrivate)

- (NSMutableArray *)searchOriginalWindowStatesListOfWindow: (NSWindow *)aWindow;
- (NSInteger)numOfWindows: (BOOL)topYesOrBottomNo;

@end

@implementation WindowStateManager

@synthesize windowStateList;
@synthesize numOfBottomWindows;
@synthesize numOfTopWindows;

+ (WindowStateManager *)getInstance
{
    static WindowStateManager *windowStateManager = nil;
    if (windowStateManager == nil)
    {
        windowStateManager = [[super allocWithZone:nil] init];
        windowStateManager.windowStateList = [[NSMutableArray alloc] init];
    }
    return windowStateManager;
}

- (NSInteger)numOfTopWindows
{
    return [self numOfWindows:YES];
}

- (NSInteger)numOfBottomWindows
{
    return [self numOfWindows:NO];
}

- (void)addCurrentWindowToManager: (NSWindow *)aWindow
{
    WindowStateItem *newItem = [[WindowStateItem alloc] initWithNSWindow:aWindow];
    [[self searchOriginalWindowStatesListOfWindow:aWindow] addObject:newItem];
}

- (void)removeElementAtPositon: (NSInteger)aPosition
{
    
}

- (void)removeElement: (WindowStateItem *)anElement
{
    if (anElement != nil)
    {
        NSMutableArray *currentWindowStateList = [self searchOriginalWindowStatesListOfWindow:anElement.window];
        [currentWindowStateList removeObject:anElement];
        if (currentWindowStateList.count == 0)
        {
            [self.windowStateList removeObject:currentWindowStateList];
        }
    }
}

- (WindowStateItem *)originalWindowStateItemOfCurrentWindow: (NSWindow *)aWindow
{
    NSMutableArray *currentWindowStateList = [self searchOriginalWindowStatesListOfWindow:aWindow];
    
    WindowStateItem *originalWindowStateItem = currentWindowStateList.lastObject;
    
    return originalWindowStateItem;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self getInstance];
}

@end

@implementation WindowStateManager(WindowStateItemPrivate)

- (NSMutableArray *)searchOriginalWindowStatesListOfWindow: (NSWindow *)aWindow
{
    for (NSMutableArray *indexArray in windowStateList)
    {
        if (indexArray.count == 0)
        {
            [windowStateList removeObject:indexArray];
            continue;
        }
        if (aWindow == ((WindowStateItem *)(indexArray.firstObject)).window)
        {
            return indexArray;
        }
    }
    
    NSMutableArray *newWindow = [[NSMutableArray alloc] init];
    [windowStateList addObject:newWindow];
    
    return newWindow;
}

- (NSInteger)numOfWindows: (BOOL)topYesOrBottomNo
{
    numOfBottomWindows = 0;
    numOfTopWindows = 0;
    
    WindowStateItem *currentWindowStateItem = nil;
    
    for (NSMutableArray *indexArray in windowStateList)
    {
        if (indexArray.count == 0)
        {
            [windowStateList removeObject:indexArray];
            continue;
        }
        currentWindowStateItem = (WindowStateItem *)(indexArray.lastObject);
        if (currentWindowStateItem.window.level == kCGDesktopIconWindowLevel)
        {
            numOfBottomWindows++;
        }
        else if (currentWindowStateItem.window.level == kCGFloatingWindowLevel)
        {
            numOfTopWindows++;
        }
    }
    if (topYesOrBottomNo == YES)
    {
        return numOfTopWindows;
    }
    else
    {
        return numOfBottomWindows;
    }
}

@end
