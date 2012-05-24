//
//  SearchViewController.m
//  VIVU
//
//  Created by MacPro on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
#define NUMBER_OF_CHEAT_ROW     10

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
    self.tableViewSearch.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.searchBarController resignFirstResponder];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *cancelBtn =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelEvent:)];
//    self.navigationItem.leftBarButtonItem =cancelBtn;
    UIBarButtonItem *deleteBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteAllSearchResult:)];
//    self.navigationItem.rightBarButtonItem = deleteBtn;
    [cancelBtn release];
    [deleteBtn release];
    
    [self.tableViewSearch setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"info_bar.png"]]];
//    self.tableViewSearch.backgroundView = [[[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"info_bar.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ]autorelease];
    self.tableViewSearch.separatorStyle = UITableViewCellSeparatorStyleNone;
   //    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"info_bar.png"]]
//    ];    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissModalViewControllerAnimated:YES];
}
-(void)cancelEvent:(id) sender
{
    [self dismissModalViewControllerAnimated:YES];
    
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
    
    
    if (resultDatasource) {
        [resultDatasource removeAllObjects];
    }else {
        resultDatasource = [[NSMutableArray alloc]init];
    }
    
    for(NSDictionary *dictInfor in dataSourceTableView)
    {
        NSString *name = [dictInfor objectForKey:@"name"];
        if ([name hasPrefix:searchText]||[name rangeOfString:searchText].length>0){
            if (![resultDatasource containsObject:dictInfor]) {
                [resultDatasource addObject:dictInfor];
            }
            
        }
        
    }
//    if ([resultDatasource count]>0) {
//        self.tableViewSearch.separatorStyle= UITableViewCellSeparatorStyleNone;
//    }else {
//        self.tableViewSearch.separatorStyle= UITableViewCellSeparatorStyleSingleLine;
//    }
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
        if ([resultDatasource count]>0) {
            return ([resultDatasource count]+NUMBER_OF_CHEAT_ROW);  
        }
        
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
     cell.backgroundView =  [[[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"info_bar.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ]autorelease];
    if ([resultDatasource count]>0) {
        if (indexPath.row < ([self.tableViewSearch numberOfRowsInSection:0]-NUMBER_OF_CHEAT_ROW)) {
            [ resultDatasource  sortUsingComparator:^NSComparisonResult(id o1, id o2) {
                NSDictionary *dict1 = [o1 objectForKey:@"location"];
                NSDictionary *dict2 = [o2 objectForKey:@"location"];
                NSNumber *urlStr1 = [dict1 objectForKey:@"distance"];
                NSNumber *urlStr2 = [dict2 objectForKey:@"distance"];
                return [urlStr1 compare:urlStr2];
            }];
            NSDictionary *dictDetail = [resultDatasource  objectAtIndex:indexPath.row];
            cell.textLabel.font =[UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
            cell.textLabel.text = [dictDetail objectForKey:@"name"];
            //    UILabel *distanceLabel = (UILabel *)[cell.contentView viewWithTag:SubDetail];
            NSDictionary *location = [dictDetail objectForKey:@"location"];
            NSString *distance = [location objectForKey:@"distance"];
            NSString *temp = [NSString stringWithFormat:@"%@ m",distance];
            //    distanceLabel.text = temp;
            
            cell.detailTextLabel.text = temp;
            cell.detailTextLabel.textColor =[UIColor whiteColor];
            cell.detailTextLabel.font =[UIFont fontWithName:@"HelveticaNeue" size:9];
            cell.textLabel.textColor = [UIColor whiteColor];
            [cell.detailTextLabel setBackgroundColor:[UIColor clearColor]];
            [cell.textLabel setBackgroundColor:[UIColor clearColor]];
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
            
        }else {
            cell.detailTextLabel.text = @"";
            cell.textLabel.text = @"";
            cell.imageView.image = nil;
            
        }

    }
      
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row < ([self.tableViewSearch numberOfRowsInSection:0]-NUMBER_OF_CHEAT_ROW)) {
        NSDictionary *dictDetail = [resultDatasource objectAtIndex:indexPath.row];
        [self dismissModalViewControllerAnimated:YES];
        //    [self.delegate hiddenBar];
        [self.delegate pushDetailViewControllerFromSearchView:dictDetail];
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
