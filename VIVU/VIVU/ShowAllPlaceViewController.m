//
//  ShowAllPlaceViewController.m
//  VIVU
//
//  Created by MacPro on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#define NameTag   1000
#define ImageTag  10001
#define SubDetail 10002
#define Button_Tag_Offset        10006
#define TAG_DETAIL_VIEW_CONTROLLER 10007

#import "ShowAllPlaceViewController.h"

@interface ShowAllPlaceViewController ()

@end

@implementation ShowAllPlaceViewController
@synthesize tableView;
@synthesize dataSourceGroupTableView;
@synthesize delegate;
@synthesize dataSourceTableView;
@synthesize arraySourceFavicon;
@synthesize cheatView;
@synthesize requestDetaiLocation;
@synthesize detailViewController;
@synthesize arrayImages;
@synthesize arrayProvider;
@synthesize counter;

-(void)dealloc{

    
    [arrayProvider release];
    [arrayImages release];
    [detailViewController release];
    delegate =nil;
    [requestDetaiLocation release];
    [cheatView release];
    [dataSourceGroupTableView release];
    [arraySourceFavicon release];
    [tableView release];
    [dataSourceTableView release];
    [super dealloc];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(CGSize)sizeInPopoverView
{
    int count = [tableView numberOfRowsInSection:0];
    CGFloat h = count * tableView.rowHeight;
//    h += 44; //for navigation bar
    if (h>45*5) {
        h=45*5;
    }
    return CGSizeMake(320-20, h);
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
                if (![[provider getCurrentURL] rangeOfString:@"vietnamagilemobile"].length>0 ) {
                    [provider requestData];
                }
                
            }
        
            
        }
        
    }
    [self.tableView reloadData];
    
}
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
-(void) initArrayProvider
{
    if (!arrayProvider) {
        self.arrayProvider =[NSMutableArray array];
    }else {
        [arrayProvider removeAllObjects];
    }
    for (int i=0; i<[arrayImages count]; i++) {
        
        
        NSDictionary *dictImage  = [arrayImages objectAtIndex:i];
        if ([dictImage objectForKey:@"url"]) {
            ImagesProfileProvider *provider =[[ImagesProfileProvider alloc]init];
            provider.ImagesProfileDelegate = self;
            provider.categoryName = [dictImage objectForKey:@"id"];
            provider.mode = ProviderModeImage;
            if ([[dictImage objectForKey:@"isUserMostActive"]boolValue] ==YES) {
                provider.mode =ProvierModeUserMostActive;
                if ([dictImage objectForKey:@"isUserMostActive"]) {
                    [detailViewController reloadAvatarMostActive];               
                }
            }
            NSString *url = [dictImage objectForKey:@"url"];
            if ([[dictImage objectForKey:@"isBigImage"]boolValue]==YES) {
                
                 
            }
            [provider configURLByURL:url];

            [arrayProvider addObject:provider];
            [provider release];

        }
                  
    }

        
   

}
-(void)loadOneByOneImage
{
    if (detailViewController) {
//        [detailViewController configureView];
    }  
    if (arrayProvider) {
         [self loadImageFromArrayProviderWithCounter:counter];
    }
   
    if (detailViewController) {
//        [detailViewController configureView];
    }
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataSourceTableView = nil;
        self.dataSourceGroupTableView = nil;

    }
    return self;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    CGRect ff = self.view.frame;
    ff.size.height = self.view.frame.size.height -44;
    self.view.frame = ff;
    [self.delegate disMissTableViewController:nil];
    
}
-(void) convertDataSourceToGroup
{
     if (self.dataSourceTableView) {
         dataSourceGroupTableView = [NSMutableArray array];
         SlideGroupSource *group = nil;
         for (NSDictionary *dictDetail in self.dataSourceTableView) {
             if ([dictDetail isKindOfClass:[NSDictionary class]]) {
                 group = [SlideGroupSource findGroupName:[dictDetail objectForKey:@"parentCategory"] inArray:dataSourceGroupTableView];
                 if (!group) {
                     group = [[SlideGroupSource alloc]initWithGroupName:[dictDetail objectForKey:@"parentCategory"]];
                     group.isExpanded = YES;
                     [dataSourceGroupTableView addObject:group];
                     [group release];
                     
                 }else {
                     [group.childs addObject:dictDetail];
                 }
                 
                 
             }
             

             }         

    }
    self.dataSourceTableView = dataSourceGroupTableView;
}

