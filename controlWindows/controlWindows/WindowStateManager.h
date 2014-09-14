//
//  WindowStateManager.h
//  controlWindows
//
//  Created by APP on 14-8-19.
//  Copyright (c) 2014年 ll. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WINDOW_STATE_BOTTOM     (kCGDesktopIconWindowLevel)
#define WINDOW_STATE_TOP        (kCGFloatingWindowLevel)

@class WindowStateItem;

@interface WindowStateManager : NSObject

@property (nonatomic, readwrite) NSMutableArray *windowStateList;
@property (nonatomic, readonly) NSInteger numOfBottomWindows;
@property (nonatomic, readonly) NSInteger numOfTopWindows;

+ (WindowStateManager *)getInstance;
- (void)addCurrentWindowToManager: (NSWindow *)aWindow;
- (void)removeElement: (WindowStateItem *)anElement;
- (WindowStateItem *)originalWindowStateItemOfCurrentWindow: (NSWindow *)aWindow;

@end
