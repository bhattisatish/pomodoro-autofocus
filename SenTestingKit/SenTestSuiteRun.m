/*$Id: SenTestSuiteRun.m,v 1.5 2004/01/05 13:40:47 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import "SenTestSuiteRun.h"
#import <Foundation/Foundation.h>
#import "SenTestingUtilities.h"

@implementation SenTestSuiteRun
- (id) initWithTest:(SenTest *) aTest
{
    self = [super initWithTest:aTest];
    runs = [[NSMutableArray alloc] init];
    return self;
}


- (void) dealloc
{
    RELEASE (runs);
    [super dealloc];
}


- (id) initWithCoder:(NSCoder *) aCoder
{
    [super initWithCoder:aCoder];
    runs = [[aCoder decodeObject] mutableCopy];
    return self;
}


- (void) encodeWithCoder:(NSCoder *) aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:[self testRuns]];
}


- (void) start
{
    [super start];
    [[NSNotificationCenter defaultCenter] postNotificationName:SenTestSuiteDidStartNotification object:self];
}


- (void) stop
{
    [super stop];
    [[NSNotificationCenter defaultCenter] postNotificationName:SenTestSuiteDidStopNotification object:self];
}


- (NSArray *) testRuns
{
    return runs;
}


- (void) addTestRun:(SenTestRun *) aTestRun
{
    [runs addObject:aTestRun];
}


- (unsigned int) failureCount
{
	int failureCount = 0;
	NSEnumerator *runEnumerator = [runs objectEnumerator];
	SenTestRun *eachRun;

	while (nil != (eachRun = [runEnumerator nextObject])) {
		failureCount += [eachRun failureCount];
	}
	
    return failureCount;
}


- (unsigned int) unexpectedExceptionCount
{
	int unexpectedExceptionCount = 0;
	NSEnumerator *runEnumerator = [runs objectEnumerator];
	SenTestRun *eachRun;
	
	while (nil != (eachRun = [runEnumerator nextObject])) {
		unexpectedExceptionCount += [eachRun unexpectedExceptionCount];
	}
	
    return unexpectedExceptionCount;
}


- (NSTimeInterval) testDuration
{
	NSTimeInterval testDuration = 0.0;
	NSEnumerator *runEnumerator = [runs objectEnumerator];
	SenTestRun *eachRun;
	
	while (nil != (eachRun = [runEnumerator nextObject])) {
		testDuration += [eachRun testDuration];
	}
	
    return testDuration;
}
@end

NSString *SenTestSuiteDidStartNotification = @"SenTestSuiteDidStartNotification";
NSString *SenTestSuiteDidStopNotification = @"SenTestSuiteDidStopNotification";
