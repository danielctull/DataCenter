//
//  DataCenterAppDelegate.m
//  DataCenter
//
//  Created by Daniel Tull on 23.02.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "DataCenterAppDelegate.h"
#import "DCTManagedObjectContextViewController.h"
#import "DCTDataCenterController.h"
#import "TestViewController.h"

@interface DataCenterAppDelegate ()
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@end

@implementation DataCenterAppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	TestViewController *tvc = [[TestViewController alloc] init];
	DCTDataCenterController *dcc = [[DCTDataCenterController alloc] initWithViewController:tvc];
	dcc.managedObjectContext = self.managedObjectContext;
	[tvc release];
	
	self.window.rootViewController = dcc;
	[dcc release];
	
	[self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc {
	[window release], window = nil;
    [super dealloc];
}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext {
	
	NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles: nil];
	
	NSString *applicationDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	
	NSString *defaultStorePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"SampleCoreData"
																				  ofType:@"sqlite"];
	
	NSString *storePath = [applicationDocumentsDirectory stringByAppendingPathComponent: @"SampleCoreData.sqlite"];
	
	NSError *error;
	if (![[NSFileManager defaultManager] fileExistsAtPath:storePath]) {
		if ([[NSFileManager defaultManager] copyItemAtPath:defaultStorePath toPath:storePath error:&error])
			NSLog(@"Copied starting data to %@", storePath);
		else 
			NSLog(@"Error copying default DB to %@ (%@)", storePath, error);
	}
	
	NSURL *storeURL = [NSURL fileURLWithPath:storePath];
	
	NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
	
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
							 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
							 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
	
	if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
												  configuration:nil
															URL:storeURL
														options:options
														  error:&error]) {
		
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] init];
    [managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
	[persistentStoreCoordinator release];
	
	return [managedObjectContext autorelease];	
}

@end
