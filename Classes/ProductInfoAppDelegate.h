//
//  ProductInfoAppDelegate.h
//  ProductInfo
//
//  Created by P. Mark Anderson on 10/26/10.
//  Copyright 2010 Digimarc Corporation, USA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductInfoViewController;

@interface ProductInfoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ProductInfoViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ProductInfoViewController *viewController;

@end