-(void)modifyWatchlist:(id)sender
{
    NSInteger tag = [sender tag];
    NSInteger count = tag - Button_Tag_Offset;
    SlideGroupSource *parent = [dataSourceTableView objectAtIndex:count];
    parent.isExpanded = !parent.isExpanded;
    [self.tableView reloadData];
}
#pragma mark TableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSourceGroupTableView) {
        SlideGroupSource *group = [self.dataSourceTableView objectAtIndex:section];
        if ([group isKindOfClass:[SlideGroupSource class]]) {
            if (group.isExpanded) {
                return  [group.childs count];
            }else {
                return 0;
            }
        }
    }else {
        return [self.dataSourceTableView count]; 
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.dataSourceGroupTableView) {
        return 22;
    }else {
        return 0;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.dataSourceGroupTableView) {
        if ([dataSourceGroupTableView count]>0) {
            SlideGroupSource *group = [dataSourceGroupTableView objectAtIndex:section];
            if ([group isKindOfClass:[SlideGroupSource class]]) {
                return group.groupName;
            }
            
        }
        
    }
    return @"Default";
}
-(UIView *)tableView:(UITableView *)tableView12 viewForHeaderInSection:(NSInteger)section
{
  
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 22)];
   header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"collapse_bar"]];
//    header.backgroundColor = [UIColor clearColor];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, tableView.frame.size.width - 20, 22)];
    title.backgroundColor = [UIColor clearColor];
    title.font = [UIFont boldSystemFontOfSize:14];
    title.textColor = [UIColor colorWithRed:121.0f/255.0f green:127.0f/255.0f blue:144.0f/255.0f alpha:1];
    title.shadowColor = [UIColor colorWithRed:57.0f/255.0f green:64.0f/255.0f blue:85.0f/255.0f alpha:1];
    title.shadowOffset = CGSizeMake(0, 1);
    title.textAlignment = UITextAlignmentLeft;
    title.text = [self tableView:tableView titleForHeaderInSection:section];
    [title sizeToFit];
    [header addSubview:title];
    CGRect tf = title.frame;
    tf.origin.y = (22 - tf.size.height) * 0.5f;
    title.frame = tf;
    [title release];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 22)];
    
    SlideGroupSource *parent = [dataSourceGroupTableView objectAtIndex:section];
    if ([parent isKindOfClass:[SlideGroupSource class]]) {
        if (parent.isExpanded) {
            [button setImage:[UIImage imageNamed:@"btn_02"] forState:UIControlStateNormal];
        }else {
            [button setImage:[UIImage imageNamed:@"btn_01"] forState:UIControlStateNormal];
        }

    }
    [button setTag:(Button_Tag_Offset + section)];
    [button addTarget:self action:@selector(modifyWatchlist:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:button];
    [button release];
    return [header autorelease];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataSourceGroupTableView){
        return [dataSourceTableView count];
    }else {
        return 1;
    }
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

    NSDictionary *dictDetail = nil;
    id item = [dataSourceTableView objectAtIndex:indexPath.section];
    if ([item isKindOfClass:[SlideGroupSource class]]) {
        dictDetail = [((SlideGroupSource *)item).childs objectAtIndex:indexPath.row];
    }else{
        dictDetail = [dataSourceTableView objectAtIndex:indexPath.row];
    }
    

    if ([dictDetail isKindOfClass:[NSDictionary class]]) {
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

    }
    
      
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!requestDetaiLocation) {
        requestDetaiLocation = [[DetailPlaceProvider alloc]init];
        requestDetaiLocation.delegateDetail =self;
    }
    if (dataSourceGroupTableView) {
        //
        NSInteger section = indexPath.section;
        id item = [dataSourceTableView objectAtIndex:section];
        if ([item isKindOfClass:[SlideGroupSource class]]) {
            NSDictionary *dictInfo = [((SlideGroupSource *)item).childs objectAtIndex:indexPath.row];
            if (dictInfo) {
//                [self.delegate disMissTableViewController:nil];
                [self.delegate addDetailPlaceView:dictInfo];
            }
           
        }
    
    }else {
        // ko group 
        if (!detailViewController) {
            detailViewController = [[DetailPlaceViewControllerViewController alloc]initWithNibName:@"DetailPlaceViewControllerViewController" bundle:nil];
            detailViewController.delegate =self;
        } 
        
        NSDictionary *dictInfo = [dataSourceTableView objectAtIndex:indexPath.row];
        detailViewController.dictInfo = dictInfo;
        [detailViewController configureView];
        [self.view addSubview:detailViewController.view];
        [self.view bringSubviewToFront:detailViewController.view];
        CGRect frameView = CGRectMake(0, 500, 320, 460);
//        self.view.frame = frameView;
//        CGRect frame = detailViewController.view.frame;
//        frame.origin.y =500;
//        frame.size.height = detailViewController.view.frame.size.height +44;
        detailViewController.view.frame = frameView;
        CGRect ff = self.view.frame;
        ff.size.height = self.view.frame.size.height+44;
        self.view.frame = ff;
        [UIView beginAnimations:@"Show Detail Place" context:nil];
        frameView.origin.y =0;
        detailViewController.view.frame = frameView;//
        [UIView commitAnimations];
        

        [requestDetaiLocation configURLByItemId:[dictInfo objectForKey:@"id"]];
        [requestDetaiLocation requestData];
    }
    
}
#pragma mark DetaiViewController Delegare
-(void)disMissDetailViewController
{
        [UIView beginAnimations:@"Hide Detail Place" context:nil];
        CGRect frame = detailViewController.view.frame;
        frame.origin.y =500;
        detailViewController.view.frame =frame;
        [UIView commitAnimations];
    UIView *subView = [self.view viewWithTag:TAG_DETAIL_VIEW_CONTROLLER];
    [subView removeFromSuperview];
    self.detailViewController = nil;
    [self.tableView reloadData];

}
#pragma mark Detail Place Delegate
-(void) DetailPlaceDidFinishParsing:(DetailPlaceProvider *)provider
{
    if (provider.resultContent) {
        self.arrayImages = [NSMutableArray array];
        BOOL isUserMostActive = YES;
        BOOL isBigImage = NO;
        NSDictionary *dictResult = [provider.resultContent objectAtIndex:0];
        NSDictionary *userMostAcvite = [dictResult objectForKey:@"userMostActive"];
        if (userMostAcvite&& [userMostAcvite objectForKey:@"user"]) {
            
            detailViewController.userMostActive = userMostAcvite;
        }
        NSDictionary *userDict = [userMostAcvite objectForKey:@"user"];
        if (userDict) {
            NSString *userID = [userDict objectForKey:@"id"];
            NSString *userPhoto = [userDict objectForKey:@"photo"];
            isUserMostActive = YES;
            isBigImage = NO;
            NSMutableDictionary *dictUserImage = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                  userID,@"id",
                                                  userPhoto,@"url",
                                                  nil];
            [dictUserImage setValue:[NSNumber numberWithBool:isUserMostActive] forKey:@"isUserMostActive"];
            [dictUserImage setValue:[NSNumber numberWithBool:isBigImage] forKey:@"isBigImage"];
            
            [arrayImages addObject:dictUserImage];
            

        }else {
            //ko co check in
            [detailViewController reloadAvatarMostActive];
        }
        NSMutableArray *arraytips = [dictResult objectForKey:@"tips"];
        for (NSDictionary *dictTipItem in arraytips)
        {
            isUserMostActive = FALSE;
            isBigImage = YES;
            NSString *tipId = [dictTipItem objectForKey:@"idTip"];
            NSString *tipUrl= [dictTipItem objectForKey:@"url"];
            
            NSMutableDictionary *tipImage = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      tipId,@"id",
                                      tipUrl,@"url",
                                      nil];
            [tipImage setValue:[NSNumber numberWithBool:isUserMostActive] forKey:@"isUserMostActive"];
            [tipImage setValue:[NSNumber numberWithBool:isBigImage] forKey:@"isBigImage"];
            [arrayImages addObject:tipImage];
            NSDictionary *dictUser = [dictTipItem objectForKey:@"userTip"];
           
            
            if (dictUser) {
                isBigImage = NO;
                NSMutableDictionary *dictImage = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                               [dictUser objectForKey:@"id"],@"id",
                                               [dictUser objectForKey:@"photo"],@"url",
                                                tipId,@"tip",
                                               nil];
                [dictImage setValue:[NSNumber numberWithBool:isUserMostActive] forKey:@"isUserMostActive"];
                [dictImage setValue:[NSNumber numberWithBool:isBigImage] forKey:@"isBigImage"];
                [arrayImages addObject:dictImage];

            }
        }
        NSMutableArray *arrayPhotos = [dictResult objectForKey:@"photos"];
        for( NSDictionary *dictPhoto in arrayPhotos)
        {
            isUserMostActive = NO;
            isBigImage = YES;
            NSMutableDictionary *tempDictPhoto = [NSMutableDictionary dictionaryWithDictionary:dictPhoto];
            [tempDictPhoto setValue:[NSNumber numberWithBool:isUserMostActive] forKey:@"isUserMostActive"];
            [tempDictPhoto setValue:[NSNumber numberWithBool:isBigImage] forKey:@"isBigImage"];
            [arrayImages addObject:tempDictPhoto];
        }
        if ([arrayPhotos count]==0) {
            
        }
        if (detailViewController) {
            [detailViewController configureView];
        }
        detailViewController.arrayTips =arraytips;
        detailViewController.arrayImages =arrayPhotos;
        detailViewController.numberPhotos = [[dictResult objectForKey:@"countPhoto"]intValue];
        NSLog(@"%d",[detailViewController.arrayImages count]);
       [detailViewController createBasicViewDetail];
        [self initArrayProvider];
        self.counter =0;
        [self loadOneByOneImage];
        
        
        
    }
}
#pragma mark ImagesProfilesProvider Delegate
-(void)ImagesProfileProviderDidFinishParsing:(ImagesProfileProvider *)provider
{
    if (provider.mode ==ProviderModeIcon) {
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
                        NSLog(@"Successful save data:%@", provider.categoryName);
                        
                        //wire to file successful. release cache data
                        provider.returnData = [NSData data];
                    }
                }                
            }
            
            
            
                //            ImagesProfileProvider *provider = [item objectForKey:@"favicon"];
                //            if ([provider isEqual:provider]) {
                //                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                //            }
          
            
            
        }
        //    [self loadOneByOneIcon];
    }else if (provider.mode==ProviderModeImage||provider.mode == ProvierModeUserMostActive) {
        provider.loadingData = NO;
       
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
                        [detailViewController reloadImageById:provider.categoryName];
//                        [detailViewController configureView];
                        provider.returnData = [NSData data];
                    }
                }                
            }
            if (provider.mode ==ProvierModeUserMostActive) {
                [detailViewController reloadAvatarMostActive];
            }
                       
            
        }
         counter ++;
       [self loadOneByOneImage];
    }
   
    
}
-(void) ImagesProfileProviderDidFinishWithError:(NSError *)error provider:(ImagesProfileProvider *)provider
{
    NSLog(@"load image throw error :%@",[provider getCurrentURL]);
    provider.finishLoad = YES;
    counter ++;
    [self loadOneByOneImage];
    if (provider.mode== ProvierModeUserMostActive) {
        [detailViewController reloadAvatarMostActive];
    }
    
}
@end
