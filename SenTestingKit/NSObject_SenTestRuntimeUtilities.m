/*$Id: NSObject_SenTestRuntimeUtilities.m,v 1.1 2004/01/05 13:40:45 phink Exp $*/

// Copyright (c) 1997-2003, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import "NSObject_SenTestRuntimeUtilities.h"
#import "SenTestInvocationEnumerator.h"
#import "SenTestClassEnumerator.h"
#import <Foundation/Foundation.h>
#import <objc/objc-class.h>


#if defined (GNUSTEP)
@interface Object (PrivateRuntimeUtilities)
+ (BOOL)respondsToSelector:(SEL)sel;
@end


@implementation Object (PrivateRuntimeUtilities)
+ (BOOL)respondsToSelector:(SEL)sel
{
  return (IMP)class_get_instance_method(self, sel) != (IMP)0;
}
@end
#endif


@implementation NSObject (SenTestRuntimeUtilities)
+ (NSArray *) senAllSuperclasses
{
    static NSMutableDictionary *superclassesClassVar = nil;
    NSString *key = NSStringFromClass (self);

    if (superclassesClassVar == nil) {
        superclassesClassVar = [[NSMutableDictionary alloc] init];
    }
    if ([superclassesClassVar objectForKey:key] == nil) {
        NSMutableArray *superclasses = [NSMutableArray array];
        Class currentClass = self;
        while (currentClass != nil) {
            [superclasses addObject:currentClass];
            currentClass = [currentClass superclass];
        }
        [superclassesClassVar setObject:superclasses forKey:key];
    }
    return [superclassesClassVar objectForKey:key];
}


- (NSArray *) senAllSuperclasses
{
    return [[self class] senAllSuperclasses];
}


+ (BOOL) senIsASuperclassOfClass:(Class) aClass
{
    // Some classes don't inherit from NSObject, nor do they implement <NSObject> protocol, thus probably don't respond to @selector(respondsToSelector:)
    // We check if the class responds to @selector(respondsToSelector:) using Objective-C low-level function calls.
    return  (aClass != self) &&
        (class_getClassMethod(aClass, @selector(respondsToSelector:)) != NULL) &&
        [aClass respondsToSelector:@selector(senAllSuperclasses)] &&
        [[aClass senAllSuperclasses] containsObject:self];
}


+ (NSArray *) senAllSubclasses
{
    NSMutableArray *subclasses = [NSMutableArray array];
    NSEnumerator *classEnumerator = [SenTestClassEnumerator classEnumerator];
    id eachClass = nil;

    while ( (eachClass = [classEnumerator nextObject]) ) {
        NS_DURING
            if ([self senIsASuperclassOfClass:eachClass]) {
                [subclasses addObject:eachClass];
            }
            ;
        NS_HANDLER
            NSLog (([NSString stringWithFormat:@"Skipping %@ (%@)", NSStringFromClass(eachClass), localException]));
        NS_ENDHANDLER
    }
    return [subclasses count] == 0 ? nil : subclasses;
}


- (NSArray *) senAllSubclasses
{
    return [[self class] senAllSubclasses];
}


+ (NSArray *) senInstanceInvocations
{
    return [[SenTestInvocationEnumerator instanceInvocationEnumeratorForClass:self] allObjects];
}


+ (NSArray *) senAllInstanceInvocations
{    
    if ([self superclass] == nil) {
        return [self senInstanceInvocations];
    }
    else {
        NSMutableSet *result = [NSMutableSet setWithArray:[[self superclass] senAllInstanceInvocations]];
        [result addObjectsFromArray: [self senInstanceInvocations]];
        return [result allObjects];
    }
}


- (NSArray *) senInstanceInvocations
{
    return [[self class] senInstanceInvocations];
}


- (NSArray *) senAllInstanceInvocations
{
    return [[self class] senAllInstanceInvocations];
}
@end
