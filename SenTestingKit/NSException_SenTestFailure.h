/*$Id: NSException_SenTestFailure.h,v 1.5 2004/01/05 13:40:44 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import <Foundation/Foundation.h>
#import "SenTestDefines.h"

@interface NSException (SenTestFailure)

- (NSString *) filename;
- (NSString *) filePathInProject;
- (NSNumber *) lineNumber;

+ (NSException *) failureInFile:(NSString *) filename atLine:(int) lineNumber withDescription:description;
+ (NSException *) failureInCondition:(NSString *) condition isTrue:(BOOL) isTrue inFile:(NSString *) filename atLine:(int) lineNumber withDescription:description;
+ (NSException *) failureInEqualityBetween:(id) left and:(id) right  inFile:(NSString *) filename atLine:(int) lineNumber withDescription:description;
+ (NSException *) failureInRaise:(NSString *) expression inFile:(NSString *) filename atLine:(int) lineNumber withDescription:description;
+ (NSException *) failureInRaise:(NSString *) expression exception:(NSException *) exception inFile:(NSString *) filename atLine:(int) lineNumber withDescription:description;

@end


SENTEST_EXPORT NSString * const SenTestFailureException;

SENTEST_EXPORT NSString * const SenFailureTypeKey;

SENTEST_EXPORT NSString * const SenConditionFailure;
SENTEST_EXPORT NSString * const SenRaiseFailure;
SENTEST_EXPORT NSString * const SenEqualityFailure;
SENTEST_EXPORT NSString * const SenUnconditionalFailure;

SENTEST_EXPORT NSString * const SenTestConditionKey;
SENTEST_EXPORT NSString * const SenTestEqualityLeftKey;
SENTEST_EXPORT NSString * const SenTestEqualityRightKey;
SENTEST_EXPORT NSString * const SenTestFilenameKey;
SENTEST_EXPORT NSString * const SenTestLineNumberKey;
SENTEST_EXPORT NSString * const SenTestDescriptionKey;
