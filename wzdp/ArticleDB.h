//
//  ArticleDB.h
//  wzdp
//
//  Created by valu on 13-9-21.
//  Copyright (c) 2013年 jundie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ArticleIndex.h"
#import "ArticleContent.h"
#import "Words.h"

@interface ArticleDB : NSObject

+ (NSMutableArray *)selectTable;
+ (ArticleContent *)fetchArticleContent: (NSInteger)indexid;
+ (ArticleContent *)fetchContent: (NSInteger)indexid;
+ (NSMutableArray *)fetchWords: (NSInteger)indexid;
@end
