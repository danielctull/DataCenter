//
//  DCTManagedObjectContextViewController.h
//  DCTCoreDataBrowser
//
//  Created by Daniel Tull on 23.02.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DCTManagedObjectContextViewController : UITableViewController {
	NSArray *entities;
	NSMutableDictionary *fetchedEntities;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@end
