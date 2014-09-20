//
//  AppDelegate.h
//  controlWindows
//
//  Created by ll on 14-8-2.
//  Copyright (c) 2014年 ll. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic, readwrite) NSStatusItem *statusItem;
@property (weak) IBOutlet NSWindow *welcomeWindow;

@property (weak) IBOutlet NSMenu *statusItemMenu;

@end
