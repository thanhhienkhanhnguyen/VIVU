//
//  PlaceTableViewController.m
//  VIVU
//
//  Created by MacPro on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define NameTag   1000
#define ImageTag  10001
#define SubDetail 10002

#import "PlaceTableViewController.h"

#import <UIKit/UIKit.h>
#import "VIVUtilities.h"
#import "CustomeButton.h"
#import "DetailImageViewController.h"
#import "ImagesViewController.h"
#import "tableViewTipsControllerViewController.h"
#import "MorePhotosProvider.h"
#import "PhotosViewController.h"
#import "PhotosScrollViewController.h"

@interface PlaceTableViewController ()

@end

@implementation PlaceTableViewController
@synthesize tableView;
@synthesize resizeView;
@synthesize dataSourceTableView;
@synthesize arraySourceFavicon;
@synthesize delegate;


-(void)dealloc{
    delegate = nil;
    [resizeView release];
    [arraySourceFavicon release];
    [tableView release];
    [dataSourceTableView release];
    [super dealloc];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"Places";
}
-(CGSize)sizeInPopoverView
{
    int count = [tableView numberOfRowsInSection:0];
    CGFloat h = count * tableView.rowHeight;
    h += 44; //for navigation bar
    
    return CGSizeMake(250, h);
}
-(void)configureView
{
    if (!dataSourceTableView) {
        self.dataSourceTableView = nil;
        
    }
    self.title = @"Foursquare";
    if (!tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate =self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        [tableView setRowHeight:44];
//        [tableView setSeparatorColor:[UIColor lightGrayColor]];
//        tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"row_header"]];
        
        
    }
    [tableView reloadData];
    
    
    
    
}

-(void) loadImageFromArrayProviderWithCounter:(NSInteger)index
{
    if (index >=0&&index< [arraySourceFavicon count]) {
        NSDictionary *dictFavicon = [arraySourceFavicon objectAtIndex:index];
        ImagesProfileProvider *provider = [dictFavicon objectForKey:@"provider"];
        provider.ImagesProfileDelegate =self;
        BOOL needDownload = YES;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/favicon/%@.favicon.ico",
                                           [VIVUtilities applicationDocumentsDirectory],
                                           [dictFavicon objectForKey:@"type"]]]) {
            needDownload = NO;
        }
        if (needDownload) {
            if (index>=1) {
                NSDictionary *preDictFavicon = [arraySourceFavicon objectAtIndex:(index-1)];
                ImagesProfileProvider *preProvider = [preDictFavicon objectForKey:@"provider"];
                if (preProvider.finishLoad ==YES) {
                    [provider requestData];
                }else {
                    //                        NSLog(@"%@",[preProvider getCurrentURL]);
                }
            }else {
                [provider requestData];
            }
        }else {
            // file exist -finishload = YES
            provider.finishLoad = YES;
            counter++;
            [self loadOneByOneImage];
        }
    }
    
    
}
-(void)loadOneByOneImage
{
//    if (detailViewController) {
//        //        [detailViewController configureView];
//    }  
    if (arraySourceFavicon) {
        [self loadImageFromArrayProviderWithCounter:counter];
    }
    
//    if (detailViewController) {
//        //        [detailViewController configureView];
//    }
    
}

-(void)loadOneByOneIcon
{
    for(NSDictionary *dictFaviconProvider in arraySourceFavicon)
    {
        ImagesProfileProvider *provider = [dictFaviconProvider objectForKey:@"provider"];
        provider.ImagesProfileDelegate = self;
        NSString *type = [dictFaviconProvider objectForKey:@"type"];
        if (provider.resultContent==nil) {
             BOOL needDownload = YES;
//            NSString *urlString = [provider getCurrentURL];
             NSFileManager *fileManager = [NSFileManager defaultManager];
            if ([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/favicon/%@.favicon.ico",
                                               [VIVUtilities applicationDocumentsDirectory],
                                               type]]) {
                needDownload = NO;
            }
            if (needDownload) {
                [provider requestData];
            }

            
        }
               
    }
    NSLog(@"load icon did finish......");
    [self.tableView reloadData];
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataSourceTableView = nil;
        counter =0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   //
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark TableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSourceTableView) {
        NSInteger t = [self.dataSourceTableView count];
        return t;
       
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView12 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Place Cell";
    
    UITableViewCell *cell = [tableView12 dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, (cell.frame.size.width - 40) - 5, 20)];
