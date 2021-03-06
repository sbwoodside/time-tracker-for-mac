//
//  TTDocument.h
//  Time Tracker
//
//  Created by Aaron VonderHaar on 7/5/08.
//  Copyright 2008 Aaron VonderHaar. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TProject.h"

@interface TTDocument : NSObject {
	NSMutableArray *_projects;
}

- (NSArray *) projects;
- (void) setProjects:(NSArray *)projs;
- (void) addProject:(TProject *)proj;
- (void) removeProject:(TProject *)proj;
- (id)objectInProjectsAtIndex:(int)index;
- (void)moveProject:(TProject *)proj toIndex:(int)index;

- (NSData *)dataOfType:(NSString *)aType error:(NSError **)outError;

@end
