//
//  ArticleListViewController.h
//  wzdp
//
//  Created by valu on 13-9-20.
//  Copyright (c) 2013年 jundie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleDB.h"
#import "ArticleIndex.h"
#import "ArticleContentViewController.h"
#import "IIViewDeckController.h"

@interface ArticleListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, IIViewDeckControllerDelegate>
{
    NSMutableArray *articleIndexesArray;
    
    UITableView *tabView;
    ArticleContentViewController *vc;
}
@property (nonatomic, retain)NSMutableArray *articleIndexesArray;
@property (nonatomic, retain)UITableView *tabView;
@property (nonatomic, retain)ArticleContentViewController *vc;

@end
