/*$Id: SenTestClassEnumerator.h,v 1.1 2004/01/05 13:40:46 phink Exp $*/

// Copyright (c) 1997-2003, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import <Foundation/Foundation.h>

#if defined (GNUSTEP)
#import <objc/runtime.h>
#elif !defined (RHAPSODY)
// import nothing
#else
#import <objc/objc-runtime.h>
#endif

@interface SenTestClassEnumerator : NSEnumerator
{
#if defined (GNUSTEP)
    void *state;
    void *_reserved;
#elif defined (RHAPSODY)
    NXHashTable *class_hash;
    NXHashState state;
#else
    NSMutableArray *classes;
    int currentIndex;
#endif

    BOOL isAtEnd;
}

+ (NSEnumerator *) classEnumerator;
@end
