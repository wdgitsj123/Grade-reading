//
//  SetLevelViewController.m
//  wzdp
//
//  Created by valu on 13-9-23.
//  Copyright (c) 2013年 jundie. All rights reserved.
//

#import "SetLevelViewController.h"

@interface SetLevelViewController ()

@end

@implementation SetLevelViewController
@synthesize tabView;
@synthesize backBtnImage;
@synthesize vc;

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
    
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissVC)];
    [backBtnImage addGestureRecognizer:tapImage];
    [tapImage release];
        
    tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight - 20 - 50 ) style:UITableViewStylePlain];
    tabView.dataSource = self;
    tabView.delegate = self;
    tabView.backgroundColor = [UIColor whiteColor];
    tabView.backgroundView = nil;
    tabView.rowHeight = 70;
    //tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tabView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [backBtnImage release];
    [tabView release];
    [vc release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setBackBtnImage:nil];
    [super viewDidUnload];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

// Table中每行TableCell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"Cell2" owner:self options:nil];
        cell = [nibs objectAtIndex:0];
    }
    
    UILabel *label1 = (UILabel *)[cell.contentView viewWithTag:61];
    UILabel *label2 = (UILabel *)[cell.contentView viewWithTag:62];

    NSArray *colorArray = [NSArray arrayWithObjects:[UIColor colorWithRed:85/255.0 green:218/255.0 blue:152/255.0 alpha:1],
                           [UIColor colorWithRed:0/255.0 green:192/255.0 blue:229/255.0 alpha:1],
                           [UIColor colorWithRed:234/255.0 green:194/255.0 blue:63/255.0 alpha:1],
                           [UIColor colorWithRed:232/255.0 green:83/255.0 blue:121/255.0 alpha:1],
                           [UIColor colorWithRed:205/255.0 green:107/255.0 blue:216/255.0 alpha:1],
                           [UIColor colorWithRed:119/255.0 green:81/255.0 blue:252/255.0 alpha:1], nil];
    
    switch ( indexPath.row ) {
        case 0:
            label1.backgroundColor = colorArray[indexPath.row];
            label2.text = @"Level 5 — Level 0";
            label2.textColor = colorArray[indexPath.row];
            break;
        case 1:
            label1.backgroundColor = colorArray[indexPath.row];
            label2.text = @"Level 4 — Level 0";
            label2.textColor = colorArray[indexPath.row];
            break;
        case 2:
            label1.backgroundColor = colorArray[indexPath.row];
            label2.text = @"Level 3 — Level 0";
            label2.textColor = colorArray[indexPath.row];
            break;
        case 3:
            label1.backgroundColor = colorArray[indexPath.row];
            label2.text = @"Level 2 — Level 0";
            label2.textColor = colorArray[indexPath.row];
            break;
        case 4:
            label1.backgroundColor = colorArray[indexPath.row];
            label2.text = @"Level 1 — Level 0";
            label2.textColor = colorArray[indexPath.row];
            break;
        case 5:
            label1.backgroundColor = colorArray[indexPath.row];
            label2.text = @"Level 0";
            label2.textColor = colorArray[indexPath.row];
            break;
        default:
            break;
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    UITableViewCell *cell  = [tabView cellForRowAtIndexPath:indexPath];
    
    UILabel *label1 = (UILabel *)[cell.contentView viewWithTag:61];
    UILabel *label2 = (UILabel *)[cell.contentView viewWithTag:62];
    label2.textColor = [UIColor whiteColor];
    
    [UIView beginAnimations:@"" context:@""];
    [UIView setAnimationDuration:1.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissVC)];
    label1.frame = CGRectMake(0, 0, 320, 70);
    [UIView commitAnimations];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setInteger:5 - indexPath.row forKey:@"level"];
    [userDefault synchronize];
    
    [self.vc someInit];
    
}

#pragma mark - Custom Method

- (void)dismissVC
{
    [self dismissModalViewControllerAnimated:YES];
}
@end
