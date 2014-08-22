//
//  WindowPositionManager.h
//  controlWindows
//
//  Created by APP on 14-8-19.
//  Copyright (c) 2014年 ll. All rights reserved.
//

#import <Foundation/Foundation.h>

enum WINDOW_POSITION_ENUM
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
    FULL_SCREEN_POSITION = 1,
//    -------------------------------
//    |              |              |
//    |              |              |
//    |              |              |
//    |     left     |     right    |
//    |              |              |
//    |              |              |
//    |              |              |
//    -------------------------------
    LEFT_RIGHT_POSITION,
//    -------------------------------
//    |              |              |
//    |              |  right  top  |
//    |              |              |
//    |     left     |--------------|
//    |              |              |
//    |              | right bottom |
//    |              |              |
//    -------------------------------
    
    LEFT_RIGHT_TOP_RIGHT_BOTTOM_POSITION,
};

@interface WindowPositionManager : NSObject

+ (void)reLayoutWindowsPosition;

@end
