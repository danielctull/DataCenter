//
//  DCTManagedObjectContextViewController.h
//  DCTCoreDataBrowser
//
//  Created by Daniel Tull on 23.02.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface _DCTManagedObjectContextViewController : UITableViewController
- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@end
