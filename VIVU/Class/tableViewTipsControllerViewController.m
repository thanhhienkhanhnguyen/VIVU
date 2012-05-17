//
//  tableViewTipsControllerViewController.m
//  VIVU
//
//  Created by MacPro on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "tableViewTipsControllerViewController.h"
#import "VIVUtilities.h"

@interface tableViewTipsControllerViewController ()

@end

@implementation tableViewTipsControllerViewController
@synthesize tableView;
@synthesize arrayTips;
@synthesize isBelongToPopOver;
@synthesize delegate;
-(void)dealloc
{
    delegate = nil;
    [tableView release];
    [arrayTips release];
    [super dealloc];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backToDetailVenue:)];
    self.navigationItem.leftBarButtonItem = btnBack;
    [btnBack release];
}
-(void) backToDetailVenue:(id)sender
{   
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.delegate backToDetaiVenueViewController];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (isBelongToPopOver) {
        [self setContentSizeForViewInPopover:CGSizeMake(330, 330)];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (arrayTips) {
        return [arrayTips count];   
    }
    return  0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView12 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"tableView tips";
    
    UITableViewCell *cell = [tableView12 dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    NSDictionary *dictTip = [arrayTips objectAtIndex:indexPath.row];
    NSDictionary *userTip =[dictTip objectForKey:@"userTip"];
    NSString *filePath = [NSString stringWithFormat:@"%@/favicon/image/%@.jpg",
                          [VIVUtilities applicationDocumentsDirectory],
                          [userTip objectForKey:@"id"]];
    
    UIImage *imageUser = [UIImage imageWithContentsOfFile:filePath];
    if (!imageUser) {
        imageUser = [UIImage imageNamed:@"default_32.png"];
    }
    cell.imageView.image = imageUser;
    cell.textLabel.numberOfLines =3;
    cell.textLabel.font =[UIFont systemFontOfSize:13];
    cell.textLabel.text = [dictTip objectForKey:@"text"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[dictTip objectForKey:@"date"]doubleValue]];
    
    
    NSString *dateTime =nil;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [NSTimeZone resetSystemTimeZone];
    [dateFormatter setDateFormat:@"EEE MMM dd, yyyy"];
    dateTime = [dateFormatter stringFromDate:date];
    [dateFormatter release];
    NSString *first = [userTip objectForKey:@"firstName"];
    if (!first) {
        first =@"";
    }
    NSString *last = [userTip objectForKey:@"lastName"];
    if (!last) {
        last =@"";
    }

    dateTime =[NSString stringWithFormat:@"added %@ by %@%@",dateTime,first,last];
    cell.detailTextLabel.font =[UIFont systemFontOfSize:12];
    cell.detailTextLabel.text = dateTime;
    return cell;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        arrayTips = nil;
    }
    return self;
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
