//
//  OriginalWindowStateManager.h
//  controlWindows
//
//  Created by APP on 14-8-19.
//  Copyright (c) 2014年 ll. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OriginalWindowStateItem;

@interface OriginalWindowStateManager : NSObject

@property (nonatomic, readwrite) NSMutableArray *originalWindowStateList;

+ (OriginalWindowStateManager *)getInstance;
- (void)addElement: (OriginalWindowStateItem *)anItem;
- (void)removeElementAtPositon: (NSInteger)aPosition;
- (OriginalWindowStateItem *)lastItem;

@end
