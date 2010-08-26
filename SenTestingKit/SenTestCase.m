/*$Id: SenTestCase.m,v 1.11 2004/01/05 13:40:45 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import "SenTestCase.h"
#import "SenTestSuite.h"
#import "SenTestCaseRun.h"
#import "NSException_SenTestFailure.h"
#import "NSInvocation_SenTesting.h"

#import "SenTestingUtilities.h"
#import "NSObject_SenTestRuntimeUtilities.h"
#import <Foundation/Foundation.h>


@implementation SenTestCase
- (id) init
{
    [self initWithInvocation:nil];
    return self;
}


- (id) initWithInvocation:(NSInvocation *) anInvocation
{
    self = [super init];
    [self continueAfterFailure];
    [self setInvocation:anInvocation];
    return self;
}


+ (id) testCaseWithInvocation:(NSInvocation *) anInvocation
{
    return [[[self alloc] initWithInvocation:anInvocation] autorelease];
}


- (id) initWithSelector:(SEL) aSelector
{
    NSInvocation *anInvocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:aSelector]];
    [anInvocation setSelector:aSelector];
    return [self initWithInvocation:anInvocation];
}


+ (id) testCaseWithSelector:(SEL) aSelector
{
    return [[[self alloc] initWithSelector:aSelector] autorelease];
}


- (Class) classForCoder
{
    return [SenTestCase class];
}


- (id) initWithCoder:(NSCoder *) aCoder
{
    ASSIGN(invocation, [aCoder decodeObject]);
    [aCoder decodeValueOfObjCType:@encode(SEL) at:&failureAction];
    return self;
}


- (void) encodeWithCoder:(NSCoder *) aCoder
{
    [aCoder encodeObject:invocation];
    [aCoder encodeValueOfObjCType:@encode(SEL) at:&failureAction];
}


- (SEL) selector
{
    return [invocation selector];
}


- (unsigned int) testCaseCount
{
    return 1;
}


- (NSString *) name
{
    return [NSString stringWithFormat:@"-[%@ %@]", NSStringFromClass([self class]), NSStringFromSelector([invocation selector])];
}


- (NSString *) description
{
    return [self name];
}


- (void) dealloc
{
    RELEASE (invocation);
    [super dealloc];
}


+ (void) setUp
{
}


+ (void) tearDown
{
}


- (NSInvocation *) invocation
{
    return invocation;
}


- (void) setInvocation:(NSInvocation *) anInvocation
{
    ASSIGN(invocation, anInvocation);
    [invocation setTarget:self];
}


- (SEL) failureAction
{
    return failureAction;
}


- (void) setFailureAction:(SEL) aSelector
{
    failureAction = aSelector;
}


- (void) continueAfterFailure
{
    [self setFailureAction:@selector(logException:)];
}


- (void) raiseAfterFailure
{
    [self setFailureAction:@selector(raiseException:)];
}


- (void) logException:(NSException *) anException
{
    [run addException: anException];
}


- (void) raiseException:(NSException *) anException
{
    [anException raise];    
}


- (void) failWithException:(NSException *) anException
{
    [self performSelector:failureAction withObject:anException];
}


- (Class) testRunClass
{
    return [SenTestCaseRun class];
}


- (void) performTest:(SenTestRun *) aTestRun
{
    NSException *exception = nil;

    ASSIGN(run, aTestRun);
    [self setUp];
    [run start];
    NS_DURING
        [invocation invoke];
    NS_HANDLER
        exception = localException;
    NS_ENDHANDLER
    [run stop];
    [self tearDown];

    if (exception != nil) {
        [self logException:exception];
    }
    RELEASE (run);
}


+ (BOOL) isInheritingTestCases
{
    return YES;
}


+ (NSArray *) testInvocations
{
    NSArray  *instanceInvocations = [self isInheritingTestCases] ? [self senAllInstanceInvocations] : [self senInstanceInvocations];
	NSMutableArray *testInvocations = [NSMutableArray array];
	NSEnumerator *instanceInvocationEnumerator = [instanceInvocations objectEnumerator];
	id each;
	
	while (nil != (each = [instanceInvocationEnumerator nextObject])) {
		if ([each hasTestCaseSignature]) {
			[testInvocations addObject:each];
		}
	}
    return testInvocations;
}
@end


@implementation SenTestCase (Suite)
+ (id) defaultTestSuite
{
    SenTestSuite *suite = [SenTestSuite testSuiteForTestCaseClass:self];
    return suite;
}
@end
