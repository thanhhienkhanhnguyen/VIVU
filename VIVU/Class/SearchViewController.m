//
//  SearchViewController.m
//  VIVU
//
//  Created by MacPro on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize delegate;
@synthesize searchBarController;
@synthesize requestLocation;
@synthesize dataSourceTableView;
@synthesize tableViewSearch;
@synthesize resultDatasource;
-(void)dealloc
{
    [resultDatasource release];
    [tableViewSearch release];
    [dataSourceTableView release];
    [searchBarController release];
    [requestLocation release];
    delegate = nil;
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//        self.arrayResultSearch = [userDefault objectForKey:@"resultSearch"];  //search in arrayresultSearch
//        checkEdit = NO;
//        if (!arrayResultSearch) {
//            self.arrayResultSearch = [[[NSMutableArray alloc]init]autorelease];
//        }
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableViewSearch reloadData];
    self.title = @"Search";
    self.searchBarController.text =@"";
    [self.searchBarController becomeFirstResponder];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *cancelBtn =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelEvent:)];
    self.navigationItem.leftBarButtonItem =cancelBtn;
    UIBarButtonItem *deleteBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteAllSearchResult:)];
//    self.navigationItem.rightBarButtonItem = deleteBtn;
    [cancelBtn release];
    [deleteBtn release];
    
}
-(void)cancelEvent:(id) sender
{
    [self dismissModalViewControllerAnimated:YES];
    [self.delegate hiddenBar];
}
-(void)deleteAllSearchResult:(id)sender
{

//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    [userDefault setObject:arrayResultSearch forKey:@"resultSearch"];
//    [userDefault synchronize];
//    [self.tableViewSearch reloadData];
    
}
#pragma mark SearchBar delegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
//    NSString *keyword = @"keyword";
//    if (self.searchBarController.text) {
//        keyword = self.searchBarController.text;
//        
//    }
//    BOOL check = NO;
//    for( NSDictionary *dictInfor in dataSourceTableView)
//    {
//        if ([keyword isEqual:array]) {
//            check  = YES;
//            break;
//        }
//    }
//    if (!check) {
//        [arrayResultSearch addObject:keyword];
//    }
    
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    [userDefault setObject:arrayResultSearch forKey:@"resultSearch"];
//    [userDefault synchronize];
//    checkEdit = NO;
//    [self.delegate pushDetailViewControllerFromSearchView:keyword  searchBar:self];    
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    checkEdit = YES;
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
//- (BOOL)textFielsShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    return YES;
//}
#pragma mark Table delagate
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
    
    NSDictionary *dictDetail = [resultDatasource objectAtIndex:indexPath.row];
    [self dismissModalViewControllerAnimated:YES];
    [self.delegate hiddenBar];
    [self.delegate pushDetailViewControllerFromSearchView:dictDetail];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
