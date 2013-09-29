//
//  TransformArticle.h
//  wzdp
//
//  Created by valu on 13-9-25.
//  Copyright (c) 2013年 jundie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleDB.h"

@interface TransformArticle : NSObject
{
    
}

+ (NSString *)markLevelInArticleWithArticle:(NSString *)article andLevel:(NSInteger)level;
@end
