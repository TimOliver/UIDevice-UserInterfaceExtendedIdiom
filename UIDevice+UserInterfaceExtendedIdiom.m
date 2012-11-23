//
//  UIDevice+UserInterfaceExtendedIdiom.m
//
//  Created by Tim Oliver on 23/11/12.
//  Copyright (c) 2012 Timothy Oliver. All rights reserved.
//

#import "UIDevice+UserInterfaceExtendedIdiom.h"

#define IPHONE5_HEIGHT 568

@implementation UIDevice (UserInterfaceExtendedIdiom)

+ (void)load
{
    //This function swizzles these two methods. So when calling one by its name, the other will actually be called.
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
