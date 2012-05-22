//
//  SearchVenueViewController.m
//  VIVU
//
//  Created by MacPro on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchVenueViewController.h"
#import "VIVUtilities.h"

@interface SearchVenueViewController ()

@end



@implementation SearchVenueViewController
@synthesize delegate;
@synthesize searchBarController;
@synthesize dataSourceTableView;
@synthesize tableViewSearch;
@synthesize resultDatasource;

-(void)dealloc
{
    [resultDatasource release];
    [tableViewSearch release];
    [dataSourceTableView release];
    [searchBarController release];

    delegate = nil;
    [super dealloc];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

    resultDatasource = [[NSMutableArray alloc]init];
    for(NSDictionary *dictInfor in dataSourceTableView)
    {
        NSString *name = [dictInfor objectForKey:@"name"];
        if ([name hasPrefix:searchText]||[name rangeOfString:searchText].length>0){
            [resultDatasource addObject:dictInfor];
        }
        
    }
    [self.tableViewSearch reloadData];
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (resultDatasource) {
        return [resultDatasource count];  
    }
    return 0;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Location";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [resultDatasource  sortUsingComparator:^NSComparisonResult(id o1, id o2) {
        NSDictionary *dict1 = [o1 objectForKey:@"location"];
        NSDictionary *dict2 = [o2 objectForKey:@"location"];
        NSNumber *urlStr1 = [dict1 objectForKey:@"distance"];
        NSNumber *urlStr2 = [dict2 objectForKey:@"distance"];
        return [urlStr1 compare:urlStr2];
    }];

    
    NSDictionary *dictDetail = [resultDatasource  objectAtIndex:indexPath.row];
    cell.textLabel.text = [dictDetail objectForKey:@"name"];
    //    UILabel *distanceLabel = (UILabel *)[cell.contentView viewWithTag:SubDetail];
    NSDictionary *location = [dictDetail objectForKey:@"location"];
    NSString *distance = [location objectForKey:@"distance"];
    NSString *temp = [NSString stringWithFormat:@"%@ m",distance];
    //    distanceLabel.text = temp;
    
    cell.detailTextLabel.text = temp;
    
    NSString *filePath = [NSString stringWithFormat:@"%@/favicon/%@.favicon.ico",
                          [VIVUtilities applicationDocumentsDirectory],
                          [dictDetail objectForKey:@"type"]];
    
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    if (!image) {
        //Image default
        cell.imageView.image = [UIImage imageNamed:@"default_32.png"];
        
    }else {
        cell.imageView.image = image;
    }
    
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self  searchBarSearchButtonClicked:self.searchBarController];
    NSDictionary *dictDetail = [resultDatasource objectAtIndex:indexPath.row];
    [self dismissModalViewControllerAnimated:YES];

    [self.delegate pushDetailVenueFromSearchController:dictDetail];
}

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
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableViewSearch reloadData];
    self.title = @"Search";
    self.searchBarController.text =@"";
    [self.searchBarController becomeFirstResponder];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
