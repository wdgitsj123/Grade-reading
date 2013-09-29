//
//  ContentTextView.m
//  wzdp
//
//  Created by valu on 13-9-23.
//  Copyright (c) 2013年 jundie. All rights reserved.
//

#import "ContentTextView.h"

@implementation ContentTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        self.multipleTouchEnabled = YES;
        self.editable = NO;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //NSLog(@"TouchView touchesBegan");
    [self.nextResponder touchesBegan:touches withEvent:event];
}

@end
