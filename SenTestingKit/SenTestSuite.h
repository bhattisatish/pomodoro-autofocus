/*$Id: SenTestSuite.h,v 1.7 2004/01/05 13:40:47 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import "SenTest.h"
#import "SenTestCase.h"
#import <Foundation/Foundation.h>

/*"A TestSuite is a Composite of Tests. It runs a collection of test cases. Here is an example using the dynamic test definition.

!{
 SenTestSuite *suite= [SenTestSuite testSuiteWithName:@"My tests"];
 [suite addTest: [MathTest testCaseWithSelector:@selector(testAdd)]];
 [suite addTest: [MathTest testCaseWithSelector:@selector(testDivideByZero)]];
}

Alternatively, a TestSuite can extract the tests to be run automatically. To do so you pass the class of your TestCase class to the TestSuite constructor. 

!{
 SenTestSuite *suite= [SenTestSuite testSuiteForTestCaseClass:[MathTest class]];
}

This  creates a suite with all the methods starting with "test" that take no arguments. 


And finally, a TestSuite of all the test cases found in the runtime can be created automatically:

!{
 SenTestSuite *suite = [SenTestSuite defaultTestSuite];
}

This  creates a suite of suites with all the SenTestCase subclasses methods starting with "test" that take no arguments. 

"*/

@interface SenTestSuite : SenTest <NSCoding>
{
    @private
    NSString *name;
    NSMutableArray *tests;
}

+ (id) defaultTestSuite;
+ (id) testSuiteForBundlePath:(NSString *) bundlePath;
+ (id) testSuiteForTestCaseWithName:(NSString *) aName;
+ (id) testSuiteForTestCaseClass:(Class) aClass;

+ (id) testSuiteWithName:(NSString *) aName;
- (id) initWithName:(NSString *) aName;

- (void) addTest:(SenTest *) aTest;
- (void) addTestsEnumeratedBy:(NSEnumerator *) anEnumerator;
@end

@interface SenTestCase (SenTestSuiteExtensions)
+ (void) setUp;
+ (void) tearDown;
@end

