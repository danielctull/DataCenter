//
//  AppDelegate.m
//  DataCenter Demo
//
//  Created by Daniel Tull on 18.08.2012.
//  Copyright (c) 2012 Daniel Tull. All rights reserved.
//

#import "AppDelegate.h"
#import <DataCenter/DataCenter.h>
#import <DCTCoreDataStack/DCTCoreDataStack.h>
#import <SampleCoreData/SampleCoreData.h>

@implementation AppDelegate {
	__strong DCTCoreDataStack *coreDataStack;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
	
	coreDataStack = [[DCTCoreDataStack alloc] initWithStoreURL:[SampleCoreData storeURL]
													 storeType:[SampleCoreData storeType]
												  storeOptions:nil
											modelConfiguration:nil
													  modelURL:[SampleCoreData modelURL]];
	
	self.window.rootViewController = [[DCTDataCenterController alloc] initWithManagedObjectContext:coreDataStack.managedObjectContext];
	
	
    [self.window makeKeyAndVisible];
    return YES;
}

@end
