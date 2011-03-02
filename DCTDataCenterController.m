//
//  DCTDataCenterController.m
//  DataCenter
//
//  Created by Daniel Tull on 2.03.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "DCTDataCenterController.h"
#import "DCTManagedObjectContextViewController.h"

@implementation DCTDataCenterController

@synthesize managedObjectContext;

#pragma mark - NSObject

- (void)dealloc {
	[managedObjectContext release], managedObjectContext = nil;
	[super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self resignFirstResponder];
}

#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder {
	return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	
	if (event.type == UIEventSubtypeMotionShake) {
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DataCenter"
														message:@"" 
													   delegate:self 
											  cancelButtonTitle:@"Cancel" 
											  otherButtonTitles:@"Open", nil];
		[alert show];
		[alert release];
	}
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if (buttonIndex == 1) {
		
		DCTManagedObjectContextViewController *mocvc = [[DCTManagedObjectContextViewController alloc] init];
		mocvc.managedObjectContext = self.managedObjectContext;
		mocvc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		
		UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss:)];
		mocvc.navigationItem.leftBarButtonItem = item;
		[item release];
		
		UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mocvc];
		[mocvc release];
		
		[self presentModalViewController:nav animated:YES];
		[nav release];
		
	}
}

- (IBAction)dismiss:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

@end
