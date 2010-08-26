/*$Id: SenTestProbe.h,v 1.9 2004/01/05 13:40:46 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import <Foundation/Foundation.h>

int SenSelfTestMain();

@interface SenTestProbe : NSObject
+ (BOOL) isTesting;
//+ (void) lateInitialize;
@end

#import "SenTestDefines.h"
#import <Foundation/Foundation.h>

SENTEST_EXPORT NSString *SenTestedUnitPath;
SENTEST_EXPORT NSString *SenTestScopeKey;
SENTEST_EXPORT NSString *SenTestScopeAll;
SENTEST_EXPORT NSString *SenTestScopeNone;
SENTEST_EXPORT NSString *SenTestScopeSelf;
