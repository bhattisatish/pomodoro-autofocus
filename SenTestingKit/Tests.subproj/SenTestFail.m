/*$Id: SenTestFail.m,v 1.6 2004/01/05 13:40:48 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import "SenTestFail.h"


@implementation SenTestFailTested
- (void) pass
{
}


- (void) fail
{
    fail ();
    fail1 (@"I fail...");
}


+ (unsigned int) failFailureCount
{
    return 2;
}
@end


@implementation SenTestFailTesting
- (Class) testedClass
{
    return [SenTestFailTested class];
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
