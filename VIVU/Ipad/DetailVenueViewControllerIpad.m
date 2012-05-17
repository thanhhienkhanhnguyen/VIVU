//
//  DetailVenueViewControllerIpad.m
//  VIVU
//
//  Created by MacPro on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailVenueViewControllerIpad.h"
#import "VIVUtilities.h"

@interface DetailVenueViewControllerIpad ()

@end

@implementation DetailVenueViewControllerIpad
@synthesize tableView;
@synthesize dictInfo;
@synthesize dataSourceTableView;
@synthesize requestMorePhoto;
@synthesize photosViewController;
@synthesize arrayProvider;
@synthesize arrayFullPhotos;
@synthesize counter;
@synthesize numberPhotos;
@synthesize requestMoreTips;
@synthesize tableViewTips;
@synthesize arraySubPhotos;
@synthesize arraySubProvider;
@synthesize delegate;


-(void)dealloc
{
    delegate =nil;
    [arraySubPhotos release];
    [arraySubProvider release];
    [tableViewTips release];
    [requestMoreTips release];
    counter =0;
    [arrayFullPhotos release];
    [arrayProvider release];
    [requestMorePhoto release];
    [dataSourceTableView release];
    [dictInfo release];
    [super dealloc];
}
-(CGSize)sizeInPopoverView
{
//    int count = [tableView numberOfRowsInSection:0];
//    CGFloat h = count * tableView.rowHeight;
//    h += 44; //for navigation bar
    
    return CGSizeMake(330, 330);
}
-(void)configureView
{
    NSMutableArray *subArray = [NSMutableArray array];
    self.dataSourceTableView = [NSMutableArray array];
    if (dictInfo) {
        
       
        NSDictionary *dictLocation = [dictInfo objectForKey:@"location"];

        NSString *address = [dictLocation objectForKey:@"address"];
        if (!address) {
            address =@"";
        }
        [subArray addObject:address];
        [subArray addObject:dictInfo];
        [dataSourceTableView addObject:subArray];
        [subArray removeAllObjects];
        subArray = [NSMutableArray arrayWithObject:@"Photos"];
        [dataSourceTableView addObject:subArray];
        [subArray removeAllObjects];
        subArray = [NSMutableArray arrayWithObject:@"Tips"];
        [dataSourceTableView addObject:subArray];
        
        
//        NSDictionary *dictLocation = [dictInfo objectForKey:@"location"];
//        [subArray addObject:[dictInfo objectForKey:@"name"]];
//        NSString *address = [dictLocation objectForKey:@"address"];
//        if (!address) {
//            address =@"";
//        }
//        NSString *distance = [dictLocation objectForKey:@"distance"];
//        if (!distance) {
//            distance =@"";
//        }
//        NSString *temp = [NSString stringWithFormat:@"Distance %@ m",distance];
//        [subArray addObject:temp];//add distance
//        temp = [NSString stringWithFormat:@"%@",address];
////        [subArray addObject:temp];
//        [subArray addObject:[dictInfo objectForKey:@"type"]];
//        [dataSourceTableView addObject:subArray];
//        [subArray removeAllObjects];
//        subArray =[NSMutableArray arrayWithObject:temp];
        
        
        
//        NSString *filePath = [NSString stringWithFormat:@"%@/favicon/%@.favicon.ico",
//                              [VIVUtilities applicationDocumentsDirectory],
//                              [dictInfo objectForKey:@"type"]];
//        
//        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
//        if (!image) {
//            //Image default
//            self.imageCagetory.image = [UIImage imageNamed:@"default_32.png"];
//            
//        }else {
//            self.imageCagetory.image = image;
//        }
        
    }
    [tableView reloadData];

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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setContentSizeForViewInPopover:CGSizeMake(330, 330)];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


