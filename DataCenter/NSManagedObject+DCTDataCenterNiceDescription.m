//
//  NSManagedObject+DCTDataCenterNiceDescription.m
//  DataCenter
//
//  Created by Daniel Tull on 23.02.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "NSManagedObject+DCTDataCenterNiceDescription.h"


@implementation NSManagedObject (DCTDataCenterNiceDescription)

- (NSString *)dctDataCenter_niceDescription {
	
	NSEntityDescription *entity = [self entity];
	
	NSMutableString *string = [NSMutableString string];
	
	NSArray *attributeNames = [[entity attributesByName] allKeys];
	
	NSString *lastName = [attributeNames lastObject];
	
	for (NSString *attributeName in attributeNames) {
		
		id value = [self valueForKey:attributeName];
		
		if ((value)) {
			[string appendString:[value description]];
			
			if (![attributeName isEqual:lastName]) 
				[string appendString:@", "];
			
		}
	}
	return string;
}

@end
