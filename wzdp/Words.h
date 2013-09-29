//
//  Words.h
//  wzdp
//
//  Created by valu on 13-9-25.
//  Copyright (c) 2013年 jundie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Words : NSObject
{
    NSInteger wordsid;
    NSString *word;
    NSInteger wordLevel;
}
@property (nonatomic)NSInteger wordsid;
@property (nonatomic, retain)NSString *word;
@property (nonatomic)NSInteger wordLevel;

@end
