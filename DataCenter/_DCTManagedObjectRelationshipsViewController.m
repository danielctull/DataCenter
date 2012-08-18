//
//  DCTManagedObjectRelationshipsViewController.m
//  DCTCoreDataBrowser
//
//  Created by Daniel Tull on 23.02.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "_DCTManagedObjectRelationshipsViewController.h"
#import "DCTManagedObjectViewController.h"
#import "NSManagedObject+DCTNiceDescription.h"

@implementation _DCTManagedObjectRelationshipsViewController {
	__strong NSArray *_relatedObjects;
}

- (id)initWithManagedObject:(NSManagedObject *)managedObject relationship:(NSRelationshipDescription *)relationship {
	
	self = [self initWithStyle:UITableViewStyleGrouped];
	if (!self) return nil;
	
	_managedObject = managedObject;
	_relationship = relationship;
	self.title = [_relationship name];
	
	NSSet *ro = [self.managedObject valueForKey:[relationship name]];
	_relatedObjects = [ro allObjects];
	
	return self;	
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_relatedObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (!(cell))
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
									   reuseIdentifier:CellIdentifier];
    
	cell.textLabel.text = [[_relatedObjects objectAtIndex:indexPath.row] dct_niceDescription];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;	
	
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    
	NSManagedObject *managedObject = [_relatedObjects objectAtIndex:indexPath.row];
	DCTManagedObjectViewController *vc = [[DCTManagedObjectViewController alloc] initWithManagedObject:managedObject];
	[self.navigationController pushViewController:vc animated:YES];
}

@end
