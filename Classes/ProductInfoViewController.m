//
//  ProductInfoViewController.m
//  ProductInfo
//
//  Created by P. Mark Anderson on 10/26/10.
//  Copyright 2010 Digimarc Corporation, USA. All rights reserved.
//

#import "ProductInfoViewController.h"

@implementation ProductInfoViewController

@synthesize productInfo;


- (void)dealloc 
{
    [productInfo release];
    [super dealloc];
}

- (void) fetchProductInfo:(NSString *)ean
{
    self.productInfo = [[[ProductInfo alloc] init] autorelease];
    productInfo.delegate = self;
    [productInfo fetchProductInfo:ean];    
}

- (void) productDescriptionWasFetched:(NSString *)description
{
	NSLog(@"description: %@", description);
    [productInfo release];
}

- (void) viewDidLoad 
{
    [super viewDidLoad];
	[self fetchProductInfo:@"0850613001013"];
}

@end
