/*$Id: SenTestTestSuite.m,v 1.8 2004/01/05 13:40:49 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import "SenTestTestSuite.h"

@implementation SenTestTestSuite
- (void) testEmpty
{
    should ([[SenEmptyTest defaultTestSuite] isEmpty]);
}


- (void) testDefaultSuite
{
    should ([[SenSupersuite defaultTestSuite] testCaseCount] == 4);
}


- (void) testTestSuiteWithoutInheritance
{
    should ([[SenSubsuiteWithoutInheritance defaultTestSuite] testCaseCount] == 1);
}


- (void) testTestSuiteWithInheritance
{
    should ([[SenSubsuiteWithInheritance defaultTestSuite] testCaseCount] == 5);
}


- (void) testSuiteComposition
{
    SenTestSuite *suite = [SenTestSuite testSuiteWithName:@"Composite"];
    [suite addTest:[SenSupersuite defaultTestSuite]];
    [suite addTest:[SenSubsuiteWithoutInheritance defaultTestSuite]];
    should ([suite testCaseCount] == [[SenSupersuite defaultTestSuite] testCaseCount] + [[SenSubsuiteWithoutInheritance defaultTestSuite] testCaseCount]);
}


- (void) testSuiteForSingleCase
{
    should ([[SenTestSuite testSuiteForTestCaseWithName:@"SenSupersuite/test"] testCaseCount] == 1);
}


- (void) testSuiteForSingleCaseClass
{
    should ([[SenTestSuite testSuiteForTestCaseWithName:@"SenSupersuite"] testCaseCount] == [[SenSupersuite defaultTestSuite] testCaseCount]);
}

@end


@implementation SenSupersuite
- (void) test
{
}

- (void) test1
{
}

- (void) test2
{
}

- (void) test3
{
}

- (void) notATest
{
}
@end


@implementation SenSubsuiteWithoutInheritance
- (void) test4
{
}


+ (BOOL) isInheritingTestCases
{
    return NO;
}
@end


@implementation SenSubsuiteWithInheritance
- (void) test4
{
}


+ (BOOL) isInheritingTestCases
{
    return YES;
}
@end


@implementation SenEmptyTest:SenTestCase
- (void) notATest
{
}
@end
