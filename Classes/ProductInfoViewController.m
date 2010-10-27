//
//  ProductInfoViewController.m
//  ProductInfo
//
//  Created by P. Mark Anderson on 10/26/10.
//  Copyright 2010 Digimarc Corporation, USA. All rights reserved.
//

#import "ProductInfoViewController.h"

@implementation ProductInfoViewController

- (void) fetchProductInfo:(NSString *)ean
{
    ProductInfo *productInfo = [[ProductInfo alloc] init];
    productInfo.delegate = self;
    [productInfo fetchProductInfo:ean];    
    [productInfo release];
}

- (void) productDescriptionWasFetched:(NSString *)description
{
	NSLog(@"description: %@", description);
}

- (void) viewDidLoad 
{
    [super viewDidLoad];
	[self fetchProductInfo:@"0850613001013"];
}

- (void)dealloc 
{
    [super dealloc];
}

@end
