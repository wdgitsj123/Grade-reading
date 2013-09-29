//
//  SetLevelViewController.h
//  wzdp
//
//  Created by valu on 13-9-23.
//  Copyright (c) 2013年 jundie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ArticleContentViewController;

@interface SetLevelViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *tabView;
    ArticleContentViewController *vc;    
}
@property (nonatomic, retain)UITableView *tabView;
@property (retain, nonatomic) IBOutlet UIImageView *backBtnImage;
@property (retain, nonatomic)ArticleContentViewController *vc;


@end
