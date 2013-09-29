//
//  UIScrollView+UITouch.m
//  wzdp
//
//  Created by valu on 13-9-26.
//  Copyright (c) 2013年 jundie. All rights reserved.
//

#import "UIScrollView+UITouch.h"

@implementation UIScrollView (UITouch)


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
    //[super touchesBegan:touches withEvent:event];
}

@end
