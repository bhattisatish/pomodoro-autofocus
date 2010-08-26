/*$Id: SenTestDistributedNotifier.m,v 1.7 2004/01/05 13:40:46 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import "SenTestDistributedNotifier.h"
#import "SenTestSuite.h"
#import "SenTestCase.h"
#import "SenTestRun.h"
#import "SenTestingUtilities.h"


@implementation SenTestDistributedNotifier
+ (NSString *) notificationIdentifier
{
    static NSString *notificationIdentifier = nil;
    if (notificationIdentifier == nil) {
        notificationIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"SenTestNotificationIdentifier"];
    }
    return notificationIdentifier;
}


- (void) postNotificationName:(NSString *) aName userInfo:(NSDictionary *) userInfo
{
    [[NSDistributedNotificationCenter defaultCenter] postNotificationName:aName
                                                                   object:[[self class] notificationIdentifier]
                                                                 userInfo:userInfo
                                                       deliverImmediately:NO];
}


+ (NSDictionary *) userInfoForObject:(id) anObject userInfo:(NSDictionary *) userInfo
{
    NSMutableDictionary *newUserInfo = [NSMutableDictionary dictionary];
    [newUserInfo setObject:[NSArchiver archivedDataWithRootObject:anObject] forKey:@"object"];
    if ([userInfo objectForKey:@"exception"] != nil) {
        [newUserInfo setObject:[NSArchiver archivedDataWithRootObject:[userInfo objectForKey:@"exception"]] forKey:@"exception"];
    }
    return newUserInfo;
}


+ (void) postNotificationName:(NSString *) aNotificationName object:(id) anObject userInfo:(NSDictionary *) userInfo
{
    [[NSDistributedNotificationCenter defaultCenter] postNotificationName:aNotificationName
                                                                   object:[self notificationIdentifier]
                                                                 userInfo:[self userInfoForObject:anObject userInfo:userInfo]
                                                       deliverImmediately:NO];
}


+ (void) testSuiteDidStart:(NSNotification *) aNotification
{
    [self postNotificationName:[aNotification name] object:[aNotification object] userInfo:[aNotification userInfo]];
}


+ (void) testSuiteDidStop:(NSNotification *) aNotification
{
    [self postNotificationName:[aNotification name] object:[aNotification object] userInfo:[aNotification userInfo]];
}


+ (void) testCaseDidStart:(NSNotification *) aNotification
{
    [self postNotificationName:[aNotification name] object:[aNotification object] userInfo:[aNotification userInfo]];
}


+ (void) testCaseDidStop:(NSNotification *) aNotification
{
    [self postNotificationName:[aNotification name] object:[aNotification object] userInfo:[aNotification userInfo]];
}


+ (void) testCaseDidFail:(NSNotification *) aNotification
{
    [self postNotificationName:[aNotification name] object:[aNotification object] userInfo:[aNotification userInfo]];
}
@end
