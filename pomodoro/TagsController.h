//
//  TagsController.h
//  pomodoro
//
//  Created by Giordano Scalzo on 8/26/10.
//  Copyright 2010 CleanCode. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TagsController : NSObject {
	NSMutableArray *tags;
	IBOutlet NSPopUpButton *tagsSelector;
}

@property(readonly, nonatomic) NSMutableArray *tags;

- (IBAction)handlePopup:(id)sender;

@end
