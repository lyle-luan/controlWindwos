//
//  WindowController.h
//  controlWindows
//
//  Created by APP on 14-8-18.
//  Copyright (c) 2014年 ll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WindowController : NSObject <NSWindowDelegate>

@property NSWindow *currentWindow;

+ (WindowController *)getInstance;

- (void)dontBotherMeWindow;
- (void)comeBackWindow;
- (void)needAlltimeWindow;

@end
