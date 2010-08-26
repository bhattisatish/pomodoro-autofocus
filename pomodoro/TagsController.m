//
//  TagsController.m
//  pomodoro
//
//  Created by Giordano Scalzo on 8/26/10.
//  Copyright 2010 CleanCode. All rights reserved.
//

#import "TagsController.h"


@implementation TagsController
@synthesize tags;

-(void)observeUserDefault:(NSString*) property{
	
	[[NSUserDefaults standardUserDefaults] addObserver:self
											forKeyPath:property
											   options:(NSKeyValueObservingOptionNew |
														NSKeyValueObservingOptionOld)
											   context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
	tags = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"pomodoroTags"] mutableCopy];
	[tagsSelector removeAllItems];
	
	NSUInteger i, count = [tags count];
	for (i = 0; i < count; i++) {
		NSString * tag = [tags objectAtIndex:i];
		[tagsSelector insertItemWithTitle:tag atIndex:i];
	}
	
	[self setTag:[tags objectAtIndex:0]];
}

- (void)setTag:(NSString *)currentTag{
	[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithString:currentTag] forKey:@"currentTag"];
	
	NSLog(@"currentTag [%@]", currentTag);
}

- (IBAction)handlePopup:(id)sender {
	NSString *currentTag = [sender titleOfSelectedItem];
	[self setTag:currentTag];
}

- (id) init {
	self = [super init];
	if (self != nil) {
		tags = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"pomodoroTags"] mutableCopy];
		[self observeUserDefault:@"pomodoroTags"];
		
		[self setTag:[tags objectAtIndex:0]];
	}
	return self;
}


- (void) dealloc {
	[tags release];
	[super dealloc];
}


@end
