//
//  OriginalWindowStateItem.h
//  controlWindows
//
//  Created by APP on 14-8-19.
//  Copyright (c) 2014年 ll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OriginalWindowStateItem : NSObject

@property (nonatomic, readonly) NSWindow *window;
@property (nonatomic, readonly) NSRect originalFrame;
@property (nonatomic, readonly) NSInteger originalWindowLevel;
@property (nonatomic, readonly) BOOL isMovable;
@property (nonatomic, readonly) BOOL isResizable;
@property (nonatomic, readwrite) NSInteger position;

- (id)initWithNSWindow: (NSWindow *)aWindow;

@end
