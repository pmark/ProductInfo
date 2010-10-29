//
//  ProductInfo.h
//  ProductInfo
//
//  Created by P. Mark Anderson on 10/26/10.
//  Copyright 2010 Bordertown Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLRPC.h"

@protocol ProductInfoDelegate
- (void) productDescriptionWasFetched:(NSString *)description;
@end


@interface ProductInfo : NSObject <XMLRPCConnectionDelegate> 
{
	id<ProductInfoDelegate> delegate;
}

@property (nonatomic, assign) id<ProductInfoDelegate> delegate;

- (void) fetchProductInfo:(NSString *)ean;

@end
