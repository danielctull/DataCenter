//
//  DCTDataCenterController.h
//  DataCenter
//
//  Created by Daniel Tull on 2.03.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "DCTContentViewController.h"


@interface DCTDataCenterController : DCTContentViewController {}
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
- (IBAction)dismiss:(id)sender;
@end
