//
//  WindowPositionManager.m
//  controlWindows
//
//  Created by APP on 14-8-19.
//  Copyright (c) 2014年 ll. All rights reserved.
//

#import "WindowPositionManager.h"
#import "OriginalWindowStateItem.h"
#import "OriginalWindowStateManager.h"

@interface WindowPositionManager(WindowPositionManagerPrivate)

+ (void)relayoutFullScreenPosition;
+ (void)relayoutLeftRightPosition;
+ (void)relayoutLeftRIghtTopRightBottomPosition;
+ (void)relayoutRightPosition;

@end

@implementation WindowPositionManager

+ (void)reLayoutWindowsPosition
{
    switch ([[OriginalWindowStateManager getInstance].originalWindowStateList count])
    {
        case FULL_SCREEN_POSITION:
        {
            [self relayoutFullScreenPosition];
            break;
        }
        case LEFT_RIGHT_POSITION:
        {
            [self relayoutLeftRightPosition];
            break;
        }
        case LEFT_RIGHT_TOP_RIGHT_BOTTOM_POSITION:
        {
            [self relayoutLeftRIghtTopRightBottomPosition];
            break;
        }
        default:
        {
            break;
        }
    }
}

+ (void)reLayoutWindowPositionToRight
{
    [self relayoutRightPosition];
}

@end

@implementation WindowPositionManager(WindowPositionManagerPrivate)

+ (void)relayoutFullScreenPosition
{
    OriginalWindowStateItem *fullScreenWindowStateItem = [OriginalWindowStateManager getInstance].originalWindowStateList.firstObject;
    NSWindow *fullScreenWindow = fullScreenWindowStateItem.window;
    [fullScreenWindow setFrame:[self fullScreenPosition] display:YES animate:YES];
}

+ (void)relayoutLeftRightPosition
{
    
}

+ (void)relayoutLeftRIghtTopRightBottomPosition
{
    
}

+ (void)relayoutRightPosition
{
    OriginalWindowStateItem *fullScreenWindowStateItem = [OriginalWindowStateManager getInstance].originalWindowStateList.firstObject;
    NSWindow *fullScreenWindow = fullScreenWindowStateItem.window;
    [fullScreenWindow setFrame:[self rightScreenPosition] display:YES animate:YES];
}

+ (NSRect)rightScreenPosition
{
    NSRect frame;
    CGFloat ScreenHalfWidth = [NSScreen mainScreen].frame.size.width/2;
    
    frame.origin.x      = ScreenHalfWidth;
    frame.origin.y      = 0.0f;
    frame.size.width    = ScreenHalfWidth;
    frame.size.height   = [NSScreen mainScreen].frame.size.height;
    return frame;
}

+ (NSRect)fullScreenPosition
{
    //TODO:screen
    NSRect frame;
    frame.origin.x      = 0.0f;
    frame.origin.y      = 0.0f;
    frame.size.width    = [NSScreen mainScreen].frame.size.width;
    frame.size.height   = [NSScreen mainScreen].frame.size.height;
    return frame;
}

@end