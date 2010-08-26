/*$Id: NSException_SenTestFailure.m,v 1.13 2004/01/05 13:40:44 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import "NSException_SenTestFailure.h"
#import "SenTestCase.h"
#import "SenTestingUtilities.h"
#import <Foundation/Foundation.h>

@implementation NSException (SenTestFailure)

- (NSString *) filename
{
    return [[self userInfo] objectForKey:SenTestFilenameKey];
}


- (NSSet *) ignoredSubdirectories
{
    static NSSet *ignoredSubdirectories = nil;
    if (ignoredSubdirectories == nil) {
        NSString *path = [[NSBundle bundleForClass:[SenTestCase class]] pathForResource:@"NoSourceDirectoryExtensions" ofType:@"plist"];
        ASSIGN (ignoredSubdirectories, [NSSet setWithArray:[[NSString stringWithContentsOfFile:path] propertyList]]);
    }
    return ignoredSubdirectories;
}


- (NSString *) currentDirectoryPath
{
#ifndef WIN32
    return [[NSFileManager defaultManager] currentDirectoryPath];
#else
    return [[[[NSProcessInfo processInfo] arguments] lastObject] stringByDeletingLastPathComponent];
#endif
}

- (NSString *) pathForFilename:(NSString *) aFilename
{
    if ((aFilename == nil) || [aFilename isEqualToString:@""]) {
        return @"Unknown.m";
    }
    else {
        NSString *currentDirectoryPath = [self currentDirectoryPath];
        NSString *projectPath = [currentDirectoryPath stringByAppendingPathComponent:@"PB.project"];

        if ([[NSFileManager defaultManager] fileExistsAtPathOrLink:projectPath]) {
            NSDirectoryEnumerator *directoryEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:currentDirectoryPath];
            NSString *each = nil;
            while (each = [directoryEnumerator nextObject]) {
                if ([[self ignoredSubdirectories] containsObject:[each pathExtension]]) {
                    [directoryEnumerator skipDescendents];
                }
                else if ([[each lastPathComponent] isEqualToString:aFilename]) {
                    return [currentDirectoryPath stringByAppendingPathComponent:each];
                    //return each; // for OPENSTEP.
                }
            }
        }
        return aFilename;
    }
}


- (NSString *) filePathInProject
{
    return [self pathForFilename:[self filename]];
}


- (NSNumber *) lineNumber
{
    NSNumber *n = [[self userInfo] objectForKey:SenTestLineNumberKey];
    return (n == nil) ? [NSNumber numberWithInt:0] : n;
}


+ (NSString *) formatWithDescription:(NSString *) description
{
    return (description == nil) || [description isEqualToString:@""] ? @"" : [NSString stringWithFormat:@" (%@)", description];
}


+ (NSException *) failureInFile:(NSString *) filename atLine:(int) lineNumber withDescription:description
{
    return [self exceptionWithName:SenTestFailureException

                            reason:[self formatWithDescription:description]

                                 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                     SenUnconditionalFailure, SenFailureTypeKey,
                                     filename, SenTestFilenameKey,
                                     [NSNumber numberWithInt:lineNumber], SenTestLineNumberKey,
                                     description, SenTestDescriptionKey, // description could be nil, last item in enumeration
                                     nil]];
}


+ (NSException *) failureInCondition:(NSString *) condition isTrue:(BOOL) isTrue inFile:(NSString *) filename atLine:(int) lineNumber withDescription:description
{
    return [self exceptionWithName:SenTestFailureException

                            reason:[NSString stringWithFormat:@"%@ should be %@%@", condition, (isTrue ? @"false" : @"true"), [self formatWithDescription:description]]

                                 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                     SenConditionFailure, SenFailureTypeKey,
                                     condition, SenTestConditionKey,
                                     filename, SenTestFilenameKey,
                                     [NSNumber numberWithInt:lineNumber], SenTestLineNumberKey,
                                     description, SenTestDescriptionKey, // description could be nil, last item in enumeration
                                     nil]];
}


+ (NSException *) failureInEqualityBetween:(id) left and:(id) right inFile:(NSString *) filename atLine:(int) lineNumber withDescription:description
{
    return [self exceptionWithName:SenTestFailureException

                             reason:[NSString stringWithFormat:@"'%@' should be equal to '%@' %@",
                                 [left description],
                                 [right description],
                                 [self formatWithDescription:description]]

                           userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                               SenEqualityFailure, SenFailureTypeKey,
                               ((left != nil) ? left : @"*nil*"), SenTestEqualityLeftKey,
                               ((right != nil) ? right : @"*nil*"), SenTestEqualityRightKey,
                               filename, SenTestFilenameKey,
                               [NSNumber numberWithInt:lineNumber], SenTestLineNumberKey,
                               description, SenTestDescriptionKey, // description could be nil, last item in enumeration
                               nil]];
}

+ (NSException *) failureInRaise:(NSString *) expression exception:(NSException *) exception inFile:(NSString *) filename atLine:(int) lineNumber withDescription:description
{
    return [self exceptionWithName:SenTestFailureException

                            reason:(exception != nil) ?
                                   ([NSString stringWithFormat:@"%@ raised %@%@", expression, [exception reason], [self formatWithDescription:description]]) :
                                   ([NSString stringWithFormat:@"%@ should raise %@", expression, [self formatWithDescription:description]])

                           userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                               SenRaiseFailure, SenFailureTypeKey,
                               expression, SenTestConditionKey,
                               filename, SenTestFilenameKey,
                               [NSNumber numberWithInt:lineNumber], SenTestLineNumberKey,
                               description, SenTestDescriptionKey, // description could be nil, last item in enumeration
                               nil]];
}


+ (NSException *) failureInRaise:(NSString *) expression inFile:(NSString *) filename atLine:(int) lineNumber withDescription:description
{
    return [self failureInRaise:expression exception:nil inFile:filename atLine:lineNumber withDescription:description];
}
@end


NSString * const SenTestFailureException = @"SenTestFailureException";

NSString * const SenFailureTypeKey = @"SenFailureTypeKey";
NSString * const SenUnconditionalFailure = @"SenUnconditionalFailure";
NSString * const SenConditionFailure = @"SenConditionFailure";
NSString * const SenEqualityFailure = @"SenEqualityFailure";
NSString * const SenRaiseFailure = @"SenRaiseFailure";

NSString * const SenTestConditionKey = @"SenTestConditionKey";
NSString * const SenTestEqualityLeftKey = @"SenTestEqualityLeftKey";
NSString * const SenTestEqualityRightKey = @"SenTestEqualityRightKey";

NSString * const SenTestFilenameKey = @"SenTestFilenameKey";
NSString * const SenTestLineNumberKey = @"SenTestLineNumberKey";
NSString * const SenTestDescriptionKey = @"SenTestDescriptionKey";
