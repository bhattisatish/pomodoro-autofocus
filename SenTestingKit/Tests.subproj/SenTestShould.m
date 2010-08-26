/*$Id: SenTestShould.m,v 1.6 2004/01/05 13:40:48 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import "SenTestShould.h"

@implementation SenTestShouldTested
- (void) pass
{
    should (YES);
    shouldnt (NO);
    should1 (YES, @"YES");
    shouldnt1 (NO, @"NO");
}


- (void) fail
{
    shouldnt (YES);
    should (NO);
    shouldnt1 (YES, @"NO!");
    should1 (NO, @"YES");
}


+ (unsigned int) failFailureCount
{
    return 4;
}
@end


@implementation SenTestShouldTesting
- (Class) testedClass
{
    return [SenTestShouldTested class];
}


- (void) testPass
{
    should ([passedRun failureCount] == 0);
    should ([passedRun unexpectedExceptionCount] == 0);
    should ([passedRun hasSucceeded]);
}


- (void) testFail
{
    should ([failedRun failureCount] == [[self testedClass] failFailureCount]);
    should ([failedRun unexpectedExceptionCount] == 0);
    shouldnt ([failedRun hasSucceeded]);
}
@end
