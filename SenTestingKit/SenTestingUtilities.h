/*$Id: SenTestingUtilities.h,v 1.1 2004/01/05 13:40:47 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import <Foundation/Foundation.h>

// Defining ASSIGN and RETAIN.
// ___newVal is to avoid multiple evaluations of val.
// RETAIN is deprecated and should not used.

#if defined (GNUSTEP)
// GNUstep has its own definitions of ASSIGN and RETAIN
#else
#define RETAIN(var,val) \
({ \
	id ___newVal = (val); \
        id ___oldVar = (var); \
			if (___oldVar != ___newVal) { \
				if (___newVal != nil) { \
					[___newVal retain]; \
				} \
				var = ___newVal; \
					if (___oldVar != nil) { \
						[___oldVar release]; \
					} \
			} \
})

#if defined(GARBAGE_COLLECTION)
#define ASSIGN(var,val) \
({ \
	var = val; \
})
#else
#define ASSIGN RETAIN
#endif
#endif



// Defining RELEASE.
//
// The RELEASE macro can be used in any place where a release 
// message would be sent. VAR is released and set to nil
#if defined (GNUSTEP)
// GNUstep has its own macro.
#else
#if defined(GARBAGE_COLLECTION)
#define RELEASE(var)
#else
#define RELEASE(var) \
({ \
	id	___oldVar = (id)(var); \
		if (___oldVar != nil) { \
			var = nil; \
                [___oldVar release]; \
		} \
})
#endif
#endif


@interface NSFileManager (SenTestingAdditions)
- (BOOL) fileExistsAtPathOrLink:(NSString *)aPath;
@end
