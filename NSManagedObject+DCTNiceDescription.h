//
//  NSManagedObject+DCTNiceDescription.h
//  DCTCoreDataBrowser
//
//  Created by Daniel Tull on 23.02.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NSManagedObject (DCTNiceDescription)

- (NSString *)dct_niceDescription;

@end
