/*$Id: SenTestCase_Macros.h,v 1.8 2004/01/05 13:40:45 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#undef fail
#undef fail1

#undef should
#undef should1

#undef shouldnt
#undef shouldnt1

#undef shouldBeEqual
#undef shouldBeEqual1

#undef shouldRaise
#undef shouldRaise1

#undef shouldntRaise
#undef shouldntRaise1

#undef shouldnoraise
#undef should1noraise

#undef shouldntnoraise
#undef shouldnt1noraise


#define fail1(description) \
do { \
    [self failWithException:[NSException failureInFile:[NSString stringWithCString:__FILE__] \
                                                atLine:__LINE__ \
                                       withDescription:description]]; \
} while (0)

#define fail() fail1(nil)


#define should1(condition,description) \
do {  \
    if (!(condition)) {  \
        [self failWithException:[NSException failureInCondition:[NSString stringWithCString:#condition] \
                                                         isTrue:NO \
                                                         inFile:[NSString stringWithCString:__FILE__] \
                                                         atLine:__LINE__ \
                                                withDescription:description]]; \
    }  \
} while (0)
#define should(expression)  should1(expression,nil)



#define shouldnt1(condition,description) \
do {  \
    if ((condition)) {  \
        [self failWithException:[NSException failureInCondition:[NSString stringWithCString:#condition] \
                                                         isTrue:YES \
                                                         inFile:[NSString stringWithCString:__FILE__] \
                                                         atLine:__LINE__ \
                                                withDescription:description]]; \
    }  \
} while (0)
#define shouldnt(expression)  shouldnt1(expression,nil)



#define shouldBeEqual1(left,right,description)  \
do {  \
    id leftVal = (left); \
    id rightVal = (right); \
        if (((leftVal == nil) && (rightVal != nil)) || ((leftVal != nil) && ![leftVal isEqual:rightVal])) { \
            [self failWithException:[NSException failureInEqualityBetween:leftVal \
                                                                      and:rightVal \
                                                                   inFile:[NSString stringWithCString:__FILE__] \
                                                                   atLine:__LINE__ \
                                                          withDescription:description]]; \
    }  \
} while (0)
#define shouldBeEqual(left,right)  shouldBeEqual1(left,right,nil)



#define shouldRaise1(expression,description)  \
do {  \
    NSException *expectedException = nil;  \
    NS_DURING  \
        (expression);  \
    NS_HANDLER  \
        expectedException = localException; \
    NS_ENDHANDLER \
    if (expectedException == nil) { \
        [self failWithException:[NSException failureInRaise:[NSString stringWithCString:#expression] \
                                                     inFile:[NSString stringWithCString:__FILE__] \
                                                     atLine:__LINE__ \
                                            withDescription:description]]; \
    } \
} while (0)
#define shouldRaise(expression)  shouldRaise1(expression,nil)



#define shouldntRaise1(expression,description)  \
do {  \
    NSException *unexpectedException = nil;  \
    NS_DURING  \
        (expression);  \
    NS_HANDLER  \
        unexpectedException = localException; \
    NS_ENDHANDLER \
    if (unexpectedException != nil) { \
        [self failWithException:[NSException failureInRaise:[NSString stringWithCString:#expression] \
                                                  exception:unexpectedException \
                                                     inFile:[NSString stringWithCString:__FILE__] \
                                                     atLine:__LINE__ \
                                            withDescription:(description)]]; \
    } \
} while (0)
#define shouldntRaise(expression)  shouldntRaise1(expression,nil)


#define should1noraise(condition,description) \
do {  \
    @try { \
		if (!(condition)) {  \
			[self failWithException:[NSException failureInCondition:[NSString stringWithCString:#condition] \
													isTrue:NO \
													inFile:[NSString stringWithCString:__FILE__] \
													atLine:__LINE__ \
										   withDescription:description]]; \
		} \
    } \
    @catch (NSException *exception) { \
		[self failWithException:[NSException failureInRaise:[NSString stringWithCString:#condition] \
											exception:exception \
											   inFile:[NSString stringWithCString:__FILE__] \
											   atLine:__LINE__ \
									  withDescription:(description)]]; \
	} \
} while (0)
#define shouldnoraise(expression)  should1noraise(expression,nil)



#define shouldnt1noraise(condition,description) \
do {  \
    @try { \
		if ((condition)) {  \
			[self failWithException:[NSException failureInCondition:[NSString stringWithCString:#condition] \
													isTrue:YES \
													inFile:[NSString stringWithCString:__FILE__] \
													atLine:__LINE__ \
										   withDescription:description]]; \
		} \
    } \
    @catch (NSException *exception) { \
        [self failWithException:[NSException failureInRaise:[NSString stringWithCString:#condition] \
                                                  exception:exception \
                                                     inFile:[NSString stringWithCString:__FILE__] \
                                                     atLine:__LINE__ \
                                            withDescription:(description)]]; \
    } \
} while (0)
#define shouldntnoraise(expression)  shouldnt1noraise(expression,nil)

