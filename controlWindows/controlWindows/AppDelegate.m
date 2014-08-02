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
    @private NSPoint lastMousePoint;
    @private AXUIElementRef frontMostWindowElement;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [self performTimerBasedUpdate];
}

- (void)performTimerBasedUpdate
{
    [self getCurrentUIElementPointedByMouse];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(performTimerBasedUpdate) userInfo:nil repeats:NO];
}

- (AXUIElementRef)getCurrentUIElementPointedByMouse
{
    AXUIElementRef newElement = nil;
    NSPoint cocoaPoint = [NSEvent mouseLocation];
    
    if (!NSEqualPoints(cocoaPoint, lastMousePoint))
    {
        CGPoint pointCGPoint = [self carbonScreenPointFromCocoaScreenPoint:cocoaPoint];
        
        if ((AXUIElementCopyElementAtPosition(AXUIElementCreateSystemWide(), pointCGPoint.x, pointCGPoint.y, &newElement) == kAXErrorSuccess) &&
            newElement)
        {
        }
        [self resizeFocusedApplication: newElement];
        lastMousePoint = cocoaPoint;
    }
    return nil;
}

- (CGPoint)carbonScreenPointFromCocoaScreenPoint:(NSPoint)cocoaPoint
{
    NSScreen *foundScreen = nil;
    CGPoint thePoint;
    
    for (NSScreen *screen in [NSScreen screens])
    {
        if (NSPointInRect(cocoaPoint, [screen frame]))
        {
            foundScreen = screen;
        }
    }
    
    if (foundScreen)
    {
        CGFloat screenHeight = [foundScreen frame].size.height;
        thePoint = CGPointMake(cocoaPoint.x, screenHeight - cocoaPoint.y - 1);
    }
    else
    {
        thePoint = CGPointMake(0.0, 0.0);
    }
    
    return thePoint;
}

- (void)resizeFocusedApplication: (AXUIElementRef)mouseUIElementRef
{
    AXUIElementRef systemWideElement = AXUIElementCreateSystemWide();
    AXUIElementRef childElement;
    
    AXError result;
    
    result = AXUIElementCopyAttributeValue(systemWideElement, kAXFocusedApplicationAttribute, (CFTypeRef *)&childElement);
    
    if (result == kAXErrorSuccess)
    {
        result = AXUIElementCopyAttributeValue(childElement, kAXFocusedWindowAttribute, (CFTypeRef *)&frontMostWindowElement);
        if (result == kAXErrorSuccess)
        {
            CFTypeRef windowPositionValue = [self valueOfAttribute: kAXPositionAttribute type: kAXValueCGPointType];
            CFTypeRef windowSizeValue = [self valueOfAttribute: kAXSizeAttribute type: kAXValueCGSizeType];
            CGPoint windowPosition;
            CGSize windowSize;
            
            AXValueGetValue(windowPositionValue, kAXValueCGPointType, (void *)&windowPosition);
            AXValueGetValue(windowSizeValue, kAXValueCGSizeType, (void *)&windowSize);
            
            windowPosition.x -= 10.0f;
            windowPosition.y -= 10.0f;
            
            AXValueRef windowRectPositionRef = AXValueCreate(kAXValueCGPointType, (const void *)&windowPositionValue);
            AXValueRef windowRectSizeRef = AXValueCreate(kAXValueCGSizeType, (const void *)&windowSizeValue);
            
            result = AXUIElementSetAttributeValue(frontMostWindowElement, kAXSizeAttribute, (CFTypeRef *)windowRectSizeRef);
            result = AXUIElementSetAttributeValue(frontMostWindowElement, kAXPositionAttribute, (CFTypeRef *)windowRectPositionRef);
            result = AXUIElementSetAttributeValue(frontMostWindowElement, kAXSizeAttribute, (CFTypeRef *)windowRectSizeRef);
        }
        else
        {
        }
    }
    else
    {
    }
}

- (AXValueRef)valueOfAttribute: (CFStringRef)attribute type: (AXValueType)type
{
    if (CFGetTypeID(frontMostWindowElement) == AXUIElementGetTypeID())
    {
        CFTypeRef value;
        AXError result;
        
        result = AXUIElementCopyAttributeValue(frontMostWindowElement, attribute, (CFTypeRef *)&value);
        
        if ((result == kAXErrorSuccess) && (AXValueGetType(value) == type))
        {
            return value;
        }
        else
        {
            NSLog(@"There was a problem getting the value of the specified attribute: %@", attribute);
        }
    }
    
    return NULL;
}

@end
