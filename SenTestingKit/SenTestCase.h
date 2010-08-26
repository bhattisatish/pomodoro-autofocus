/*$Id: SenTestCase.h,v 1.12 2004/01/05 13:40:45 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.


#import <Foundation/NSObject.h>
#import "SenTest.h"

/*" Generate a failure when condition evaluates to false. "*/
#define should(condition)
#define should1(condition,description)

/*" Generate a failure when a condition evaluates to true. "*/
#define shouldnt(condition)
#define shouldnt1(condition,description)

/*" Generate a failure when [left isEqualTo:right] is false (or left is nil and right is not). "*/
#define shouldBeEqual(left,right)
#define shouldBeEqual1(left,right,description)

/*" Generate a failure when expression does not raise an exception. "*/
#define shouldRaise(expression)
#define shouldRaise1(expression,description)

/*" Generate a failure when expression does raise an exception. "*/
#define shouldntRaise(expression)
#define shouldntRaise1(expression,description)

/*" Generate a failure inconditionally. "*/
#define fail()
#define fail1(description)


/*"wrappers for should() and shouldnt() that will generate error messages if an exception is raised. Uses new-style exceptions"*/

#undef shouldnoraise(condition)
#undef should1noraise(condition,description)

#undef shouldntnoraise(condition)
#undef shouldnt1noraise(condition,description)


#import "SenTestCase_Macros.h"
#import "NSException_SenTestFailure.h"

/*"A test case defines the fixture to run multiple tests. To define a test case:

1) create a subclass of SenTestCase

2) implement test methods

3) optionally define instance variables that store the state of the fixture

4) optionally initialize the fixture state by overriding setUp

5) optionally clean-up after a test by overriding tearDown.


Test methods with no parameters, returning no value, and prefixed with 'test', such as:
!{
- (void) testSomething;
}

are automatically recognized as test cases by the SenTestingKit framework. Each SenTestCase subclass' defaultTestSuite is a SenTestSuite which includes theses tests.

Test methods implementations usually contains assertions that must be verified for the test to pass: the should() macros defined below. Here is an example:

!{
@interface MathTest : SenTestCase
{
    float f1;
    float f2;
}
- (void) testAddition;
@end


@implementation MathTest
- (void) setUp
{
    f1 = 2.0;
    f2 = 3.0;
}

- (void) testAddition
{
    should (f1 + f2 == 5.0);
}
@end
}

"*/

@class SenTestSuite;
@class SenTestCaseRun;

@interface SenTestCase : SenTest <NSCoding>
{
    @private
    NSInvocation *invocation;
    SenTestCaseRun *run;
    SEL failureAction;
}

/*"Creating test cases"*/
+ (id) testCaseWithInvocation:(NSInvocation *) anInvocation;
- (id) initWithInvocation:(NSInvocation *) anInvocation;

+ (id) testCaseWithSelector:(SEL) aSelector;
- (id) initWithSelector:(SEL) aSelector;

/*"Setting and returning invocation and selector"*/
- (void) setInvocation:(NSInvocation *) anInvocation;
- (NSInvocation *) invocation;
- (SEL) selector;

/*"Setting test case behavior after a failure"*/
- (void) continueAfterFailure;
- (void) raiseAfterFailure;

/*"Failing a test, used by all macros"*/
- (void) failWithException:(NSException *) anException;

/*"Returning the class' test methods"*/
+ (id) testInvocations;
@end


@interface SenTestCase (Suite)
/*"Returning a test suite with all the test cases"*/
+ (id) defaultTestSuite;
@end


@interface SenTestCase (_Protected)
- (SEL) failureAction;
- (void) setFailureAction:(SEL) aSelector;
@end
