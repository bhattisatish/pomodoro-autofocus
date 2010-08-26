/*$Id: SenTestContinueOrRaiseTesting.m,v 1.7 2004/01/05 13:40:48 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import "SenTestContinueOrRaiseTesting.h"
#import "SenTestingUtilities.h"

@interface SenFailureTest: SenTestCase
@end


@implementation SenFailureTest
- (void) failThrice
{
   shouldBeEqual (@"a", @"A");
   shouldBeEqual (@"a", @"A");
   shouldRaise ([@"a" isEqualToString:@"x"]);
}
@end


@implementation SenTestContinueOrRaiseTesting
- (void) setUp
{
    ASSIGN(failThrice, [SenFailureTest testCaseWithSelector:@selector(failThrice)]);
}


- (void) tearDown
{
    RELEASE (failThrice);
}


- (void) testRaiseAfterFailure
{
    [failThrice raiseAfterFailure];
    should ([[self silentRunForTest:failThrice] failureCount] == 1);
}


- (void) testContinueAfterFailure
{
    [failThrice continueAfterFailure];
    should ([[self silentRunForTest:failThrice] failureCount] == 3);
}
@end
