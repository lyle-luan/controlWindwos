//
//  WindowStateItem.m
//  controlWindows
//
//  Created by APP on 14-8-19.
//  Copyright (c) 2014年 ll. All rights reserved.
//

#import "WindowStateItem.h"

@implementation WindowStateItem

@synthesize window;
@synthesize windowFrame;
@synthesize windowLevel;
@synthesize isMovable;
@synthesize isResizable;

- (id)initWithNSWindow: (NSWindow *)aWindow
{
    self = [super init];
    if (self)
    {
        window = aWindow;
        windowFrame = aWindow.frame;
        windowLevel = aWindow.level;
        isMovable = aWindow.isMovable;
        isResizable = aWindow.isResizable;
    }
    
    return self;
}

@end

