//
//  OriginalWindowStateItem.m
//  controlWindows
//
//  Created by APP on 14-8-19.
//  Copyright (c) 2014年 ll. All rights reserved.
//

#import "OriginalWindowStateItem.h"

@implementation OriginalWindowStateItem

@synthesize window;
@synthesize originalFrame;
@synthesize originalWindowLevel;
@synthesize isMovable;
@synthesize isResizable;

- (id)initWithNSWindow: (NSWindow *)aWindow
{
    self = [super init];
    if (self)
    {
        window = aWindow;
        originalFrame = aWindow.frame;
        originalWindowLevel = aWindow.level;
        isMovable = aWindow.isMovable;
        isResizable = aWindow.isResizable;
    }
    return self;
}

@end
