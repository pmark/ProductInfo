//
//  ProductInfoViewController.h
//  ProductInfo
//
//  Created by P. Mark Anderson on 10/26/10.
//  Copyright 2010 Bordertown Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductInfo.h"

@interface ProductInfoViewController : UIViewController <ProductInfoDelegate> 
{
	ProductInfo *productInfo;
}

@property (nonatomic, retain) ProductInfo *productInfo;

@end

