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

@implementation DCTManagedObjectRelationshipsViewController {
	__strong NSArray *relatedObjects;
}

@synthesize managedObject, relationship;

- (id)init {
	return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)setManagedObject:(NSManagedObject *)mo {
	managedObject = mo;
	[self setupRelatedObjects];
}

- (void)setupRelatedObjects {
	
	if (!(self.managedObject) || !(self.relationship)) return;
	
	NSSet *ro = [self.managedObject valueForKey:[relationship name]];
	
	relatedObjects = [ro allObjects];
}

- (void)setRelationship:(NSRelationshipDescription *)r {
	relationship = r;
	
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
									   reuseIdentifier:CellIdentifier];
    
	cell.textLabel.text = [[relatedObjects objectAtIndex:indexPath.row] dct_niceDescription];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;	
	
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	DCTManagedObjectViewController *vc = [[DCTManagedObjectViewController alloc] init];
	vc.managedObject = [relatedObjects objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:vc animated:YES];
}

@end
