/*$Id: SenTestShouldRaise.m,v 1.8 2004/01/05 13:40:49 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import "SenTestShouldRaise.h"

@implementation SenTestShouldRaiseTested
- (void) pass
{
    shouldRaise ([NSException raise:NSGenericException format:@"A voluntary error"]);
    shouldntRaise ([[NSMutableArray array] addObject:@"a"]);
    shouldRaise1 ([NSException raise:NSGenericException format:@"A voluntary error"], @"ok");
    shouldntRaise1 ([[NSMutableArray array] addObject:@"a"], @"ok");
}


- (void) fail
{
    shouldRaise ([[NSMutableArray array] addObject:@"a"]);
    shouldntRaise ([NSException raise:NSGenericException format:@"A voluntary error"]);
    shouldRaise1 ([[NSMutableArray array] addObject:@"a"], ([NSString stringWithFormat:@"Not ok %@ %d", self, 12]));
    shouldntRaise1 ([NSException raise:NSGenericException format:@"A voluntary error"], ([NSString stringWithFormat:@"Not ok %@ %d", self, 12]));
}


+ (unsigned int) failFailureCount
{
    return 4;
}
@end


@implementation SenTestShouldRaiseTesting
- (Class) testedClass
{
    return [SenTestShouldRaiseTested class];
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
