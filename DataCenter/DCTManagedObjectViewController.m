//
//  DCTManagedObjectViewController.m
//  DCTCoreDataBrowser
//
//  Created by Daniel Tull on 23.02.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "DCTManagedObjectViewController.h"
#import "_DCTManagedObjectRelationshipsViewController.h"
#import "NSManagedObject+DCTNiceDescription.h"

NSInteger const DCTManagedObjectViewControllerAttributeSection = 1;
NSInteger const DCTManagedObjectViewControllerRelationshipSection = 2;

@interface DCTManagedObjectViewController ()
@end

@implementation DCTManagedObjectViewController {
	__strong NSArray *_relationships;
	__strong NSArray *_attributes;
}

- (id)initWithManagedObject:(NSManagedObject *)managedObject {
	
	self = [self initWithStyle:UITableViewStyleGrouped];
	if (!self) return nil;
	
	_managedObject = managedObject;
	
	NSEntityDescription *entity = [managedObject entity];
	self.title = [entity name];
	_relationships = [[entity relationshipsByName] allKeys];
	_attributes = [[entity attributesByName] allKeys];
	
	return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if (section == DCTManagedObjectViewControllerAttributeSection)
		return [_attributes count];
	
	if (section == DCTManagedObjectViewControllerRelationshipSection)
		return [_relationships count];
	
    return 0;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	if (section == DCTManagedObjectViewControllerAttributeSection)
		return @"Attributes";
	
	if (section == DCTManagedObjectViewControllerRelationshipSection)
		return @"Relationships";
	
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	static NSString *AttributeIdentifier = @"AttributeIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AttributeIdentifier];
	
	if (cell == nil)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:AttributeIdentifier];
	
	
	if ((NSInteger)indexPath.section == DCTManagedObjectViewControllerAttributeSection) {
		
		NSString *attributeName = [_attributes objectAtIndex:indexPath.row];
		
		cell.textLabel.text = attributeName;
		cell.detailTextLabel.text = [[self.managedObject valueForKey:attributeName] description];
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	if ((NSInteger)indexPath.section == DCTManagedObjectViewControllerRelationshipSection) {
		
		NSString *relationshipName = [_relationships objectAtIndex:indexPath.row];
		
		cell.textLabel.text = relationshipName;
		
		NSRelationshipDescription *relationship = [[[self.managedObject entity] relationshipsByName] objectForKey:relationshipName];
		
		if ([relationship isToMany])
			cell.detailTextLabel.text = [NSString stringWithFormat:@"Many %@s", [[relationship destinationEntity] name]];
		else
			cell.detailTextLabel.text = [[self.managedObject valueForKey:relationshipName] dct_niceDescription];
		
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if ((NSInteger)indexPath.section == DCTManagedObjectViewControllerRelationshipSection) {
		
		NSString *relationshipName = [_relationships objectAtIndex:indexPath.row];
		
		NSRelationshipDescription *relationship = [[[self.managedObject entity] relationshipsByName] objectForKey:relationshipName];
		
		if (![relationship isToMany]) {
			
			NSManagedObject *managedObject = [self.managedObject valueForKey:relationshipName];
			DCTManagedObjectViewController *vc = [[DCTManagedObjectViewController alloc] initWithManagedObject:managedObject];
			[self.navigationController pushViewController:vc animated:YES];
			
		} else {
			
			_DCTManagedObjectRelationshipsViewController *vc = [[_DCTManagedObjectRelationshipsViewController alloc] initWithManagedObject:self.managedObject relationship:relationship];
			[self.navigationController pushViewController:vc animated:YES];
			
			
		}
		
	}
	
}

@end
