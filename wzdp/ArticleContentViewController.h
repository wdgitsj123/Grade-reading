//
//  ArticleContentViewController.h
//  wzdp
//
//  Created by valu on 13-9-20.
//  Copyright (c) 2013年 jundie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ArticleContent.h"
#import "ArticleDB.h"
#import "ContentTextView.h"
#import "SetLevelViewController.h"
#import "TransformArticle.h"
#import "FTCoreTextView.h"

@interface ArticleContentViewController : UIViewController <FTCoreTextViewDelegate>
{
    ArticleContent *content;
    NSInteger indexid;
    NSString *title_en;
    NSString *title_cn;
    NSString *question;
    NSString *richContent;
    NSInteger level;
    
    UIScrollView *scrollView;
    FTCoreTextView *coreTextView;
    UIView *backgroundView;
    UIView *titleView;
    
    BOOL isTitleViewOn;
    BOOL isHighlight;
}
@property (nonatomic, retain)ArticleContent *content;
@property (nonatomic)NSInteger indexid;
@property (nonatomic, retain)NSString *title_en;
@property (nonatomic, retain)NSString *title_cn;
@property (nonatomic, retain)NSString *question;
@property (nonatomic, retain)UIView *backgroundView;
@property (nonatomic, retain)UIView *titleView;
@property (nonatomic)BOOL isTitleViewOn;
@property (nonatomic, retain)NSString *richContent;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) FTCoreTextView *coreTextView;

- (void)someInit;
- (void)doAnimation:(NSInteger)animationID;
@end

