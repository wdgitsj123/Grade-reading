//
//  ArticleContent.m
//  wzdp
//
//  Created by valu on 13-9-21.
//  Copyright (c) 2013年 jundie. All rights reserved.
//

#import "ArticleContent.h"

@implementation ArticleContent
@synthesize contentid;
@synthesize contenttext;
@synthesize articleIndex;

- (NSString *)description
{
	NSString *desc  = [NSString stringWithFormat:@"ArticleContent\nid is: %i, \ntext is %@, \nindex is %@", contentid, contenttext, articleIndex];
	
	return desc;
}

- (void)dealloc
{
	[contenttext release];
    [articleIndex release];
    
    [super dealloc];
}

@end
