/*$Id: SenTest.h,v 1.7 2004/01/05 13:40:45 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.


/*"An abstract Test class. The SenTest, SenTestCase and SenTestSuite classes implement a Composite pattern."*/


#import <Foundation/Foundation.h>

@class SenTestRun;

@interface SenTest :NSObject
{
}

/*" Number of test cases"*/
- (unsigned int) testCaseCount;
- (BOOL) isEmpty;

/*"Test's name"*/
- (NSString *) name;

/*"Creating test runs"*/
- (Class) testRunClass;
- (void) performTest:(SenTestRun *) aRun;
- (SenTestRun *) run;

/*"Pre- and post-test methods"*/
- (void) setUp;
- (void) tearDown;
@end
