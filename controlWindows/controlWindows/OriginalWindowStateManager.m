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

@interface OriginalWindowStateManager(OriginalWindowStateItemPrivate)

- (NSMutableArray *)searchOriginalWindowStatesListOfWindow: (NSWindow *)aWindow;

@end

@implementation OriginalWindowStateManager

@synthesize originalWindowStateList;

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

- (void)addElement: (OriginalWindowStateItem *)anElement
{
    [[self searchOriginalWindowStatesListOfWindow:anElement.window] addObject:anElement];
}

- (void)removeElementAtPositon: (NSInteger)aPosition
{
    
}

- (void)removeElement: (OriginalWindowStateItem *)anElement
{
    NSMutableArray *currentWindowStateList = [self searchOriginalWindowStatesListOfWindow:anElement.window];
    [currentWindowStateList removeObject:anElement];
    if (currentWindowStateList.count == 0)
    {
        [self.originalWindowStateList removeObject:currentWindowStateList];
    }
}

-(OriginalWindowStateItem *)originalWindowStateItemOfCurrentWindow: (NSWindow *)aWindow
{
    return [self searchOriginalWindowStatesListOfWindow:aWindow].lastObject;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self getInstance];
}

@end

@implementation OriginalWindowStateManager(OriginalWindowStateItemPrivate)

- (NSMutableArray *)searchOriginalWindowStatesListOfWindow: (NSWindow *)aWindow
{
    for (NSMutableArray *indexArray in originalWindowStateList)
    {
        if (indexArray.count == 0)
        {
            [indexArray removeObject:indexArray];
        }
        if (aWindow == ((OriginalWindowStateItem *)(indexArray.firstObject)).window)
        {
            return indexArray;
        }
    }
    
    NSMutableArray *newWindow = [[NSMutableArray alloc] init];
    [originalWindowStateList addObject:newWindow];
    
    return newWindow;
}

@end
