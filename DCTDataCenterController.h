//
//  DCTDataCenterController.h
//  DataCenter
//
//  Created by Daniel Tull on 2.03.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCTDataCenterController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (IBAction)dismiss:(id)sender;

@end
