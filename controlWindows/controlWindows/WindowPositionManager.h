//
//  WindowPositionManager.h
//  controlWindows
//
//  Created by APP on 14-8-19.
//  Copyright (c) 2014年 ll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WindowStateItem.h"

enum WINDOW_BOTTOM_POSITION_ENUM
{
//    -------------------------------
//    |                             |
//    |                             |
//    |                             |
//    |   one window full screen    |
//    |                             |
//    |                             |
//    |                             |
//    -------------------------------
    BOTTOM_FULL_SCREEN_POSITION = 1,
//    -------------------------------
//    |              |              |
//    |              |              |
//    |              |              |
//    |     left     |     right    |
//    |              |              |
//    |              |              |
//    |              |              |
//    -------------------------------
    BOTTOM_LEFT_RIGHT_POSITION,
//    -------------------------------
//    |              |              |
//    |              |  right  top  |
//    |              |              |
//    |     left     |--------------|
//    |              |              |
//    |              | right bottom |
//    |              |              |
//    -------------------------------
    
    BOTTOM_LEFT_RIGHT_TOP_RIGHT_BOTTOM_POSITION,
};

enum WINDOW_TOP_POSITION_ENUM
{
    //    -------------------------------
    //    |              |              |
    //    |              |              |
    //    |              |              |
    //    |              |     right    |
    //    |              |              |
    //    |              |              |
    //    |              |              |
    //    -------------------------------
    TOP_RIGHT_SCREEN_POSITION = 1,
    //    -------------------------------
    //    |              |              |
    //    |              |  right  top  |
    //    |              |              |
    //    |              |--------------|
    //    |              |              |
    //    |              | right bottom |
    //    |              |              |
    //    -------------------------------
    TOP_RIGHT_TOP_RIGHT_BOTTOM_POSITION,
};

@interface WindowPositionManager : NSObject

+ (void)reLayoutBottomWindowsPosition;
+ (void)reLayoutTopWindowsPosition;
+ (void)resumeWindowStateAccordingWindowStateItem: (WindowStateItem *)aWindowStateItem;

@end
