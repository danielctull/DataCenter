//
//  NSManagedObject+DCTNiceDescription.m
//  DCTCoreDataBrowser
//
//  Created by Daniel Tull on 23.02.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "NSManagedObject+DCTNiceDescription.h"


@implementation NSManagedObject (DCTNiceDescription)

- (NSString *)dct_niceDescription {
	
	NSEntityDescription *entity = [self entity];
	
	NSMutableString *string = [NSMutableString string];
	
	for (id property in [[entity attributesByName] allKeys]) {
		
		id value = [self valueForKey:property];
		
		if ((value))		
			[string appendFormat:@"%@, ", value];
	}
	return string;
}

@end
