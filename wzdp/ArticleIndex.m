//
//  ArticleIndex.m
//  wzdp
//
//  Created by valu on 13-9-21.
//  Copyright (c) 2013年 jundie. All rights reserved.
//

#import "ArticleIndex.h"

@implementation ArticleIndex
@synthesize indexid;
@synthesize title_cn;
@synthesize title_en;
@synthesize question;

- (NSString *)description
{
	NSString *desc  = [NSString stringWithFormat:@"ArticleIndex\nid is: %i, \ntitle_en is %@, \ntitle_cn is %@, \nquestion is %@", indexid, title_en, title_cn, question];
	
	return desc;
}

- (void)dealloc
{
	[title_en release];
    [title_cn release];
    [question release];
    
    [super dealloc];
}
@end
