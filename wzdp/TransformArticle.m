//
//  TransformArticle.m
//  wzdp
//
//  Created by valu on 13-9-25.
//  Copyright (c) 2013年 jundie. All rights reserved.
//

#import "TransformArticle.h"

@implementation TransformArticle

+ (NSString *)markLevelInArticleWithArticle:(NSString *)article andLevel:(NSInteger)level
{
    NSLog(@"%d", level);
    
    NSMutableArray *wordsArray = [NSMutableArray array];
    wordsArray = [ArticleDB fetchWords:level];
    
    //NSLog(@"wordsArray : %@", wordsArray);
    
    //NSString *szReplaced = [article stringByReplacingOccurrencesOfString:[wordsArray] withString:@" <color>is"];  //匹配字符串替换
    //NSLog(@"%@",szReplaced);
    
    for (NSMutableString *string in wordsArray) {
        article = [article stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@" %@ ", string] withString:[NSString stringWithFormat:@" <colored>%@</colored> ", string]];
    }
    NSLog(@"TransformArticle : %@", article);
    return article;
}

@end
