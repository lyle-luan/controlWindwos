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