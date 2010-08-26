/*$Id: SenTestObserver.m,v 1.6 2004/01/05 13:40:46 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import "SenTestObserver.h"
#import "SenTestSuiteRun.h"
#import "SenTestCaseRun.h"
#import "SenTestingUtilities.h"
#import <Foundation/Foundation.h>

@implementation NSNotification (SenTest)
- (SenTestRun *) run
{
    return [self object];
}


- (SenTest *) test
{
    return [[self run] test];
}


- (NSException *) exception
{
    return [[self userInfo] objectForKey:@"exception"];
}
@end


@implementation SenTestObserver

// FIXME. Not very elegant  and only one observer currently possible.
static Class currentObserverClass = Nil;
static BOOL isSuspended = YES;

+ (void) setCurrentObserver:(Class) anObserver
{
    if (currentObserverClass != Nil) {
        [self suspendObservation];
    }
    currentObserverClass = anObserver;
    if (currentObserverClass != Nil) {
        [self resumeObservation];
    }
}


+ (void) resumeObservation
{
    if (isSuspended) {
        [[NSNotificationCenter defaultCenter] addObserver:currentObserverClass
                                                 selector:@selector(testSuiteDidStart:)
                                                     name:SenTestSuiteDidStartNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:currentObserverClass
                                                 selector:@selector(testSuiteDidStop:)
                                                     name:SenTestSuiteDidStopNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:currentObserverClass
                                                 selector:@selector(testCaseDidStart:)
                                                     name:SenTestCaseDidStartNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:currentObserverClass
                                                 selector:@selector(testCaseDidStop:)
                                                     name:SenTestCaseDidStopNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:currentObserverClass
                                                 selector:@selector(testCaseDidFail:)
                                                     name:SenTestCaseDidFailNotification
                                                   object:nil];
        isSuspended = NO;
    }
}


+ (void) suspendObservation
{
    if (!isSuspended) {
        [[NSNotificationCenter defaultCenter] removeObserver:currentObserverClass];
        isSuspended = YES;
    }
}


+ (void) initialize
{
    if ([self class] == [SenTestObserver class]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *registeredDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
            @"SenTestLog" , @"SenTestObserverClass",
            nil];
        [defaults registerDefaults:registeredDefaults];
        [NSClassFromString ([defaults objectForKey:@"SenTestObserverClass"]) class]; // make sure default observer is loaded
    }
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"SenTestObserverClass"] isEqualToString:NSStringFromClass(self)]) {
        [self setCurrentObserver:self];
    }
}


+ (void) testSuiteDidStart:(NSNotification *) aNotification
{   
}


+ (void) testSuiteDidStop:(NSNotification *) aNotification
{
}


+ (void) testCaseDidStart:(NSNotification *) aNotification
{
}


+ (void) testCaseDidStop:(NSNotification *) aNotification
{
}


+ (void) testCaseDidFail:(NSNotification *) aNotification
{
}
@end
