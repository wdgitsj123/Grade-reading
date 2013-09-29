//
//  ArticleContent.h
//  wzdp
//
//  Created by valu on 13-9-21.
//  Copyright (c) 2013年 jundie. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ArticleIndex;

@interface ArticleContent : NSObject
{
    NSInteger contentid;
    NSString *contenttext;
    ArticleIndex *articleIndex;
}
@property (nonatomic)NSInteger contentid;
@property (nonatomic, retain)NSString *contenttext;
@property (nonatomic, retain)ArticleIndex *articleIndex;

@end
