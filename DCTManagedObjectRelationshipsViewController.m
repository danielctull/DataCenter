//
//  DCTManagedObjectRelationshipsViewController.m
//  DCTCoreDataBrowser
//
//  Created by Daniel Tull on 23.02.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "DCTManagedObjectRelationshipsViewController.h"
#import "DCTManagedObjectViewController.h"
#import "NSManagedObject+DCTNiceDescription.h"

@interface DCTManagedObjectRelationshipsViewController ()
- (void)setupRelatedObjects;
@end

@implementation DCTManagedObjectRelationshipsViewController

@synthesize managedObject, relationship;

- (id)init {
	return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)dealloc {
	[relatedObjects release], relatedObjects = nil;
	[managedObject release], managedObject = nil;
	[relationship release], relationship = nil;
    [super dealloc];
}

- (void)setManagedObject:(NSManagedObject *)mo {
	
	NSManagedObject *oldManagedObject = managedObject;
	managedObject = [mo retain];
	[oldManagedObject release];
	
	[self setupRelatedObjects];
}

- (void)setupRelatedObjects {
	
	if (!(self.managedObject) || !(self.relationship)) return;
	
	NSSet *ro = [self.managedObject valueForKey:[relationship name]];
	
	[relatedObjects release];
	relatedObjects = [[ro allObjects] retain];
}

- (void)setRelationship:(NSRelationshipDescription *)r {
	
	NSRelationshipDescription *old = relationship;
	relationship = [r retain];
	[old release];
	
	self.title = [relationship name];
	
	[self setupRelatedObjects];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [relatedObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (!(cell))
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
									   reuseIdentifier:CellIdentifier] autorelease];
    
	cell.textLabel.text = [[relatedObjects objectAtIndex:indexPath.row] dct_niceDescription];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;	
	
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	DCTManagedObjectViewController *vc = [[DCTManagedObjectViewController alloc] init];
	vc.managedObject = [relatedObjects objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
}

@end
