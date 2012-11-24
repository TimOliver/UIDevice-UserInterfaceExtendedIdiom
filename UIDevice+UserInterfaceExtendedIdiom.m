//
//  UIDevice+UserInterfaceExtendedIdiom.m
//
//  Created by Tim Oliver on 23/11/12.
//  Copyright (c) 2012 Timothy Oliver. All rights reserved.
//

#import "UIDevice+UserInterfaceExtendedIdiom.h"
#import <objc/runtime.h>

#define IPHONE5_HEIGHT 568

@implementation UIDevice (UserInterfaceExtendedIdiom)

+ (void)load
{
    // Swizzle userInterfaceIdiom and userInterfaceExendedIdiom.  First, we defensively check
    // that both methods exist AND copy them into the current class in case they are implemented
    // by a superclass.  This is unlikely (particularly in the case of our added method) but
    // better to be safe than sorry.

    Method origMethod = class_getInstanceMethod(self, @selector(userInterfaceIdiom));
    if (!origMethod) return;
    
    Method altMethod = class_getInstanceMethod(self, @selector(userInterfaceExtendedIdiom));
    if (!altMethod) return;
        
    class_addMethod(
        self,
        @selector(userInterfaceIdiom),
        class_getMethodImplementation(self, @selector(userInterfaceIdiom)),
        method_getTypeEncoding(origMethod)
    );
	
    class_addMethod(
        self,
        @selector(userInterfaceExtendedIdiom),
        class_getMethodImplementation(self, @selector(userInterfaceExtendedIdiom)),
        method_getTypeEncoding(altMethod)
    );

    method_exchangeImplementations(
        class_getInstanceMethod(self, @selector(userInterfaceIdiom)),
        class_getInstanceMethod(self, @selector(userInterfaceExtendedIdiom))
    );
}

- (UIUserInterfaceIdiom)userInterfaceExtendedIdiom
{
    //call the original Apple method to determine the current UI idiom
    UIUserInterfaceIdiom interfaceIdiom = [self userInterfaceExtendedIdiom];
    
    //if it's not iPad, subject it to further scrutiny
    if( interfaceIdiom == UIUserInterfaceIdiomPhone )
    {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        NSInteger screenHeight = (NSInteger)(MAX(screenSize.width,screenSize.height)); //Make sure we're getting the physical height, regardless of orientation
        
        if( screenHeight == IPHONE5_HEIGHT )
            return UIUserInterfaceIdiomPhone5;
    }
    
    return interfaceIdiom;
}

@end
