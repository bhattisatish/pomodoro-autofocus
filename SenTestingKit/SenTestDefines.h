/*$Id: SenTestDefines.h,v 1.5 2004/01/05 13:40:46 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#if defined(WIN32)
    #undef SENTEST_EXPORT
    #if defined(BUILDINGSENTEST)
    #define SENTEST_EXPORT __declspec(dllexport) extern
    #else
    #define SENTEST_EXPORT __declspec(dllimport) extern
    #endif
    #if !defined(SENTEST_IMPORT)
    #define SENTEST_IMPORT __declspec(dllimport) extern
    #endif
#endif

#if !defined(SENTEST_EXPORT)
    #define SENTEST_EXPORT extern
#endif

#if !defined(SENTEST_IMPORT)
    #define SENTEST_IMPORT extern
#endif

#if !defined(SENTEST_STATIC_INLINE)
#define SENTEST_STATIC_INLINE static __inline__
#endif

#if !defined(SENTEST_EXTERN_INLINE)
#define SENTEST_EXTERN_INLINE extern __inline__
#endif
