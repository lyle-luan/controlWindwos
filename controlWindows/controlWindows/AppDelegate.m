//
//  AppDelegate.m
//  controlWindows
//
//  Created by ll on 14-8-2.
//  Copyright (c) 2014年 ll. All rights reserved.
//

#import "AppDelegate.h"
#import "HotKeyController.h"
#import <ScriptingBridge/ScriptingBridge.h>
//#import <Carbon/Carbon.h>

@implementation AppDelegate

@synthesize statusItem;
@synthesize welcomeWindow;
@synthesize statusItemMenu;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength: NSVariableStatusItemLength];
    NSImage *statusImage = [NSImage imageNamed:@"StatusItem"];
    [statusImage setTemplate:YES];
    statusItem.image = statusImage;
    statusItem.highlightMode = YES;
    [statusItem setMenu:statusItemMenu];
    
    [HotKeyController engineHotKeyListen];
    
    [[[NSWorkspace sharedWorkspace] notificationCenter]
     addObserver:self selector:@selector(someAppEngine:)
     name:NSWorkspaceDidLaunchApplicationNotification object:nil];
    
//    if (YES)
//    {
//        [[NSApplication sharedApplication] runModalForWindow:self.welcomeWindow];
//    }
}

- (IBAction)okButtonPushed:(id)sender
{
    [self.welcomeWindow orderOut:self];
}

- (IBAction)aboutMenuItemPushed:(id)sender
{
    NSLog(@"about");
}

- (IBAction)updateMenuItem:(id)sender
{
    NSLog(@"update");
}

- (void) someAppEngine:(NSNotification*)notification
{
    NSDictionary* appInfo = [notification userInfo];
    NSString* appName = [appInfo objectForKey:@"NSApplicationName"];
    NSLog(@"appName: %@", appName);
    
    pid_t pid = [[appInfo objectForKey:@"NSApplicationProcessIdentifier"] intValue];
    SBApplication *app = [SBApplication applicationWithProcessIdentifier:pid];
    app.delegate = self;
    if (!app)
    {
        NSLog(@"Can't find app with pid %d", pid);
        return;
    }
    
    [app setSendMode:kAENoReply | kAENeverInteract | kAEDontRecord];
    id injectReply = [app sendEvent:'cnwd' id:'load' parameters:0];
    if (injectReply != nil)
    {
        NSLog(@"cnwd unexpected injectReply: %@", injectReply);
    }
}

- (void) eventDidFail:(const AppleEvent*)event withError:(NSError*)error
{
    NSDictionary* userInfo = [error userInfo];
    NSNumber* errorNumber = [userInfo objectForKey:@"ErrorNumber"];
    
    // this error seems more common on Leopard
    if (errorNumber && [errorNumber intValue] == errAEEventNotHandled)
    {
        //tvea
        NSLog(@"err event: %4.4s!", (char *)&(event->descriptorType));
        NSLog(@"err error: %@!", error);
        NSLog(@"err userInfo: %@!", [error userInfo]);
    }
    else
    {
        NSLog(@"eventDidFail:'%4.4s' error:%@ userInfo:%@", (char*)&(event->descriptorType), error, [error userInfo]);
    }
}

@end
