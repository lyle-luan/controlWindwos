//
//  HotKeyController.m
//  controlWindows
//
//  Created by APP on 14-8-18.
//  Copyright (c) 2014年 ll. All rights reserved.
//

#import <Carbon/Carbon.h>
#import "HotKeyController.h"
#import "WindowController.h"

OSStatus hotKeyEventHandler(EventHandlerCallRef handlerCall, EventRef event, void *data);

OSStatus hotKeyEventHandler(EventHandlerCallRef handlerCall, EventRef event, void *data)
{
    EventHotKeyID hotKeyID;
    
    OSStatus error = GetEventParameter(event, kEventParamDirectObject, typeEventHotKeyID, NULL, sizeof(EventHotKeyID), NULL, &hotKeyID);
    
    if (error)
    {
        return error;
    }
    
    switch (hotKeyID.id)
    {
        case 1:
        {
            [[WindowController getInstance] dontBotherMeWindow];
            break;
        }
        case 2:
        {
            [[WindowController getInstance] comeBackWindow];
            break;
        }
        case 3:
        {
            [[WindowController getInstance] needAlltimeWindow];
        }
        default:
        {
            break;
        }
    }
    return noErr;
}

@implementation HotKeyController

+ (void)engineHotKeyListen
{
    [self registerHotKey];
    [self installHotKeyEventHandler];
}

+ (void)installHotKeyEventHandler
{
    EventTypeSpec typeSpec;
    
    typeSpec.eventClass = kEventClassKeyboard;
    typeSpec.eventKind = kEventHotKeyPressed;
    
    InstallApplicationEventHandler(&hotKeyEventHandler, 1, &typeSpec, NULL, NULL);
}

+ (void)registerHotKey
{
    EventHotKeyID hotKeyID;
    EventHotKeyRef hotKeyRef;
    
    OSStatus error;
    
    hotKeyID.signature = 'zzzz';
    hotKeyID.id = 1;
    
    error = RegisterEventHotKey((UInt32)6, (UInt32)controlKey, hotKeyID, GetEventDispatcherTarget(), 0, &hotKeyRef);
    
    if (error)
    {
        NSLog(@"There was a problem registering hot key %d.", 6);
    }
    
    
    hotKeyID.signature = 'xxxx';
    hotKeyID.id = 2;
    
    error = RegisterEventHotKey((UInt32)7, (UInt32)controlKey, hotKeyID, GetEventDispatcherTarget(), 0, &hotKeyRef);
    
    if (error)
    {
        NSLog(@"There was a problem registering hot key %d.", 7);
    }
    
    hotKeyID.signature = 'cccc';
    hotKeyID.id = 3;
    
    error = RegisterEventHotKey((UInt32)8, (UInt32)controlKey, hotKeyID, GetEventDispatcherTarget(), 0, &hotKeyRef);
    
    if (error)
    {
        NSLog(@"There was a problem registering hot key %d.", 8);
    }
}

@end
