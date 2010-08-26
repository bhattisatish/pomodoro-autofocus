/*$Id: SenTestingUtilities.m,v 1.2 2004/01/06 16:39:38 phink Exp $*/

// Copyright (c) 1997-2004, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the license in OpenSourceLicense.html
// found in this distribution and at http://www.sente.ch/software/ ,  where the
// original version of this source code can also be found.
// This notice may not be removed from this file.

#import "SenTestingUtilities.h"

@implementation NSFileManager (SenTestingAdditions)
- (BOOL) fileExistsAtPathOrLink:(NSString *)aPath
    /*" This checks to see if the file path in the argument aPath points to an 
	existing file or directory. If it does then this method returns YES; 
	otherwise NO is returned (i.e. aPath is nil, empty or does not exists).
	This method follows links.

	We are using this method in place of #{-fileExistsAtPath:} in 
	NSFileManager since that method does not follow links even though the
	documentation says it does. This was the case with Xcode on Jaguar says
	William Swats as of 22-Oct-2003.
    "*/
{
    if ((aPath != nil) && ![aPath isEqualToString:@""]) {
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] fileAttributesAtPath:aPath traverseLink:YES];
        if ((fileAttributes != nil) && ([fileAttributes count] > 0)) {
            return YES;
        }        
    }
    return NO;
}
@end
