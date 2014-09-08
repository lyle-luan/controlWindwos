//
//  WindowStateItem.h
//  controlWindows
//
//  Created by APP on 14-8-19.
//  Copyright (c) 2014年 ll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WindowStateItem : NSObject

@property (nonatomic, readonly) NSWindow *window;
@property (nonatomic, readonly) NSRect windowFrame;
@property (nonatomic, readonly) NSInteger windowLevel;
@property (nonatomic, readonly) BOOL isMovable;
@property (nonatomic, readonly) BOOL isResizable;
@property (nonatomic, readwrite) NSInteger position;

- (id)initWithNSWindow: (NSWindow *)aWindow;

@end
