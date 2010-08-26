/*$Id: SenInterfaceTestCase.m,v 1.5 2004/01/05 13:40:45 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import "SenInterfaceTestCase.h"
#import "SenTestProbe.h"
#import "SenTestingUtilities.h"


@implementation SenInterfaceTestCase
- (NSMutableDictionary *) interfaceTestCaseCache
{
    static NSMutableDictionary *interfaceTestCaseCache = nil;
    if (interfaceTestCaseCache == nil) {
        interfaceTestCaseCache = [[NSMutableDictionary alloc] init];
    }
    return interfaceTestCaseCache;
}


- (void) registerInterfaceTestCase
{
    isInstanciatedInInterface = YES;
    [[self interfaceTestCaseCache] setObject:self forKey:NSStringFromClass ([self class])];
}


- (SenInterfaceTestCase *) interfaceTestCase
{
    return [[self interfaceTestCaseCache] objectForKey:NSStringFromClass([self class])];
}


- (id) initWithInvocation: (NSInvocation *) anInvocation
{
    self = [super initWithInvocation:anInvocation];
    isInstanciatedInInterface = NO;
    return self;
}


- (void) awakeFromNib
{
    if ([SenTestProbe isTesting]) {
        [self registerInterfaceTestCase];
    }
    else {
        [self autorelease];
    }
}


- (void) performInterfaceTest:(SenTestRun *) aTestRun
{
    SenInterfaceTestCase *interfaceTestCase = [self interfaceTestCase];
    [interfaceTestCase setFailureAction: [self failureAction]];
    [interfaceTestCase setInvocation:[self invocation]];
    [interfaceTestCase performTest:aTestRun];
}


- (void) performTest:(SenTestRun *) aTestRun
{
    if (isInstanciatedInInterface) {
        [super performTest:aTestRun];        
    }
    else {
        [self performInterfaceTest:aTestRun];
    }
}
@end
