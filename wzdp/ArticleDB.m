//
//  ArticleDB.m
//  wzdp
//
//  Created by valu on 13-9-21.
//  Copyright (c) 2013年 jundie. All rights reserved.
//

#import "ArticleDB.h"

@implementation ArticleDB

+ (NSMutableArray *)selectTable
{
    sqlite3 *sqlite = nil;
    sqlite3_stmt *stmt = nil;
    
    //    NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/data.sqlite"];
    
    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"data.sqlite3"];
    
    //打开数据库
    int result = sqlite3_open([filePath UTF8String], &sqlite);
    if (result != SQLITE_OK) {
        NSLog(@"打开数据库失败");
        return nil;
    }
    
    //NSString *sql = @"SELECT username,password,email FROM USER WHERE username=?";
    NSString *sql = @"SELECT indexid,title_en,title_cn,question FROM article_list";
    
    //编译SQL语句
    sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &stmt, NULL);
    NSMutableArray *indexes = [NSMutableArray array];
    
    //查询数据
    result = sqlite3_step(stmt);
    while (result == SQLITE_ROW)
    {
        ArticleIndex *articleIndex = [[ArticleIndex alloc] init];
        
        articleIndex.indexid = sqlite3_column_int(stmt, 0);
        articleIndex.title_en = [NSString stringWithUTF8String: (char *)sqlite3_column_text(stmt, 1) ];
        articleIndex.title_cn = [NSString stringWithUTF8String: (char *)sqlite3_column_text(stmt, 2) ];
        articleIndex.question = [NSString stringWithUTF8String: (char *)sqlite3_column_text(stmt, 3) ];
        
        //NSLog(@"indexid：%d,title_en：%@, title_cn：%@, question: %@", articleIndex.indexid, articleIndex.title_en, articleIndex.title_cn, articleIndex.question);
        
        [indexes addObject:articleIndex];
        [articleIndex release];
        
        result = sqlite3_step(stmt);
    }
    
    //关闭数据库句柄
    sqlite3_finalize(stmt);
    
    //关闭数据库
    sqlite3_close(sqlite);
    //NSLog(@"indexs : %@", indexes);
    return indexes;
}

+ (ArticleContent *)fetchArticleContent: (NSInteger)indexid
{    
    sqlite3 *sqlite = nil;
    sqlite3_stmt *stmt = nil;
    
    //    NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/data.sqlite"];
    
    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"data.sqlite3"];
    
    //打开数据库
    int result = sqlite3_open([filePath UTF8String], &sqlite);
    if (result != SQLITE_OK) {
        NSLog(@"打开数据库失败");
        return nil;
    }
    
    //NSString *sql = @"SELECT username,password,email FROM USER WHERE username=?";
    NSString *sql = @"SELECT contentid,contenttext FROM article_content WHERE indexid=?";
    
    //编译SQL语句
    sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &stmt, NULL);
    
    //往占位符上绑定数据
    //sqlite3_bind_text(stmt, 1, indexid, -1, NULL);
    sqlite3_bind_int(stmt, 1, indexid );
    
    ArticleContent *articleContent = [[ArticleContent alloc] init];

    //查询数据
    result = sqlite3_step(stmt);
    while (result == SQLITE_ROW)
    {        
        articleContent.contentid = sqlite3_column_int(stmt, 0);
        articleContent.contenttext = [NSString stringWithUTF8String: (char *)sqlite3_column_text(stmt, 1) ];
        
        //NSLog(@"contentid：%d, contenttext：%@", articleContent.contentid, articleContent.contenttext);
        
//        [indexes addObject:articleIndex];
//        [articleIndex release];
        
        result = sqlite3_step(stmt);
    }
    
    //关闭数据库句柄
    sqlite3_finalize(stmt);
    
    //关闭数据库
    sqlite3_close(sqlite);
    //NSLog(@"indexs : %@", indexes);
    return articleContent;
}

+ (NSString *)fetchContent: (NSInteger)indexid
{
    sqlite3 *sqlite = nil;
    sqlite3_stmt *stmt = nil;
    
    //    NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/data.sqlite"];
    
    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"data.sqlite3"];
    
    //打开数据库
    int result = sqlite3_open([filePath UTF8String], &sqlite);
    if (result != SQLITE_OK) {
        NSLog(@"打开数据库失败");
        return nil;
    }
    
    //NSString *sql = @"SELECT username,password,email FROM USER WHERE username=?";
    NSString *sql = @"SELECT contentid,contenttext FROM article_content WHERE indexid=?";
    
    //编译SQL语句
    sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &stmt, NULL);
    
    //往占位符上绑定数据
    //sqlite3_bind_text(stmt, 1, indexid, -1, NULL);
    sqlite3_bind_int(stmt, 1, indexid );
    
    ArticleContent *articleContent = [[ArticleContent alloc] init];
    
    //查询数据
    result = sqlite3_step(stmt);
    while (result == SQLITE_ROW)
    {
        articleContent.contentid = sqlite3_column_int(stmt, 0);
        articleContent.contenttext = [NSString stringWithUTF8String: (char *)sqlite3_column_text(stmt, 1) ];
        
        //NSLog(@"contentid：%d, contenttext：%@", articleContent.contentid, articleContent.contenttext);
        
        //        [indexes addObject:articleIndex];
        //        [articleIndex release];
        
        result = sqlite3_step(stmt);
    }
    
    //关闭数据库句柄
    sqlite3_finalize(stmt);
    
    //关闭数据库
    sqlite3_close(sqlite);
    //NSLog(@"indexs : %@", indexes);
    return articleContent.contenttext;
}

+ (NSMutableArray *)fetchWords: (NSInteger)indexid
{
    sqlite3 *sqlite = nil;
    sqlite3_stmt *stmt = nil;
    
    //NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/data.sqlite"];
    
    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"data.sqlite3"];
    
    //打开数据库
    int result = sqlite3_open([filePath UTF8String], &sqlite);
    if (result != SQLITE_OK) {
        NSLog(@"打开数据库失败");
        return nil;
    }
    
    //NSString *sql = @"SELECT username,password,email FROM USER WHERE username=?";
    NSString *sql = @"SELECT wordid,word,wordlevel FROM words WHERE wordlevel<=?";
    
    //编译SQL语句
    sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &stmt, NULL);
    
    //往占位符上绑定数据
    //sqlite3_bind_text(stmt, 1, indexid, -1, NULL);
    sqlite3_bind_int(stmt, 1, indexid );

    NSMutableArray *indexes = [NSMutableArray array];
    [indexes removeAllObjects];
    
    //查询数据
    result = sqlite3_step(stmt);
    while (result == SQLITE_ROW)
    {
        Words *words = [[Words alloc] init];
        
        words.wordsid = sqlite3_column_int(stmt, 0);
        words.word = [NSString stringWithUTF8String: (char *)sqlite3_column_text(stmt, 1) ];
        words.wordLevel = sqlite3_column_int(stmt, 2);
        
        //NSLog(@"wordsid：%d, word:%@,wordLevel：%d", words.wordsid, words.word, words.wordLevel);

        [indexes addObject:words.word];
        [words release];
        
        result = sqlite3_step(stmt);
    }
    
    //关闭数据库句柄
    sqlite3_finalize(stmt);
    
    //关闭数据库
    sqlite3_close(sqlite);
    //NSLog(@"indexs : %@", indexes);
    return indexes;
}

@end
