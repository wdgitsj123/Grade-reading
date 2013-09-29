//
//  ArticleIndex.h
//  wzdp
//
//  Created by valu on 13-9-21.
//  Copyright (c) 2013年 jundie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleIndex : NSObject
{
    NSInteger indexid;
    NSString *title_en;
    NSString *title_cn;
    NSString *question;
}
@property (nonatomic)NSInteger indexid;
@property (nonatomic, retain)NSString *title_en;
@property (nonatomic, retain)NSString *title_cn;
@property (nonatomic, retain)NSString *question;
@end
