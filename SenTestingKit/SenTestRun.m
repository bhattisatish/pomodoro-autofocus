/*$Id: SenTestRun.m,v 1.9 2004/01/05 13:40:47 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import "SenTestRun.h"
#import "SenTestingUtilities.h"

@implementation SenTestRun
+ (id) testRunWithTest:(SenTest *) aTest
{
    return [[[self alloc] initWithTest:aTest] autorelease];
}


- (id) initWithTest:(SenTest *) aTest
{
    self = [super init];
    ASSIGN(test, aTest);
    return self;
}


- (void) dealloc
{
    RELEASE(test);
    [super dealloc];
}


- (id) initWithCoder:(NSCoder *) aCoder
{
    ASSIGN(test, [aCoder decodeObject]);
    [aCoder decodeValueOfObjCType:@encode(NSTimeInterval) at:&startDate];
    [aCoder decodeValueOfObjCType:@encode(NSTimeInterval) at:&stopDate];
    return self;
}


- (void) encodeWithCoder:(NSCoder *) aCoder
{
    [aCoder encodeObject:test];
    [aCoder encodeValueOfObjCType:@encode(NSTimeInterval) at:&startDate];
    [aCoder encodeValueOfObjCType:@encode(NSTimeInterval) at:&stopDate];
}


- (SenTest *) test
{
    return test;
}


- (NSTimeInterval) totalDuration
/*" Total elapsed time "*/
{
    return stopDate - startDate;
}


- (NSTimeInterval) testDuration
/*" Time spent in test cases "*/
{
    return [self totalDuration];
}


- (NSDate *) startDate
{
    return [NSDate dateWithTimeIntervalSinceReferenceDate:startDate];
}


- (NSDate *) stopDate
{
    return [NSDate dateWithTimeIntervalSinceReferenceDate:stopDate];
}


- (void) start
{
    startDate = [NSDate timeIntervalSinceReferenceDate];
}


- (void) stop
{
    stopDate = [NSDate timeIntervalSinceReferenceDate];
}


- (unsigned int) totalFailureCount
{
    return [self failureCount] + [self unexpectedExceptionCount];
}


- (unsigned int) failureCount
{
    return 0;
}


- (unsigned int) unexpectedExceptionCount
{
    return 0;
}


- (unsigned int) testCaseCount
{
    return [test testCaseCount];
}


- (BOOL) hasSucceeded
{
    return ([self totalFailureCount] == 0);
}



- (NSString *)description
{
    return [NSString stringWithFormat:@"Test:%@ started:%@ stopped:%@", [self test], [self startDate], [self stopDate]];
}
@end
