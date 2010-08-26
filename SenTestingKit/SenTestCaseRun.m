/*$Id: SenTestCaseRun.m,v 1.5 2004/01/05 13:40:45 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import "SenTestCaseRun.h"
#import "NSException_SenTestFailure.h"
#import <Foundation/Foundation.h>
#import "SenTestingUtilities.h"

@implementation SenTestCaseRun

- (id) initWithTest:(SenTest *) aTest
{
    self = [super initWithTest:aTest];
    exceptions = [[NSMutableArray alloc] init];
    return self;
}


- (void) dealloc
{
    RELEASE (exceptions);
    [super dealloc];
}


- (id) initWithCoder:(NSCoder *) aCoder
{
    [super initWithCoder:aCoder];
    exceptions = [[aCoder decodeObject] mutableCopy];
    return self;
}


- (void) encodeWithCoder:(NSCoder *) aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:[self exceptions]];
}


- (NSArray *) exceptions
{
    return exceptions;
}


- (void) start
{
    [super start];
    [[NSNotificationCenter defaultCenter] postNotificationName:SenTestCaseDidStartNotification object:self];
}


- (void) stop
{
    [super stop];
    [[NSNotificationCenter defaultCenter] postNotificationName:SenTestCaseDidStopNotification object:self];
}


- (unsigned int) failureCount
{
    return failureCount;
}


- (unsigned int) unexpectedExceptionCount
{
    return unexpectedExceptionCount;
}


- (void) addException:(NSException *) anException
{
	
    ([[anException name] isEqualToString:SenTestFailureException] ? failureCount : unexpectedExceptionCount)++;
    [exceptions addObject:anException];
    [[NSNotificationCenter defaultCenter] postNotificationName:SenTestCaseDidFailNotification
                                                        object:self
                                                      userInfo:[NSDictionary dictionaryWithObject:anException forKey:@"exception"]];
}
@end


NSString *SenTestCaseDidStartNotification = @"SenTestCaseDidStartNotification";
NSString *SenTestCaseDidStopNotification = @"SenTestCaseDidStopNotification";
NSString *SenTestCaseDidFailNotification = @"SenTestCaseDidFailNotification";
