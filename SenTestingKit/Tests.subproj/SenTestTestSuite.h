/*$Id: SenTestTestSuite.h,v 1.7 2004/01/05 13:40:49 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import <SenTestingKit/SenTestingKit.h>

@interface SenEmptyTest:SenTestCase
@end


@interface SenSupersuite:SenTestCase
- (void) test1;
- (void) test2;
- (void) test3;
- (void) notATest;
@end


@interface SenSubsuiteWithoutInheritance:SenSupersuite
- (void) test4;
+ (BOOL) isInheritingTestCases;
@end


@interface SenSubsuiteWithInheritance:SenSupersuite
- (void) test4;
+ (BOOL) isInheritingTestCases;
@end


@interface SenTestTestSuite : SenTestCase
@end
