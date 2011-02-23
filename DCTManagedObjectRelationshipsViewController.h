//
//  DCTManagedObjectRelationshipsViewController.h
//  DCTCoreDataBrowser
//
//  Created by Daniel Tull on 23.02.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface DCTManagedObjectRelationshipsViewController : UITableViewController {
	NSArray *relatedObjects;
}

@property (nonatomic, retain) NSManagedObject *managedObject;
@property (nonatomic, retain) NSRelationshipDescription *relationship;

@end
