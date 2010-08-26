/*$Id: SenTestErrorTesting.m,v 1.9 2004/01/05 13:40:48 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import "SenTestErrorTesting.h"
#import "SenTestingUtilities.h"

@interface SenErrorTest: SenTestCase
@end


@implementation SenErrorTest
- (void) error
{
    [NSException raise:NSGenericException format:@"A voluntary error"];
    [NSException raise:NSGenericException format:@"Another voluntary error"];
}
@end


@implementation SenTestErrorTesting
- (void) setUp
{
    ASSIGN(testRun, [self silentRunForTest:[SenErrorTest testCaseWithSelector:@selector(error)]]);
}


- (void) tearDown
{
    RELEASE (testRun);
}


- (void) testUnfailureCount
{
    should ([testRun unexpectedExceptionCount] == 1);
}


- (void) testExpectedFailureCount
{
    should ([testRun failureCount] == 0);
}


- (void) testSuccess
{
    shouldnt ([testRun hasSucceeded]);
}
@end
