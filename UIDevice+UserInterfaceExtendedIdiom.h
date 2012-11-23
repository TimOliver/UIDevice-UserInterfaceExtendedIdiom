//
//  UIDevice+UserInterfaceExtendedIdiom.h
//
//  Created by Tim Oliver on 23/11/12.
//  Copyright (c) 2012 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    UIUserInterfaceIdiomPhone5 = 1000 //At 1000, hopefully this won't conflict with any possible future Apple UI idioms
} UIUserInterfaceIdiomExtended;

@interface UIDevice (UserInterfaceExtendedIdiom)

- (UIUserInterfaceIdiom)userInterfaceExtendedIdiom;

@end
