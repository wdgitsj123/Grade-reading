//
//  ArticleContentViewController.m
//  wzdp
//
//  Created by valu on 13-9-20.
//  Copyright (c) 2013年 jundie. All rights reserved.
//

#import "ArticleContentViewController.h"

@interface ArticleContentViewController ()

@end

@implementation ArticleContentViewController
@synthesize content;
@synthesize indexid;
@synthesize title_cn;
@synthesize title_en;
@synthesize question;
@synthesize backgroundView;
@synthesize titleView;
@synthesize richContent;
@synthesize scrollView;
@synthesize coreTextView;
@synthesize isTitleViewOn;

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    isTitleViewOn = NO;
    isHighlight = YES;   //默认开启高亮显示
    
    [self someInit];
    
    //创建内容view
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    //scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    NSLog(@"%@", NSStringFromCGRect(self.view.bounds));
    NSLog(@"%@", NSStringFromCGRect(self.view.frame));

    scrollView.tag = 101;
    scrollView.multipleTouchEnabled = YES;
    scrollView.scrollsToTop = YES;
    scrollView.showsVerticalScrollIndicator = NO;  //让使用者专注于阅读，而不是其他的
	scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    coreTextView = [[FTCoreTextView alloc] initWithFrame:CGRectMake(10, 10, 300, 10)];
	coreTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    coreTextView.text = self.richContent;
    coreTextView.userInteractionEnabled = NO;
    coreTextView.multipleTouchEnabled = YES;
    coreTextView.tag = 102;
    [coreTextView addStyles:[self coreTextStyle]];
    [coreTextView setDelegate:self];
	[coreTextView fitToSuggestedHeight];
    [scrollView addSubview:coreTextView];
    [scrollView setContentSize:CGSizeMake(CGRectGetWidth(scrollView.bounds), CGRectGetHeight(coreTextView.frame) + 40)];
    [self.view addSubview:scrollView];
    
    //创建覆盖在内容上面的背景view，并动画出现
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, ScreenHeight - 20 - 0)];  
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0;
    [self.view addSubview:backgroundView];
    [backgroundView release];
    [self doAnimation:2];
    
    //创建标题view
    titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 115)];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleView];
    [titleView release];
    [self makeTitleView];//向标题view添加子视图

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [content release];
    [title_en release];
    [title_cn release];
    [question release];
    [richContent release];
    [scrollView release];
    [coreTextView release];
    [backgroundView release];
    [titleView release];
    [super dealloc];
}

#pragma mark - Custom Method

//处理触摸事件，即动画效果
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{    
    UITouch *touch = [touches anyObject];
//    NSLog(@"touch %d",touch.view.tag);
   
    NSUInteger tapCount = touch.tapCount;
    //NSLog(@"%d",tapCount);
    
    if (tapCount == 1) {
        [self performSelector:@selector(singleTap) withObject:nil afterDelay:0.2];
    }
    else if(tapCount == 2) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleTap) object:nil];
        [self doubleTap];
    }
}

- (void)singleTap
{
    if ( isTitleViewOn )
    {
        [self doAnimation:1];
        [self doAnimation:3];
        isTitleViewOn = NO;
    }else
    {
        [self doAnimation:2];
        [self doAnimation:5];
        isTitleViewOn = YES;
    }
}

- (void)doubleTap   //双击开启、关闭单词高亮显示
{
    NSLog(@"hahahha");
    if (isHighlight) {
        isHighlight = NO;
    }else{
        isHighlight = YES;
    }
    [coreTextView addStyles:[self coreTextStyle]];
}

- (void)someInit
{
    [self getLevel];
    [self getcontent];
    [self makeTitleView];
    coreTextView.text = self.richContent; //更新文章内容
    [coreTextView addStyles:[self coreTextStyle]]; //刷新成富文本样式，即字体高亮颜色
    scrollView.contentOffset = self.view.bounds.origin;
	[coreTextView fitToSuggestedHeight];
    [scrollView setContentSize:CGSizeMake(CGRectGetWidth(scrollView.bounds), CGRectGetHeight(coreTextView.frame) + 40)];
}

