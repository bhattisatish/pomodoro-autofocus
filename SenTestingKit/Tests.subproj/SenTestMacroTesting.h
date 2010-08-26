/*$Id: SenTestMacroTesting.h,v 1.6 2004/01/05 13:40:48 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import <SenTestingKit/SenTestingKit.h>

@protocol SenTestTestedMacro
+ (unsigned int) failFailureCount;
- (void) pass;
- (void) fail;
@end


@interface SenTestMacroTesting : SenTestCase
{
    SenTestRun *passedRun;
    SenTestRun *failedRun;
}
- (Class) testedClass;
- (SenTestRun *) silentRunForTest:(SenTest *) aTest;
@end
