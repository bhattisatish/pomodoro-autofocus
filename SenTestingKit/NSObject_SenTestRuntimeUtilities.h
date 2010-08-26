/*$Id: NSObject_SenTestRuntimeUtilities.h,v 1.1 2004/01/05 13:40:45 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import <Foundation/Foundation.h>

@interface NSObject (SenTestRuntimeUtilities)

- (NSArray *) senAllSubclasses;
- (NSArray *) senInstanceInvocations;
- (NSArray *) senAllInstanceInvocations;

@end