- (void)getLevel
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];  //读取数据
    level = [userDefault integerForKey:@"level"];
    NSLog(@"level : %d", level);
}

//从ArticleList写入本地的plist中获取选中的文章的信息，并从数据库读取文章内容
- (void)getcontent
{
    [self LaunchJudge];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];  //读取数据
    self.indexid = [userDefault integerForKey:@"index"];
    self.title_en = [userDefault stringForKey:@"title_en"];
    self.title_cn = [userDefault stringForKey:@"title_cn"];
    self.question = [userDefault stringForKey:@"question"];
    NSLog(@"正文中：%d %@ %@ %@ ", indexid, title_en, title_cn, question);
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])//
    {
        self.indexid = 1;
        self.title_en = @"Finding fossil man";
        self.title_cn = @"发现化石人";
        self.question = @"Why are legends handed down by storytellers useful?";
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setInteger:indexid forKey:@"index"];
        [userDefault setObject:title_en forKey:@"title_en"];
        [userDefault setObject:title_cn forKey:@"title_cn"];
        [userDefault setObject:question forKey:@"question"];
        [userDefault synchronize];
        
        self.content = [ArticleDB fetchArticleContent:1];
        NSLog(@"ArticleContentViewController : %@", content);
        self.richContent = self.content.contenttext;
    }
    else{
        
        self.content = [ArticleDB fetchArticleContent:[[NSUserDefaults standardUserDefaults] integerForKey:@"index"]];
        NSLog(@"ArticleContentViewController : %@", content);
        self.richContent = [TransformArticle markLevelInArticleWithArticle:self.content.contenttext andLevel:level];
    }

    
}

//标题view和创建覆盖在内容上面的背景view，动画效果
- (void)doAnimation:(NSInteger)animationID
{
    switch (animationID) {
        case 1:  //阴影覆盖效果消失
            [UIView beginAnimations:@"testAnimation" context:@"test"];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDelegate:self];
            //[UIView setAnimationDidStopSelector:@selector(animationStop)];
            backgroundView.alpha = 0;
            [UIView commitAnimations];
            break;
        case 2:  //阴影覆盖效果出现
            [UIView beginAnimations:@"testAnimation" context:@"test"];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDelegate:self];
            //[UIView setAnimationDidStopSelector:@selector(animationStop)];
            backgroundView.alpha = 0.7;
            [UIView commitAnimations];
            break;
        case 3:  //titleView消失
            [UIView beginAnimations:@"testAnimation" context:@"test"];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            [UIView setAnimationDelegate:self];
            //[UIView setAnimationDidStopSelector:@selector(animationStop)];
            titleView.frame = CGRectMake(0, -115, 320, 115);
            titleView.alpha = 0.01;
            [UIView commitAnimations];
            break;
        case 4:  //titleView慢出现
            [UIView beginAnimations:@"testAnimation" context:@"test"];
            [UIView setAnimationDuration:0.1];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            [UIView setAnimationDelegate:self];
            //[UIView setAnimationDidStopSelector:@selector(animationStop)];
            titleView.frame = CGRectMake(0, 0, 320, 115);
            titleView.alpha = 1;
            [UIView commitAnimations];
            break;
        case 5:  //titleView快出现
            [UIView beginAnimations:@"testAnimation" context:@"test"];
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            [UIView setAnimationDelegate:self];
            //[UIView setAnimationDidStopSelector:@selector(animationStop)];
            titleView.frame = CGRectMake(0, 0, 320, 115);
            titleView.alpha = 1;
            [UIView commitAnimations];
            break;
        default:
            break;
    }
}

