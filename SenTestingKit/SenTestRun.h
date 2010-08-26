/*$Id: SenTestRun.h,v 1.6 2004/01/05 13:40:46 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import <Foundation/NSObject.h>
#import "SenTest.h"

/*"A TestResult collects the results of executing a test. The test framework distinguishes between %failures which are anticipated and checked for problems like a test that failed; and %{unexpected failures} which are unforeseen (catastrophic) problems, like an exception.
"*/

@interface SenTestRun : NSObject <NSCoding>
{
    @private
    NSTimeInterval startDate;
    NSTimeInterval stopDate;
    SenTest * test;
}

+ (id) testRunWithTest:(SenTest *) aTest;
- (id) initWithTest:(SenTest *) aTest;

- (SenTest *) test;

- (void) start;
- (void) stop;

- (NSDate *) startDate;
- (NSDate *) stopDate;
- (NSTimeInterval) totalDuration; 
- (NSTimeInterval) testDuration;

- (unsigned int) testCaseCount;

- (unsigned int) failureCount;
- (unsigned int) unexpectedExceptionCount;
- (unsigned int) totalFailureCount;
- (BOOL) hasSucceeded;
@end
