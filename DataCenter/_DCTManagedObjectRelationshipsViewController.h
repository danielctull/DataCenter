//
//  DCTManagedObjectRelationshipsViewController.h
//  DCTCoreDataBrowser
//
//  Created by Daniel Tull on 23.02.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface _DCTManagedObjectRelationshipsViewController : UITableViewController

- (id)initWithManagedObject:(NSManagedObject *)managedObject relationship:(NSRelationshipDescription *)relationship;

@property (nonatomic, strong, readonly) NSManagedObject *managedObject;
@property (nonatomic, strong, readonly) NSRelationshipDescription *relationship;

@end
