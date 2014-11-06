//
//  StatusItemOnPanelController.m
//  controlWindows
//
//  Created by APP on 14/11/6.
//  Copyright (c) 2014年 ll. All rights reserved.
//

#import "StatusItemOnPanelController.h"

@interface StatusItemOnPanelController()

@property (nonatomic, readwrite) NSStatusItem *statusItem;

@end

@implementation StatusItemOnPanelController

- (void)installStatusItemOnPanel
{
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength: NSVariableStatusItemLength];
    NSImage *statusImage = [NSImage imageNamed:@"StatusPic"];
    [statusImage setTemplate:YES];
    _statusItem.image = statusImage;
    _statusItem.highlightMode = YES;
    [_statusItem setMenu:_statusItemMenu];
}

@end
