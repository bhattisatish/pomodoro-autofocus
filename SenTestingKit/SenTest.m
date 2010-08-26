/*$Id: SenTest.m,v 1.8 2004/01/05 13:40:45 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import "SenTest.h"
#import "SenTestRun.h"


@implementation SenTest

- (BOOL) isEmpty
/*"Returns YES if testCaseCount is 0."*/
{
    return [self testCaseCount] == 0;
}


- (unsigned int) testCaseCount
/*"Must overriden by subclasses."*/
{
    return 0;
}


- (Class) testRunClass
/*"The SenTestRun subclass that will be created when a test is run to hold the test's results. Must overriden by subclasses."*/
{
    return nil;
}

- (NSString *) name
/*"Must overriden by subclasses."*/
{
    return nil;
}


- (void) performTest:(SenTestRun *) aRun
/*"The method through which test are executed. Must overriden by subclasses. "*/
{
}


- (void) setUp
/*"Sets up the fixture. This method is called before a test is executed."*/
{
}


- (void) tearDown
/*"Tears down the fixture. This method is called after a test is executed."*/
{
}


- (SenTestRun *) run
/*"Creates a SenTestRun of the testRunClass and pass it as a parameter to the performTest method. "*/
{
    SenTestRun *testRun = [[self testRunClass] testRunWithTest:self];
    [self performTest:testRun];
    return testRun;
}
@end
