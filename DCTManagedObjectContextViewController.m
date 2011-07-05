//
//  DCTManagedObjectContextViewController.m
//  DCTCoreDataBrowser
//
//  Created by Daniel Tull on 23.02.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "DCTManagedObjectContextViewController.h"
#import "DCTManagedObjectViewController.h"
#import "NSManagedObject+DCTNiceDescription.h"

@implementation DCTManagedObjectContextViewController {
	__strong NSArray *entities;
	__strong NSMutableDictionary *fetchedEntities;
}

@synthesize managedObjectContext;

#pragma mark - NSObject

- (id)init {
	if (!(self = [self initWithStyle:UITableViewStyleGrouped])) return nil;
	
	self.title = @"Data Center";
	
	return self;
}

#pragma mark - DCTManagedObjectContextViewController

- (void)setManagedObjectContext:(NSManagedObjectContext *)moc {
	
	managedObjectContext = moc;
	
	entities = [[[self.managedObjectContext persistentStoreCoordinator] managedObjectModel] entities];
	
	fetchedEntities = [[NSMutableDictionary alloc] initWithCapacity:[entities count]];
	
	for (NSEntityDescription *entity in entities) {
		
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		[request setEntity:entity];
		NSArray *fetchResult = [managedObjectContext executeFetchRequest:request error:NULL];
		
		[fetchedEntities setObject:fetchResult forKey:[entity name]];
	}
	
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [entities count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [[entities objectAtIndex:section] name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[fetchedEntities objectForKey:[[entities objectAtIndex:section] name]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	NSEntityDescription *entity = [entities objectAtIndex:indexPath.section];
	NSArray *objects = [fetchedEntities objectForKey:[entity name]];
	NSManagedObject *mo = [objects objectAtIndex:indexPath.row];
	
	cell.textLabel.text = [mo dct_niceDescription];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSEntityDescription *entity = [entities objectAtIndex:indexPath.section];
	NSArray *objects = [fetchedEntities objectForKey:[entity name]];
	NSManagedObject *mo = [objects objectAtIndex:indexPath.row];
	
	DCTManagedObjectViewController *vc = [[DCTManagedObjectViewController alloc] init];
	vc.managedObject = mo;
	[self.navigationController pushViewController:vc animated:YES];
}

@end
