//
//  DCTManagedObjectViewController.m
//  DCTCoreDataBrowser
//
//  Created by Daniel Tull on 23.02.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "DCTManagedObjectViewController.h"
#import "DCTManagedObjectRelationshipsViewController.h"
#import "NSManagedObject+DCTNiceDescription.h"

NSInteger const DCTManagedObjectViewControllerAttributeSection = 1;
NSInteger const DCTManagedObjectViewControllerRelationshipSection = 2;

@interface DCTManagedObjectViewController ()
@end

@implementation DCTManagedObjectViewController {
	__strong NSArray *relationships;
	__strong NSArray *attributes;
}

@synthesize managedObject;

#pragma mark - NSObject

- (id)init {
	return [self initWithStyle:UITableViewStyleGrouped];
}

#pragma mark - DCTManagedObjectViewController

- (void)setManagedObject:(NSManagedObject *)mo {
	managedObject = mo;
	
	NSEntityDescription *entity = [managedObject entity];
	
	self.title = [entity name];
	
	relationships = [[entity relationshipsByName] allKeys];
	
	attributes = [[entity attributesByName] allKeys];
	
	if ([self isViewLoaded])
		[self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if (section == DCTManagedObjectViewControllerAttributeSection)
		return [attributes count];
	
	if (section == DCTManagedObjectViewControllerRelationshipSection)
		return [relationships count];
	
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
		
		NSString *attributeName = [attributes objectAtIndex:indexPath.row];
		
		cell.textLabel.text = attributeName;
		cell.detailTextLabel.text = [[managedObject valueForKey:attributeName] description];
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	if ((NSInteger)indexPath.section == DCTManagedObjectViewControllerRelationshipSection) {
		
		NSString *relationshipName = [relationships objectAtIndex:indexPath.row];
		
		cell.textLabel.text = relationshipName;
		
		NSRelationshipDescription *relationship = [[[self.managedObject entity] relationshipsByName] objectForKey:relationshipName];
		
		if ([relationship isToMany])
			cell.detailTextLabel.text = [NSString stringWithFormat:@"Many %@s", [[relationship destinationEntity] name]];
		else
			cell.detailTextLabel.text = [[managedObject valueForKey:relationshipName] dct_niceDescription];
		
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if ((NSInteger)indexPath.section == DCTManagedObjectViewControllerRelationshipSection) {
		
		NSString *relationshipName = [relationships objectAtIndex:indexPath.row];
		
		NSRelationshipDescription *relationship = [[[self.managedObject entity] relationshipsByName] objectForKey:relationshipName];
		
		if (![relationship isToMany]) {
			
			NSManagedObject *mo = [managedObject valueForKey:relationshipName];
			
			DCTManagedObjectViewController *vc = [[DCTManagedObjectViewController alloc] init];
			vc.managedObject = mo;
			[self.navigationController pushViewController:vc animated:YES];
			
		} else {
			
			DCTManagedObjectRelationshipsViewController *vc = [[DCTManagedObjectRelationshipsViewController alloc] init];
			vc.managedObject = self.managedObject;
			vc.relationship = relationship;
			[self.navigationController pushViewController:vc animated:YES];
			
			
		}
		
	}
	
}

@end
