//
//  OriginalWindowStateManager.m
//  controlWindows
//
//  Created by APP on 14-8-19.
//  Copyright (c) 2014年 ll. All rights reserved.
//

//TODO: read disk file

#import "OriginalWindowStateManager.h"
#import "OriginalWindowStateItem.h"

@implementation OriginalWindowStateManager

+ (OriginalWindowStateManager *)getInstance
{
    static OriginalWindowStateManager *originalWindowStateManager = nil;
    if (originalWindowStateManager == nil)
    {
        originalWindowStateManager = [[super allocWithZone:nil] init];
        originalWindowStateManager.originalWindowStateList = [[NSMutableArray alloc] init];
    }
    return originalWindowStateManager;
}

- (void)addElement: (OriginalWindowStateItem *)anItem
{
    [self.originalWindowStateList addObject:anItem];
}

- (void)removeElementAtPositon: (NSInteger)aPosition
{
    
}

- (void)removeElement: (OriginalWindowStateItem *)anElement
{
    [self.originalWindowStateList removeObject:anElement];
}

-(OriginalWindowStateItem *)riginalWindowStateItemOfCurrentWindow: (NSWindow *)aWindow
{
    for (OriginalWindowStateItem *indexItem in self.originalWindowStateList)
    {
        if (CGRectEqualToRect(indexItem.window.frame, aWindow.frame) == YES)
        {
            return indexItem;
        }
    }
    return nil;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self getInstance];
}

@end
