/*$Id: SenTestLog.m,v 1.7 2004/01/05 13:40:46 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import "SenTestLog.h"
#import "SenTestSuite.h"
#import "SenTestCase.h"
#import "SenTestRun.h"
#import "NSException_SenTestFailure.h"
#import "SenTestingUtilities.h"

@implementation SenTestLog
static void testlog (NSString *message)
{
    fprintf (stderr, "%s\n", [message cString]);
    fflush (stderr);
}

#ifdef GNU_RUNTIME
// unlike the NeXT runtime, the GNU runtime doesn't call super automatically
+ (void) initialize
{
    [super initialize];
}
#endif

+ (void) testCaseDidStop:(NSNotification *) aNotification
{
    SenTestRun *run = [aNotification run];
    testlog ([NSString stringWithFormat:@"Test Case '%@' %s (%.3f seconds).", [run test], ([run hasSucceeded] ? "passed" : "failed"), [run totalDuration]]);
}


+ (void) testSuiteDidStart:(NSNotification *) aNotification
{
    SenTestRun *run = [aNotification run];
    testlog ([NSString stringWithFormat:@"Test Suite '%@' started at %@", [run test], [run startDate]]);
}


+ (void) testSuiteDidStop:(NSNotification *) aNotification
{
    SenTestRun *run = [aNotification run];
    testlog ([NSString stringWithFormat:@"Test Suite '%@' finished at %@.\nPassed %d test%s, with %d failure%s (%d unexpected) in %.3f (%.3f) seconds\n",
        [run test],
        [run stopDate],
        [run testCaseCount], ([run testCaseCount] != 1 ? "s" : ""),
        [run totalFailureCount], ([run totalFailureCount] != 1 ? "s" : ""),
        [run unexpectedExceptionCount],
        [run testDuration],
        [run totalDuration]]);
}


+ (void) testCaseDidFail:(NSNotification *) aNotification
{
    NSException *exception = [aNotification exception];
    testlog ([NSString stringWithFormat:@"%@:%@: %@ : %@",
        [exception filePathInProject],
        [exception lineNumber],
        [aNotification test],
        [exception reason]]);
}
@end
