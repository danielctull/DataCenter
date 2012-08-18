//
//  DCTDataCenterController.h
//  DataCenter
//
//  Created by Daniel Tull on 2.03.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCTDataCenterController : UINavigationController

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

@end