//        [label setTag:NameTag];
//        label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
//        label.textColor = [UIColor colorWithRed:66.0f/255.0f green:66.0f/255.0f blue:66.0f/255.0f alpha:1]; 
//        [cell.contentView addSubview:label];
//        [label release];
//        label = [[UILabel alloc]initWithFrame:CGRectMake(40, 25,  (cell.frame.size.width - 40) - 5, 20)];
//        [label setTag:SubDetail];
//        label.textColor = [UIColor colorWithRed:66.0f/255.0f green:66.0f/255.0f blue:66.0f/255.0f alpha:1]; 
//        label.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
//        [cell.contentView addSubview:label];
//        [label release];
        
    }
    
    NSDictionary *dictDetail = [dataSourceTableView objectAtIndex:indexPath.row];

//    UILabel *nameLabel = (UILabel*)[cell.contentView viewWithTag:NameTag];
    cell.textLabel.text = [dictDetail objectForKey:@"name"];
//    nameLabel.text = [dictDetail objectForKey:@"name"];
    
//    UILabel *distanceLabel = (UILabel *)[cell.contentView viewWithTag:SubDetail];
    NSDictionary *location = [dictDetail objectForKey:@"location"];
    NSString *distance = [location objectForKey:@"distance"];
    NSString *temp = [NSString stringWithFormat:@"%@ m",distance];
//    distanceLabel.text = temp;
    
    cell.textLabel.text = [dictDetail objectForKey:@"name"];
    cell.detailTextLabel.text = temp;

    NSString *filePath = [NSString stringWithFormat:@"%@/favicon/%@.favicon.ico",
                          [VIVUtilities applicationDocumentsDirectory],
                          [dictDetail objectForKey:@"type"]];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    if (!image) {
        cell.imageView.image =[UIImage imageNamed:@"default_32.png"];
    }else {
        cell.imageView.image = image;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictDetail = [dataSourceTableView objectAtIndex:indexPath.row];
    if (dictDetail) {
        [self.delegate pushDetailFromPlaceTableView:dictDetail];
    }
}

#pragma mark ImagesProfilesProvider Delegate
-(void)ImagesProfileProviderDidFinishParsing:(ImagesProfileProvider *)provider
{
    provider.finishLoad = YES;
    UIImage *image = [UIImage imageWithData:provider.returnData];
    if (!image) {
        //load icon defaul
    }else {
        NSString *filePath = [NSString stringWithFormat:@"%@/favicon/%@.favicon.ico",
                              [VIVUtilities applicationDocumentsDirectory],
                              provider.categoryName];
        
        NSString *dirPath = [VIVUtilities applicationDocumentsDirectory];
        dirPath = [dirPath stringByAppendingString:@"/favicon"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDirectory;
        if (![fileManager fileExistsAtPath:dirPath isDirectory:&isDirectory])
        {
            NSError *error;
            [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:NO attributes:nil error:&error];
        }
        if (![fileManager fileExistsAtPath:filePath]) {
            UIImage *image = [UIImage imageWithData:provider.returnData];
            if (image) {
                if ([provider.returnData writeToFile:filePath atomically:YES]) {
                    NSLog(@"Successful save data:%@", filePath);
                    //wire to file successful. release cache data
                    provider.returnData = [NSData data];
                }
            }                
        }
        NSArray *paths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in paths) {
            int row = indexPath.row;
            NSDictionary *item = [dataSourceTableView objectAtIndex:row];
            if ([provider.categoryName isEqual:[item objectForKey:@"type"]]) {
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }


    }
    counter ++;
    [self loadOneByOneImage];
    
}

-(void) ImagesProfileProviderDidFinishWithError:(NSError *)error  provider:(ImagesProfileProvider*)provider
{
    provider.finishLoad = YES;
    counter ++;
    [self loadOneByOneImage];
//    if (provider.mode== ProvierModeUserMostActive) {
//        [detailViewController reloadAvatarMostActive];
//    }
}
@end
