//
//  DCTManagedObjectContextViewController.m
//  DCTCoreDataBrowser
//
//  Created by Daniel Tull on 23.02.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "_DCTManagedObjectContextViewController.h"
#import "DCTManagedObjectViewController.h"
#import "NSManagedObject+DCTNiceDescription.h"

@implementation _DCTManagedObjectContextViewController {
	__strong NSArray *_entities;
	__strong NSMutableDictionary *_fetchedEntities;
}

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
	self = [self initWithStyle:UITableViewStyleGrouped];
	if (!self) return nil;
	
	self.title = @"Data Center";
	
	_managedObjectContext = managedObjectContext;
	
	_entities = [[[_managedObjectContext persistentStoreCoordinator] managedObjectModel] entities];
	
	_fetchedEntities = [[NSMutableDictionary alloc] initWithCapacity:[_entities count]];
	
	[_entities enumerateObjectsUsingBlock:^(NSEntityDescription *entity, NSUInteger i, BOOL *stop) {
		
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		[request setEntity:entity];
		NSArray *fetchResult = [managedObjectContext executeFetchRequest:request error:NULL];
		
		[_fetchedEntities setObject:fetchResult forKey:[entity name]];
	}];
	
	return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_entities count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [[_entities objectAtIndex:section] name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_fetchedEntities objectForKey:[[_entities objectAtIndex:section] name]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	NSEntityDescription *entity = [_entities objectAtIndex:indexPath.section];
	NSArray *objects = [_fetchedEntities objectForKey:[entity name]];
	NSManagedObject *managedObject = [objects objectAtIndex:indexPath.row];
	
	cell.textLabel.text = [managedObject dct_niceDescription];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSEntityDescription *entity = [_entities objectAtIndex:indexPath.section];
	NSArray *objects = [_fetchedEntities objectForKey:[entity name]];
	NSManagedObject *managedObject = [objects objectAtIndex:indexPath.row];
	
	DCTManagedObjectViewController *vc = [[DCTManagedObjectViewController alloc] initWithManagedObject:managedObject];
	[self.navigationController pushViewController:vc animated:YES];
}

@end
