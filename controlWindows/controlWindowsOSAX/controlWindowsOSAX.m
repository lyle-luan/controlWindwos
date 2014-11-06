//
//  controlWindowsOSAX.m
//  controlWindowsOSAX
//
//  Created by APP on 14/11/4.
//  Copyright (c) 2014年 ll. All rights reserved.
//

#import <Cocoa/Cocoa.h>

__attribute__((constructor))
static void cwInitializer()
{

}

OSErr loadPlugin(const AppleEvent *ev, AppleEvent *reply, long refcon)
{
    NSLog(@"loadPlugin");
    
    NSMenu* menu = [NSApp windowsMenu];
    if (!menu)
    {
        NSLog(@"found no Window menu in NSApp");
        return noErr;
    }
    
    NSLog(@"menu item: %ld", (long)[menu numberOfItems]);

    [menu insertItem:[NSMenuItem separatorItem] atIndex:[menu numberOfItems]];
    
    NSUInteger i = 0, lastSeparator = -1;
    for (NSMenuItem* item in [menu itemArray])
    {
        if ([item isSeparatorItem])
        {
            lastSeparator = i;
        }
        else if ([item action] == @selector(arrangeInFront:))
        {
            i += 1;
            break;
        }
        i++;
    }
    
    NSLog(@"i:%lu", (unsigned long)i);
    
    NSMenuItem *addItem = [[NSMenuItem alloc] initWithTitle:@"123" action:NULL keyEquivalent:@""];
    [menu insertItem:addItem atIndex:i];
    return noErr;
}
