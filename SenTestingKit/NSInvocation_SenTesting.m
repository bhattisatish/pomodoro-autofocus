/*$Id: NSInvocation_SenTesting.m,v 1.8 2004/01/05 13:40:44 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import "NSInvocation_SenTesting.h"
#import "SenTestingUtilities.h"
#ifndef GNU_RUNTIME /* NeXT RUNTIME */
#import <objc/objc-class.h>
#else
#include <objc/objc-api.h>
#endif

@implementation NSInvocation (SenTesting)

NSString *DefaultTestMethodPrefix = @"test";
static NSString *testMethodPrefix = nil;


+ (NSString *) testMethodPrefix
{
    return (testMethodPrefix != nil) ? testMethodPrefix : DefaultTestMethodPrefix;
}


+ (void) setTestMethodPrefix:(NSString *) aPrefix
{
    ASSIGN(testMethodPrefix,aPrefix);
}


- (NSString *) testMethodPrefix
{
    return [[self class] testMethodPrefix];
}


- (BOOL) isReturningVoid
{
    return *[[self methodSignature] methodReturnType] == _C_VOID;
}


- (BOOL) hasTestPrefix
{
    return [NSStringFromSelector([self selector]) hasPrefix:[self testMethodPrefix]];
}


- (unsigned) numberOfParameters
{
    return [[self methodSignature] numberOfArguments] - 2;
}


- (BOOL) hasTestCaseSignature
{
    return ([self numberOfParameters] == 0) && [self isReturningVoid] && [self hasTestPrefix];
}
@end
