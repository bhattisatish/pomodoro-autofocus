/*$Id: SenTestObserver.h,v 1.5 2004/01/05 13:40:46 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import <Foundation/Foundation.h>

@class SenTest;
@class SenTestRun;

@interface SenTestObserver : NSObject
{
}

+ (void) resumeObservation;
+ (void) suspendObservation;

+ (void) testSuiteDidStart:(NSNotification *) aNotification;
+ (void) testSuiteDidStop:(NSNotification *) aNotification;

+ (void) testCaseDidStart:(NSNotification *) aNotification;
+ (void) testCaseDidStop:(NSNotification *) aNotification;

+ (void) testCaseDidFail:(NSNotification *) aNotification;
@end

@interface NSNotification (SenTest)
- (SenTestRun *) run;
- (SenTest *) test;
- (NSException *) exception;
@end

