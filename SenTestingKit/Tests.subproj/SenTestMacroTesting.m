/*$Id: SenTestMacroTesting.m,v 1.7 2004/01/05 13:40:48 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import "SenTestMacroTesting.h"
#import "SenTestingUtilities.h"

@implementation SenTestMacroTesting
- (SenTestRun *) silentRunForTest:(SenTest *) aTest
{
    SenTestRun *testRun;
    [SenTestObserver suspendObservation];
    testRun = [aTest run];
    [SenTestObserver resumeObservation];
    return testRun;
}


- (Class) testedClass
{
    return Nil;
}


- (void) setUp
{
    ASSIGN(passedRun, [self silentRunForTest:[[self testedClass] testCaseWithSelector:@selector(pass)]]);
    ASSIGN(failedRun, [self silentRunForTest:[[self testedClass] testCaseWithSelector:@selector(fail)]]);
}


- (void) tearDown
{
    RELEASE (passedRun);
    RELEASE (failedRun);
}
@end