#pragma TableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (dictInfo) {
        return 3;
    }
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (dictInfo) {
        if (section ==0) {
            return 2;
        }else {
            return 1;
        }
    }
    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return @"Place Info";
    }else {
        return @"";
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView12 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"table Info";
    
    UITableViewCell *cell = [tableView12 dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
//    NSMutableArray *subArray = [dataSourceTableView objectAtIndex:indexPath.section];
    if (dictInfo) {
        if (indexPath.section==0) {
            if (indexPath.row ==0) {
                //infor
                cell.textLabel.text = [dictInfo objectForKey:@"name"];
                NSDictionary *dictLocation = [dictInfo objectForKey:@"location"];
                NSString *distance = [dictLocation objectForKey:@"distance"];
                if (!distance) {
                    distance =@"";
                }
                NSString *temp = [NSString stringWithFormat:@"Distance %@ m",distance];
                cell.detailTextLabel.text = temp;
                NSString *filePath = [NSString stringWithFormat:@"%@/favicon/%@.favicon.ico",
                                      [VIVUtilities applicationDocumentsDirectory],
                                      [dictInfo objectForKey:@"type"]];
                
                UIImage *image = [UIImage imageWithContentsOfFile:filePath];
                if (!image) {
                    //Image default
                    cell.imageView.image = [UIImage imageNamed:@"default_32.png"];
                    
                }else {
                    cell.imageView.image = image;
                }

            }else {
                //address
                NSDictionary *dictLocation = [dictInfo objectForKey:@"location"];
                NSString *address = [dictLocation objectForKey:@"address"];
                if (!address) {
                    address =@"";
                }
                cell.detailTextLabel.text = address;
            }
            
        }else if (indexPath.section ==1) {
            //photos
            cell.textLabel.text = @"Photos";
        }else if (indexPath.section==2) {
            cell.textLabel.text =@"Tips";
        }
    }
        
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==1) {
        if (!requestMorePhoto) {
            requestMorePhoto = [[MorePhotosProvider alloc]init];
            requestMorePhoto.delegateMorePhotos = self;
        }
        if (!photosViewController) {
            photosViewController = [[PhotosViewController alloc]initWithNibName:@"PhotosViewControllerIpad" bundle:nil];
            photosViewController.delegate = self;
        }
        photosViewController.isBelongToPopOver = YES;
        [self.navigationController pushViewController:photosViewController animated:YES];
        [requestMorePhoto configURLByVenueID:[dictInfo objectForKey:@"id"]];
        [requestMorePhoto requestData];
       
        

    }else if (indexPath.section==2) {
        //Tips
        if (!tableViewTips) {
            self.tableViewTips = [[tableViewTipsControllerViewController alloc]initWithNibName:@"tableViewTipsViewControllerIpad" bundle:nil];
            tableViewTips.delegate =self;
        }
        if (!requestMoreTips) {
            requestMoreTips = [[MoreTisProvider alloc]init];
            requestMoreTips.delegateMoreTips  = self;
        }
        tableViewTips.isBelongToPopOver = YES;
        [self.navigationController pushViewController:tableViewTips animated:YES];
        [requestMoreTips configURLByVenueID:[dictInfo objectForKey:@"id"]];
        [requestMoreTips requestData];
    }
}
#pragma mark TableViewTips Delegate
-(void) backToDetaiVenueViewController
{
    if (self.tableViewTips) {
        [tableViewTips release];
        tableViewTips =nil;
        if (requestMoreTips) {
            if (requestMoreTips.loadingData==YES) {
                [requestMoreTips cancelDownload];
            }
        }
        if (arrayProvider) {
            for (ImagesProfileProvider *provider in arrayProvider ) {
                if (provider.loadingData) {
                    [provider cancelDownload];
                }
            }
        }
    }
}
#pragma mark MoreTips Provider Delegate
-(void)MoreTipsDidFinishParsing:(MoreTisProvider *)provider
{
    if (provider.resultContent) {
        /*note*/
        tableViewTips.arrayTips = [NSMutableArray arrayWithArray:provider.resultContent];
        [tableViewTips.tableView reloadData];
        if (arrayProvider) {
            [arrayProvider removeAllObjects];
        }else {
            self.arrayProvider = [NSMutableArray array];
        }
        for(NSDictionary *dictTip in provider.resultContent)
        {
            ImagesProfileProvider *imageProvider =[[ImagesProfileProvider alloc]init];
            NSDictionary *userTip = [dictTip objectForKey:@"userTip"];
            [imageProvider configURLByURL:[userTip objectForKey:@"photo"]];
            imageProvider.ImagesProfileDelegate =self;
            imageProvider.mode = ProviderModeImage;
            imageProvider.categoryName = [userTip objectForKey:@"id"];
            [arrayProvider addObject:imageProvider];
            [imageProvider release];
        }
        self.counter =0;
        [self loadOneByOneImage];
    }
}
-(void)MoreTipsdidFinishParsingWithError:(MoreTisProvider *)provider error:(NSError *)error
{
    
}
#pragma mark Copy Function
-(void) loadImageFromArrayProviderWithCounter:(NSInteger)index
{
    if (index >=0&&index< [arrayProvider count]) {
        ImagesProfileProvider *provider = [arrayProvider objectAtIndex:index];
        BOOL needDownload = YES;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/favicon/image/%@.jpg",
                                           [VIVUtilities applicationDocumentsDirectory],
                                           provider.categoryName]]) {
            needDownload = NO;
        }
        if (needDownload) {
            if (index>=1) {
                ImagesProfileProvider *preProvider = [arrayProvider objectAtIndex:(index-1)];
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

-(void) loadOneByOneImage
{
    if (arrayProvider) {
        [self loadImageFromArrayProviderWithCounter:counter];
    }
}

#pragma mark MorePhotoProvider Delegate
-(void)MorePhotosDidFinishParsing:(MorePhotosProvider *)provider
{
    if (provider.resultContent) {
        self.arrayFullPhotos = [NSMutableArray arrayWithArray:provider.resultContent];
        self.arrayProvider = [NSMutableArray array];
        photosViewController.arrayPhotos = arrayFullPhotos;
//        [photosViewController createBasicViewPhotos];
        [photosViewController createSubPhotosWithIndex:1];
        [photosViewController createBasicViewPhotosForPopOver:1];
        
        for(NSDictionary *dictPhoto in arrayFullPhotos)
        {
            ImagesProfileProvider *imageProvider =[[ImagesProfileProvider alloc]init];
            [imageProvider configURLByURL:[dictPhoto objectForKey:@"minUrl"]];
            imageProvider.ImagesProfileDelegate =self;
            imageProvider.mode = ProviderModeImage;
            imageProvider.categoryName = [dictPhoto objectForKey:@"id"];
            [arrayProvider addObject:imageProvider];
            [imageProvider release];
        }
        self.counter =0;
        [self loadOneByOneImage];
    }
    
}
-(void)MorePhotosdidFinishParsingWithError:(MorePhotosProvider *)provider error:(NSError *)error
{
    NSLog(@"Error loading more Photo");
}
#pragma mark ImageProvider Delegate
-(void)ImagesProfileProviderDidFinishParsing:(ImagesProfileProvider *)provider
{
    UIImage *image = [UIImage imageWithData:provider.returnData];
    if (!image) {
        //load icon defaul
    }else {
        
        NSString *filePath =[NSString stringWithFormat:@"%@/favicon/image/%@.jpg",
                             [VIVUtilities applicationDocumentsDirectory],
                             provider.categoryName];
        NSString *dirPath = [VIVUtilities applicationDocumentsDirectory];
        dirPath = [dirPath stringByAppendingString:@"/favicon/image"];
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
                    NSLog(@"Successful save data:%@", provider.categoryName);
                    //wire to file successful. release cache data
                    //                    [detailViewController reloadImageById:provider.categoryName];
//                    for (int i =0; i<[arrayFullPhotos count]; i++) {
//                        NSDictionary *dict = [arrayFullPhotos objectAtIndex:i];
//                        if ([provider.categoryName isEqual:[dict objectForKey:@"id"]]) {
////                            NSLog(@"index =%d",i);
//                        }
//                    }
                    if (photosViewController) {
                         [photosViewController reloadPhotoById:provider.categoryName];
                    }
                    if (tableViewTips) {
                        for (int i =0; i <[arrayProvider count]; i++) {
                            ImagesProfileProvider *imageProvider = [arrayProvider objectAtIndex:i];
                            if ([imageProvider.categoryName isEqual:provider.categoryName]) {           
                                
                                NSIndexPath *index =  [NSIndexPath indexPathForRow:i inSection:0];
                                
                                NSArray *array = [NSArray arrayWithObject:index];
                                [tableViewTips.tableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationMiddle];
                                break;

                                
                            }
                        }
                    }
                   
                    //                        [detailViewController configureView];
                    provider.returnData = [NSData data];
                }
            }                
        }
        
        
    }
    counter ++;
    [self loadOneByOneImage];
    
}
-(void)ImagesProfileProviderDidFinishWithError:(NSError *)error provider:(ImagesProfileProvider *)provider
{
    provider.finishLoad = YES;
    counter ++;
    [self loadOneByOneImage];
    
}
#pragma mark Photos View Controller Delegate
-(void) rePresentPopOverFromPhotosViewController
{
    [self.delegate rePresentPopOVerFromDetailVenue];
}
-(void)requestMoreProviderWithSubArrayPhotos:(NSMutableArray *)subArrayPhotos
{
    if (arrayProvider) {
        for(ImagesProfileProvider *imageProvider in arrayProvider)
        {
            if (imageProvider.loadingData==YES) {
                [imageProvider cancelDownload];
            }
            
        }
        
    }else {
        self.arrayProvider =[NSMutableArray array];
    }
    for(NSDictionary *dictPhoto in subArrayPhotos)
    {
        ImagesProfileProvider *imageProvider =[[ImagesProfileProvider alloc]init];
        [imageProvider configURLByURL:[dictPhoto objectForKey:@"minUrl"]];
        imageProvider.ImagesProfileDelegate =self;
        imageProvider.mode = ProviderModeImage;
        imageProvider.categoryName = [dictPhoto objectForKey:@"id"];
        [arrayProvider addObject:imageProvider];
        [imageProvider release];
    }
    self.counter =0;
    [self loadOneByOneImage];
}
-(void)backToDetailVenueViewControllerFromPhotosView
{
    
    if (requestMorePhoto) {
        if (requestMorePhoto.loadingData==YES) {
            [requestMorePhoto cancelDownload];
            
        }
    }
    if (arrayProvider) {
        for (ImagesProfileProvider *provider in arrayProvider ) {
            if (provider.loadingData) {
                [provider cancelDownload];
            }
        }
    }
    if (photosViewController) {
        [photosViewController release];
        photosViewController = nil;
    }
}
-(void) loadDetailPhotos:(PhotosScrollViewController *)photosScrollView
{
    [self.delegate loadDetailPhotoFromPopOver:photosScrollView];
}
-(void) closeMorePhoto
{
    //not implement
}

@end
