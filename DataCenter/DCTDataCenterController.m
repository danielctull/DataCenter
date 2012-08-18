//
//  DCTDataCenterController.m
//  DataCenter
//
//  Created by Daniel Tull on 2.03.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "DCTDataCenterController.h"
#import "DCTManagedObjectContextViewController.h"

@implementation DCTDataCenterController

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
	
	DCTManagedObjectContextViewController *vc = [DCTManagedObjectContextViewController new];
	vc.managedObjectContext = managedObjectContext;
	
	self = [self initWithRootViewController:vc];
	if (!self) return nil;
	_managedObjectContext = managedObjectContext;
	return self;
}

@end
