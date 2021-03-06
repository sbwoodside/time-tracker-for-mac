//
//  TTDocument.m
//  Time Tracker
//
//  Created by Aaron VonderHaar on 7/5/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "TTDocument.h"


@implementation TTDocument

- (id) init
{
	_projects = [[NSMutableArray alloc] init];
	return self;
}

- (NSArray *) projects
{
	return _projects;
}

- (void) setProjects:(NSArray *)projs
{
	_projects = [[NSMutableArray alloc] initWithArray:projs];
}

- (void) addProject:(TProject *)proj
{
	[_projects addObject:proj];
}

- (void) removeProject:(TProject *)proj
{
	[_projects removeObject:proj];
}

- (id)objectInProjectsAtIndex:(int)index
{
	return [_projects objectAtIndex:index];
}

- (void)moveProject:(TProject *)proj toIndex:(int)index
{
	int oldIndex = [_projects indexOfObject:proj];
	if (oldIndex == NSNotFound)
	{
		NSLog(@"TTDocument moveProject:toIndex: project was not found in the projects lists");
		return;
	}
	
	[_projects insertObject:proj atIndex:index];
	if (oldIndex >= index) oldIndex++;
	[_projects removeObjectAtIndex:oldIndex];
}

- (NSData *)dataOfType:(NSString *)aType error:(NSError **)outError
{
	NSMutableData* data = [[[NSMutableData alloc] init] autorelease];
	
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc]
		initWithDateFormat:@"%Y-%m-%d" allowNaturalLanguage:NO];
	NSDateFormatter *timeFormat = [[NSDateFormatter alloc]
		initWithDateFormat:@"%H:%M" allowNaturalLanguage:NO];
	
	// Write the CSV column headers
	[data appendData:[@"Date,Start time,End time,Duration (seconds),Project,Task\n" dataUsingEncoding:NSASCIIStringEncoding]];

	NSEnumerator *proje = [_projects objectEnumerator];
	TProject *proj;
	while ( proj = [proje nextObject] )
	{
		NSEnumerator *taske = [[proj tasks] objectEnumerator];
		TTask *task;
		while (task = [taske nextObject])
		{
			NSEnumerator *wpe = [[task workPeriods] objectEnumerator];
			TWorkPeriod *wp;
			while (wp = [wpe nextObject])
			{
				// Date
				[data appendData:[[dateFormat stringFromDate:[wp startTime]] dataUsingEncoding:NSASCIIStringEncoding]];
				[data appendData:[@"," dataUsingEncoding:NSASCIIStringEncoding]];
				// Start time
				[data appendData:[[timeFormat stringFromDate:[wp startTime]] dataUsingEncoding:NSASCIIStringEncoding]];
				[data appendData:[@"," dataUsingEncoding:NSASCIIStringEncoding]];
				// End time
				[data appendData:[[timeFormat stringFromDate:[wp endTime]] dataUsingEncoding:NSASCIIStringEncoding]];
				[data appendData:[@"," dataUsingEncoding:NSASCIIStringEncoding]];
				
				// Duration (seconds)
				[data appendData:[[NSString stringWithFormat:@"%d", [wp totalTime]] dataUsingEncoding:NSASCIIStringEncoding]];
				[data appendData:[@"," dataUsingEncoding:NSASCIIStringEncoding]];
				
				// Project
				[data appendData:[[proj name] dataUsingEncoding:NSASCIIStringEncoding]];
				[data appendData:[@"," dataUsingEncoding:NSASCIIStringEncoding]];
				// Task
				[data appendData:[[task name] dataUsingEncoding:NSASCIIStringEncoding]];
				[data appendData:[@"\n" dataUsingEncoding:NSASCIIStringEncoding]];
			}
		}
		
	}
	
	[dateFormat release];
	[timeFormat release];

    return data;
}


@end

// This initialization function gets called when we import the Ruby module.
// It doesn't need to do anything because the RubyCocoa bridge will do
// all the initialization work.
// The rbiphonetest test framework automatically generates bundles for 
// each objective-c class containing the following line. These
// can be used by your tests.
void Init_TTDocument() { }
