//
//  AppDelegate.m
//  controlWindows
//
//  Created by ll on 14-8-2.
//  Copyright (c) 2014年 ll. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
{
    @private AXUIElementRef frontMostWindowElement;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
//    NSLog(@"window title: %@", [self currentWindow].title);
//    [self keepPinnedToDesktop:YES forWindow:[self currentWindow] andResponseToUserInteraction:YES withAnimation:YES];
    [self performTimerBasedUpdate];
}

- (NSWindow*) currentWindow
{
    NSWindow* currentWindowMaybe = nil;

    currentWindowMaybe = [self topWindowFor:[NSApp keyWindow]];
    if (currentWindowMaybe != nil)
    {
        NSLog(@"key window");
        if (![self isWindowShouldIgnored:currentWindowMaybe])
        {
            return currentWindowMaybe;
        }
    }
    
	
    currentWindowMaybe = [self topWindowFor:[NSApp mainWindow]];
    if (currentWindowMaybe != nil)
    {
        NSLog(@"main window");
        if (![self isWindowShouldIgnored:currentWindowMaybe])
        {
            return currentWindowMaybe;
        }
    }
    
    NSLog(@"%lu", (unsigned long)[[NSApp orderedWindows] count]);
    for (NSWindow *windowIndex in [NSApp orderedWindows])
    {
        NSLog(@"order window");
        currentWindowMaybe = [self topWindowFor:windowIndex];
        if (![self isWindowShouldIgnored:currentWindowMaybe])
        {
            return currentWindowMaybe;
        }
    }

    return nil;
}

- (NSWindow *)topWindowFor:(NSWindow *)thisWindow;
{
    while ([thisWindow parentWindow])
    {
        thisWindow = [thisWindow parentWindow];
    }

    return thisWindow;
}

- (BOOL)isWindowShouldIgnored:(NSWindow *)aWindow
{
    if ([aWindow isKindOfClass:[NSPanel class]])
    {
        NSLog(@"nspanel");
        return YES;
    }
    if (![aWindow isVisible])
    {
        NSLog(@"not isvisible");
        return YES;
    }
    return NO;
}

- (void)keepPinnedToDesktop:(BOOL)keepPinned forWindow:(NSWindow *)aWindow andResponseToUserInteraction:(BOOL)interacted withAnimation:(BOOL)animated
{
    //TODO: interact to user
    //TODO: with animation
    [aWindow setLevel:keepPinned ? kCGDesktopWindowLevel:NSNormalWindowLevel];
    [aWindow acceptsMouseMovedEvents];
}

- (void)updateCurrentUIElement
{
    NSWindow *window = [self currentWindow];
    
    NSLog(@"window title: %@", window.title);
    NSLog(@"window level: %ld", (long)window.level);
    [self resizeFocusedApplication:nil];
    //[self keepPinnedToDesktop:YES forWindow:[self currentWindow] andResponseToUserInteraction:YES withAnimation:YES];
}

- (void)performTimerBasedUpdate
{
    [self updateCurrentUIElement];
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(performTimerBasedUpdate) userInfo:nil repeats:NO];
}

- (void)resizeFocusedApplication: (AXUIElementRef)mouseUIElementRef
{
    AXUIElementRef systemWideElement = AXUIElementCreateSystemWide();
    AXUIElementRef childElement;
    
    AXError result;
    
    result = AXUIElementCopyAttributeValue(systemWideElement, kAXFocusedApplicationAttribute, (CFTypeRef *)&childElement);
    
    if (result == kAXErrorSuccess)
    {
        childElement = [self getParentAXUIElementRef:childElement];
        NSLog(@"%@",[self stringDescriptionOfUIElement:childElement]);
    }
    else
    {
    }
}

- (id)valueOfAttribute: (NSString *)attribute type: (AXUIElementRef)element
{
    id result = nil;
    CFArrayRef attrNames = nil;
    
    //TODO:spectacle AXUIElementCopyAttributeNames how to do it
    AXUIElementCopyAttributeNames(element, &attrNames);
    
    NSArray *attributeNames = (__bridge NSArray *)attrNames;
    
    if (attributeNames)
    {
        if (([attributeNames indexOfObject:(NSString *)attribute] != NSNotFound) &&
            (AXUIElementCopyAttributeValue(element, (__bridge CFStringRef)attribute, (CFTypeRef *)((void *)&result)) == kAXErrorSuccess))
        {
            
        }
    }
    
    return result;
}

- (AXUIElementRef)getParentAXUIElementRef:(AXUIElementRef)element
{
    AXUIElementRef topElement;
    do
    {
        topElement = element;
        element = (__bridge AXUIElementRef)[self valueOfAttribute:NSAccessibilityParentAttribute type:element];
    }
    while (element != nil);
    
    return topElement;
}

- (NSString *)stringDescriptionOfUIElement:(AXUIElementRef)element
{
    CFArrayRef theName;
    NSMutableString *descriptionString = [[NSMutableString alloc] init];
    
    AXUIElementCopyAttributeNames(element, &theName);
    NSArray *theNames = (__bridge NSArray *)theName;
    
    CFIndex numOfNames;
    CFIndex nameIndex;
    
    if (theNames)
    {
        numOfNames = [theNames count];
        if (numOfNames)
        {
            [descriptionString appendString:@"\nAttributes:\n"];
        }
        
        for (nameIndex=0; nameIndex<numOfNames; ++nameIndex)
        {
            NSString *theName = nil;
            BOOL isSettable = NO;
            
            theName = [theNames objectAtIndex:nameIndex];
            
            AXUIElementIsAttributeSettable(element, (__bridge CFStringRef)theName, &isSettable);
            
            [descriptionString appendFormat:@"    %@%@:    '%@'\n", theName, (isSettable?@" (W)":@""), @""];
        }
    }
    return descriptionString;
}

@end