- (void)makeTitleView
{
    UIButton *levelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //levelBtn.frame = CGRectMake(280, 8, 30, 22);
    levelBtn.frame = CGRectMake(245, 8, 70, 44);
    [levelBtn setImage:[UIImage imageNamed:@"level"] forState:UIControlStateNormal];
    [levelBtn addTarget:self action:@selector(setLevelView) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:levelBtn];
    
    UILabel *title_enLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 200, 25)];
    //title_enLabel.backgroundColor = [UIColor grayColor];
    title_enLabel.text = self.title_en;
    title_enLabel.adjustsFontSizeToFitWidth = YES;
    title_enLabel.textColor = [UIColor colorWithRed:212/255.0 green:55/255.0 blue:60/255.0 alpha:1];
    title_enLabel.font = [UIFont systemFontOfSize:20];
    [titleView addSubview:title_enLabel];
    [title_enLabel release];
    
    UILabel *title_cnLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 200, 23)];
    //title_cnLabel.backgroundColor = [UIColor blueColor];
    title_cnLabel.text = self.title_cn;
    title_cnLabel.adjustsFontSizeToFitWidth = YES;
    title_cnLabel.textColor = [UIColor colorWithRed:237/255.0 green:29/255.0 blue:37/255.0 alpha:1];
    title_cnLabel.font = [UIFont systemFontOfSize:15];
    [titleView addSubview:title_cnLabel];
    [title_cnLabel release];
    
    UILabel *qusetionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 300, 60)];
    //qusetionLabel.backgroundColor = [UIColor grayColor];
    qusetionLabel.text = [NSString stringWithFormat:@"Question : %@", self.question];
    qusetionLabel.adjustsFontSizeToFitWidth = YES;
    qusetionLabel.numberOfLines = 0;
    qusetionLabel.textColor = [UIColor colorWithRed:169/255.0 green:169/255.0 blue:169/255.0 alpha:1];
    qusetionLabel.font = [UIFont systemFontOfSize:15];
    [titleView addSubview:qusetionLabel];
    [qusetionLabel release];
    
    isTitleViewOn = YES;
}

//点击6个原点按钮，弹出setLevel视图
- (void)setLevelView
{
    SetLevelViewController *setLevelViewController = [[SetLevelViewController alloc] init];
    setLevelViewController.vc = self;
    setLevelViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:setLevelViewController animated:YES];
    [setLevelViewController release];
}

//对内容添加富文本标记
- (NSArray *)coreTextStyle
{
    NSMutableArray *result = [NSMutableArray array];
    
    NSArray *colorArray = [NSArray arrayWithObjects:[UIColor colorWithRed:85/255.0 green:218/255.0 blue:152/255.0 alpha:1],
                           [UIColor colorWithRed:0/255.0 green:192/255.0 blue:229/255.0 alpha:1],
                           [UIColor colorWithRed:234/255.0 green:194/255.0 blue:63/255.0 alpha:1],
                           [UIColor colorWithRed:232/255.0 green:83/255.0 blue:121/255.0 alpha:1],
                           [UIColor colorWithRed:205/255.0 green:107/255.0 blue:216/255.0 alpha:1],
                           [UIColor colorWithRed:119/255.0 green:81/255.0 blue:252/255.0 alpha:1], nil];
    
	FTCoreTextStyle *defaultStyle = [FTCoreTextStyle new];
	defaultStyle.name = FTCoreTextTagDefault;	
	defaultStyle.font = [UIFont fontWithName:@"Avenir-Light" size:16.f];
	defaultStyle.textAlignment = FTCoreTextAlignementJustified;
	[result addObject:defaultStyle];
    
    FTCoreTextStyle *coloredStyle = [defaultStyle copy];
    [coloredStyle setName:@"colored"];
    //[coloredStyle setColor:[UIColor redColor]];
    if (isHighlight) {
        [coloredStyle setColor:colorArray[ 5 - level]];
    }else{
        [coloredStyle setColor:[UIColor blackColor] ];
    }

	[result addObject:coloredStyle];
    
    return  result;
}

- (void)LaunchJudge
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end

