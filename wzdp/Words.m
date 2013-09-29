//
//  Words.m
//  wzdp
//
//  Created by valu on 13-9-25.
//  Copyright (c) 2013年 jundie. All rights reserved.
//

#import "Words.h"

@implementation Words
@synthesize wordsid;
@synthesize word;
@synthesize wordLevel;

- (NSString *)description
{
	NSString *desc  = [NSString stringWithFormat:@"Words\nid is: %d, \ntitle_en is %@, \ntitle_cn is %d", wordsid, word, wordLevel];
	
	return desc;
}

- (void)dealloc
{
	[word release];
    [super dealloc];
}
@end
