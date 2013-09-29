//
//  ArticleListViewController.m
//  wzdp
//
//  Created by valu on 13-9-20.
//  Copyright (c) 2013年 jundie. All rights reserved.
//

#import "ArticleListViewController.h"

@interface ArticleListViewController ()

@end


@implementation ArticleListViewController
@synthesize articleIndexesArray;
@synthesize tabView;
@synthesize vc;

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //文章列表标题提示
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 270, 44)];  
    topLabel.backgroundColor = [UIColor colorWithRed:250/255.0 green:86/255.0 blue:77/255.0 alpha:1];
    topLabel.text = @"ArticleList";
    topLabel.textAlignment = UITextAlignmentCenter;
    topLabel.textColor = [UIColor whiteColor];
    topLabel.font = [UIFont fontWithName:@"Avenir" size:19];
    [self.view addSubview:topLabel];
    [topLabel release];
    
    //获取文章列表
    if(self.articleIndexesArray == nil)
    {
        self.articleIndexesArray = [NSMutableArray array];
    }
    else
    {
        [self.articleIndexesArray removeAllObjects];
    }
    self.articleIndexesArray = [ArticleDB selectTable];
    //NSLog(@"文章列表%@", articleIndexesArray);
    
    self.tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHeight - 20 - 44 ) style:UITableViewStylePlain];
    tabView.dataSource = self;
    tabView.delegate = self;
    tabView.backgroundColor = [UIColor whiteColor];
    tabView.backgroundView = nil;
    tabView.rowHeight = 44;
    [self.view addSubview:tabView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [articleIndexesArray release];
    [tabView release];
    [vc release];
    [super dealloc];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.articleIndexesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"Cell1" owner:self options:nil];
        cell = [nibs objectAtIndex:0];
    }
    
    ArticleIndex *index = [self.articleIndexesArray objectAtIndex:indexPath.row];
    
    UILabel *label1 = (UILabel *)[cell.contentView viewWithTag:51];
    label1.text = [index title_en];
    
    UILabel *label2 = (UILabel *)[cell.contentView viewWithTag:52];
    label2.text = [index title_cn];
    
    UIView *selectedView = [[UIView alloc] initWithFrame:cell.contentView.frame];
    selectedView.backgroundColor = [UIColor colorWithRed:1/255.0 green:161/255.0 blue:133/255.0 alpha:1];
    cell.selectedBackgroundView = selectedView;
    [selectedView release];
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ArticleContent *content = [ArticleDB fetchBookContent:indexPath.row];
//    NSLog(@"%@", content);
    
    ArticleIndex *index = [self.articleIndexesArray objectAtIndex:indexPath.row];
    
    //选中的文章信息写入本地
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];  
    [userDefault setInteger:indexPath.row+1 forKey:@"index"];
    [userDefault setObject:index.title_en forKey:@"title_en"];
    [userDefault setObject:index.title_cn forKey:@"title_cn"];
    [userDefault setObject:index.question forKey:@"question"];
    [userDefault synchronize];
    
    [self.viewDeckController closeLeftView];
    
    [self.vc someInit];
    [self.vc doAnimation:2];
    [self.vc doAnimation:4];
    self.vc.isTitleViewOn = YES;
}

@end
