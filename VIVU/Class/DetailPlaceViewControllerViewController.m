//
//  DetailPlaceViewControllerViewController.m
//  VIVU
//
//  Created by MacPro on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#define FIRST_ORIGIN_X_VIEW_DETAIL  99

#define FLEXIBLE_SPACE               10
#define WIDTH_IMAGE                  60
#define WIDTH_HEIGHT_AVATA           55
#define TAG_DETAIL_VIEW_IMAGE        100
#define TAG_LATEST_VIEW_FRAME_DETAIL 101
#define TAG_LATEST_IMAGE_BUTTON      102
#define TAG_IMAGE_NORMAL             103
#define TAG_IMAGE_VIEW               104
#define TAG_AVATA                    105 
#define TAG_TIPS                     106


#import "DetailPlaceViewControllerViewController.h"
#include <QuartzCore/QuartzCore.h>


@interface DetailPlaceViewControllerViewController ()

@end

@implementation DetailPlaceViewControllerViewController
@synthesize  dictInfo;
@synthesize lblAddress;
@synthesize lblDistant;
@synthesize lblNameLocation;
@synthesize imageCagetory;
@synthesize btnClose;
@synthesize btnPhoto;
@synthesize userMostActive;
@synthesize lblUserName;
@synthesize checkInCount;
@synthesize imageUser;
@synthesize delegate;
@synthesize arrayImages;
@synthesize arrayTips;
@synthesize finishLoadImage;

@synthesize faviconMostActive;
@synthesize viewDetail;
@synthesize scrollView;
@synthesize imgViewController;
@synthesize btnTips;
@synthesize tableViewTips;
@synthesize requestMorePhotos;
@synthesize photosViewController;
@synthesize arrayFullPhotos;
@synthesize arrayProvider;
@synthesize counter;
@synthesize numberPhotos;
@synthesize photosDetailView;


-(void)dealloc
{
    [photosDetailView release];
    [arrayProvider release];
    [arrayFullPhotos release];
    [photosViewController release];
    [requestMorePhotos release];
    [tableViewTips release];
    [btnTips release];
    [btnPhoto release];
    [imgViewController release];
    [scrollView release];
    [viewDetail release];
    [faviconMostActive release];

    [arrayTips release];
    [arrayImages release];
    delegate =nil;
    [imageUser release];
    [userMostActive release];
    [btnClose release];
    [lblNameLocation release];
    [lblAddress release];
    [lblDistant release];
    [imageCagetory release];
    [dictInfo release];
    [super dealloc];
}

#pragma mark App LifeCycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        dictInfo = nil;
        userMostActive = nil;
        arrayImages = nil;
        arrayTips = nil;
        finishLoadImage = NO;
        counter =0;
        numberPhotos =0;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.btnPhoto.hidden =YES;
    self.btnTips.hidden = YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
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

#pragma mark View Load
-(IBAction)closeDetailView:(id)sender
{

    [self.delegate closeRequestFromDetailView];
    [self.delegate disMissDetailViewController];
}
-(void)reloadImageById:(NSString *)Id
{
    NSInteger index =0;
    BOOL found = NO;
    for (int i =0; i< [arrayImages count]; i++) {
        NSDictionary *dictImage = [arrayImages objectAtIndex:i];
        if ([[dictImage objectForKey:@"id"] isEqual:Id]) {
            index = i;
            found = YES;
            break;
            
        }
    }
    if ([arrayImages count]>0) {
        int tag = index+100000;
        UIView *subView = [self.viewDetail viewWithTag:tag];
        if ([subView isKindOfClass:[CustomeButton class]]) {
            if ([((CustomeButton*)subView).imageId isEqual:Id]) {
                NSString *filePath = [NSString stringWithFormat:@"%@/favicon/image/%@.jpg",
                                      [VIVUtilities applicationDocumentsDirectory],
                                      Id];
                found = YES;
                UIImage *image = [UIImage imageWithContentsOfFile:filePath];
                if (image) {
                    [((CustomeButton*)subView) setImage:image forState:UIControlStateNormal];
                }else {
                    image = [UIImage imageNamed:@"default_32.png"];
                    [((CustomeButton*)subView) setImage:image forState:UIControlStateNormal];
                }
                
            }
        }

    }
    if (!found&& [arrayTips count]>0) {
        for (int i=0; i<[arrayTips count]; i++) {
            NSDictionary *dictTip = [arrayTips objectAtIndex:i];
            NSDictionary *userTip =[dictTip objectForKey:@"userTip"];
            if ([[userTip objectForKey:@"id"] isEqual:Id]) {
                found = YES;
                NSIndexPath *index =  [NSIndexPath indexPathForRow:i inSection:0];
                
                NSArray *array = [NSArray arrayWithObject:index];
                [tableViewTips.tableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationMiddle];
//                break;
            }
        }
    }
}
-(void) reloadAvatarMostActive
{
    if (self.userMostActive) {
        NSString *count = [NSString stringWithFormat:@"%@ checkins",[userMostActive objectForKey:@"count"]];
        checkInCount.text = count;
        NSDictionary *user = [userMostActive objectForKey:@"user"];
        NSString *firstName = [user objectForKey:@"firstName"];
        if (!firstName) {
            firstName= @"";
        }
        NSString *lastName = [user objectForKey:@"lastName"];
        if (!lastName) {
            lastName= @"";
        }
        NSString *name = [NSString stringWithFormat:@" %@ %@",firstName,lastName];
        lblUserName.text = name;
        NSString *filePath = [NSString stringWithFormat:@"%@/favicon/image/%@.jpg",
                              [VIVUtilities applicationDocumentsDirectory],
                              [user objectForKey:@"id"]];
        
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        UIView *subView = [self.viewDetail viewWithTag:TAG_AVATA];
        if (subView) {
            ((UIImageView*)subView).image =image;
        }
        
        
        
    }else {
        CGRect frame = self.btnPhoto.frame;
        frame.origin.y =0;
        self.btnPhoto.frame = frame;
        [self.imageUser  setHidden:YES];
        self.lblUserName.hidden = YES;
        [self.checkInCount setHidden: YES];
        [self.faviconMostActive setHidden:YES];
    }

}
-(void) addBtnPhototViewDetail:(NSInteger )y
{
    for (int i =0; i< [arrayImages count]; i++) {
        NSDictionary *dictImage = [arrayImages objectAtIndex:i];
        
        NSString *filePath = [NSString stringWithFormat:@"%@/favicon/image/%@.jpg",
                              [VIVUtilities applicationDocumentsDirectory],
                              [dictImage objectForKey:@"id"]];
        
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        
        if (i< 4) {
            
            CGRect frame = CGRectMake(20+i*(FLEXIBLE_SPACE+WIDTH_IMAGE), y+10, WIDTH_IMAGE, WIDTH_IMAGE);
            CustomeButton *btn = [[CustomeButton alloc]initWithFrame:frame];
            if (!image) {
                image = [UIImage imageNamed:@"default_32.png"];
            }
            [btn setImage:image forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(showDetailPhoto:) forControlEvents:UIControlEventTouchUpInside];
            btn.imageId = [dictImage objectForKey:@"id"];
//            NSLog(@"index i =%d -- id = %@--tag = %@",i,[dictImage objectForKey:@"id"],);
            btn.url =[dictImage objectForKey:@"url"];
            NSInteger tag =i+100000;
            [btn setTag:tag];
            [self.viewDetail addSubview:btn];
            [self.viewDetail bringSubviewToFront:btn];
            [btn release];
        }
    }
    if ([arrayImages count]>4) {
        if (!imgViewController) {
            self.imgViewController = [[ImagesViewController alloc]initWithNibName:@"ImagesViewController" bundle:nil];
            imgViewController.delegate =self;
        }
        imgViewController.arrayPhotos = arrayImages;
        UIButton *btnMorePhotos = [[UIButton alloc]init];
        
        CGRect frame ;
        int i = 0+100000;
        CustomeButton *btn = (CustomeButton*)[self.viewDetail viewWithTag:i];
        if (btn) {
            frame = btn.frame;
            frame.origin.y = btn.frame.origin.y + WIDTH_IMAGE+10;
            frame.size.height = 25;
            frame.size.width = 300;
        }else {
            frame = CGRectMake(10, 130, 300, 30);
        }
        btnMorePhotos.frame = frame;
        [btnMorePhotos setTitle:@"Show More Photos" forState:UIControlStateNormal];
        [btnMorePhotos addTarget:self action:@selector(showMorePhotos:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.viewDetail addSubview:btnMorePhotos];
        [btnMorePhotos release];
        
    }

}
-(void) addTipsToViewDetail:(NSInteger)y
{
    UIView *viewTips = [[UIView alloc]initWithFrame:CGRectMake(10, y+10,self.viewDetail.frame.size.width-20, self.viewDetail.frame.size.height-(y+10)-10)];
  
    if (!tableViewTips) {
        tableViewTips = [[tableViewTipsControllerViewController alloc]initWithNibName:@"tableViewTipsControllerViewController" bundle:nil];
        tableViewTips.delegate =self;
    }
    CGRect frameFix = viewTips.frame;
    frameFix.size.height = [arrayTips count]*60;
    viewTips.frame =frameFix;
    tableViewTips.arrayTips = arrayTips;
    [tableViewTips.tableView reloadData];

    tableViewTips.view.frame =viewTips.frame;
    CGRect frame = tableViewTips.view.frame;
//    CGRect ff = frame;
//    ff.size.height = frame.size.height -60;
//    tableViewTips.tableView.frame = frame;
    CGRect ff = tableViewTips.tableView.frame;
    ff.size = frame.size;
    tableViewTips.tableView.frame = ff;
    tableViewTips.tableView.bounds = ff;
    [tableViewTips.view setTag:TAG_TIPS];
    [tableViewTips.view.layer setBorderWidth:2.0f];
    [tableViewTips.view.layer setCornerRadius:10.0f];
    [tableViewTips.view.layer setMasksToBounds:YES];
    [tableViewTips.view.layer setBorderColor:[UIColor greenColor].CGColor];
    [self.viewDetail addSubview:tableViewTips.view];
//    [self.viewDetail addSubview:tableViewTips.view];
 
    UIView *tempView = [self.viewDetail viewWithTag:TAG_TIPS];
    if (tempView) {
        [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, tempView.frame.origin.y +tempView.frame.size.height+100)];
        
        //            [self.scrollView setBounds:frame];
    }

}
-(void) createBasicViewDetail
{
    if (self.userMostActive) {
        //-check-in
        NSString *count = [NSString stringWithFormat:@"%@ checkins",[userMostActive objectForKey:@"count"]];
        checkInCount.text = count;
        NSDictionary *user = [userMostActive objectForKey:@"user"];
        NSString *firstName = [user objectForKey:@"firstName"];
        if (!firstName) {
            firstName= @"";
        }
        NSString *lastName = [user objectForKey:@"lastName"];
        if (!lastName) {
            lastName= @"";
        }
        NSString *name = [NSString stringWithFormat:@" %@ %@",firstName,lastName];
        lblUserName.text = name;
        NSString *filePath = [NSString stringWithFormat:@"%@/favicon/image/%@.jpg",
                              [VIVUtilities applicationDocumentsDirectory],
                              [user objectForKey:@"id"]];
        
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        UIImageView *userAvatar = [[UIImageView alloc]initWithFrame:self.imageUser.frame];
        if (!image) {
            userAvatar.image = [UIImage imageNamed:@"default_32.png"];
            
        }else {
            userAvatar.image = image;
        }
        self.imageUser.hidden = YES;
        [userAvatar setTag:TAG_AVATA];
        [self.viewDetail addSubview:userAvatar];
        [userAvatar release];
        if ([arrayImages count]>0) {
            CGRect frame  = self.btnPhoto.frame;
            [self addBtnPhototViewDetail:(frame.origin.y+23)];
        }else {
            //no photo in veneu
        }
        
    }else if ([arrayImages count]>0) {
        CGRect frame = self.btnPhoto.frame;
        frame.origin.y =0;
        self.btnPhoto.frame = frame;
        [self addBtnPhototViewDetail:(frame.origin.y+30)];
    }else if ([arrayImages count]==0) {
        CGRect frame = self.btnPhoto.frame;
        frame.origin.y =0;
        self.btnPhoto.frame = frame;
        
    }
    CGRect frame = self.btnPhoto.frame;
    frame.origin.y = self.btnPhoto.frame.origin.y+ self.btnPhoto.frame.size.height;
    if ([arrayImages count]>0 && [arrayImages count]<=4) {
        frame.origin.y =self.btnPhoto.frame.origin.y+ self.btnPhoto.frame.size.height +  2*10 + WIDTH_IMAGE;
    }else if ([arrayImages count]>4) {
        frame.origin.y = self.btnPhoto.frame.origin.y+ self.btnPhoto.frame.size.height +  2*10 + WIDTH_IMAGE +30;
    }
    self.btnTips.frame = frame;
    [self addTipsToViewDetail:self.btnTips.frame.origin.y+23];
    self.btnTips.hidden = NO;
    self.btnPhoto.hidden = NO;
    
}
-(void)configureView
{
    if (dictInfo) {
        NSDictionary *dictLocation = [dictInfo objectForKey:@"location"];
        self.lblNameLocation.text = [dictInfo objectForKey:@"name"];
        NSString *address = [dictLocation objectForKey:@"address"];
        if (!address) {
            address =@"";
        }
        NSString *distance = [dictLocation objectForKey:@"distance"];
        if (!distance) {
            distance =@"";
        }
        NSString *temp = [NSString stringWithFormat:@"Distance %@ m",distance];
        self.lblDistant.text = temp;
        temp = [NSString stringWithFormat:@"%@",address];
        self.lblAddress.text = temp;
        NSString *filePath = [NSString stringWithFormat:@"%@/favicon/%@.favicon.ico",
                              [VIVUtilities applicationDocumentsDirectory],
                              [dictInfo objectForKey:@"type"]];
        
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        if (!image) {
            //Image default
            self.imageCagetory.image = [UIImage imageNamed:@"default_32.png"];
            
        }else {
            self.imageCagetory.image = image;
        }

    }
    if (arrayImages) {
        //text file /*note*/
                
    }

}
-(void) showDetailImage:(id)sender
{
//    NSString *imageId = ((CustomeButton *)sender).imageId;
//    NSString *url = ((CustomeButton *)sender).url;
//    DetailImageViewController *imageViewController = [[DetailImageViewController alloc]initWithNibName:@"DetailImageViewController" bundle:nil];
//    imageViewController.delegate =self;
//    imageViewController.currentImageId = imageId;
//    [imageViewController.view setTag:TAG_DETAIL_VIEW_IMAGE];
//    [self.view addSubview:imageViewController.view];
//    [self.view bringSubviewToFront:imageViewController.view];
//    [imageViewController loadImageFromID:imageId url:url];
//    CGRect frame = self.view.frame;
//    frame.origin.y =500;
//    imageViewController.view.frame = frame;
//    [UIView beginAnimations:@"Show Detail Image" context:nil];
//    frame.origin.y =0;
//    imageViewController.view.frame = frame;
//    [UIView commitAnimations];
    
    
}

#pragma mark XXX
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
            if (photosViewController) {
                [photosViewController reloadPhotoById:provider.categoryName];
            }
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
-(void) showDetailPhoto:(id)sender
{
    if (!photosDetailView) {
        photosDetailView =[[PhotosScrollViewController alloc]initWithNibName:@"PhotosScrollViewController" bundle:nil];
//        photosDetailView.delegate = self;
    }
    if ([arrayImages count]>4) {
        NSRange range; 
        range.length = [arrayImages count]-4;
        range.location = 4;
        [arrayImages removeObjectsInRange:range];
    }
    photosDetailView.modalPresentationStyle = UIModalPresentationFullScreen;
    photosDetailView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    photosDetailView.arrayPhotos =arrayImages;
    photosDetailView.currentPhotoId = ((CustomeButton *)sender).imageId;
    [self presentModalViewController:photosDetailView animated:YES];
}

#pragma mark PhotoScrollView Controller
-(void)showMorePhotos:(id)sender
{
       if (![VIVUtilities isIpadDevice]) {
        //Iphone Device
           if (photosViewController) {
               [photosViewController release];
               photosViewController = nil;
           }
           photosViewController = [[PhotosViewController alloc]initWithNibName:@"PhotosViewController" bundle:nil];
           
           photosViewController.delegatePhotosView = self;
           photosViewController.modalPresentationStyle = UIModalPresentationFullScreen;
           photosViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
           photosViewController.numberPhotos =self.numberPhotos;
           
           [self presentModalViewController:photosViewController animated:YES];
           //    [photosViewController createBasicViewPhotos];
           if (!requestMorePhotos) {
               requestMorePhotos = [[MorePhotosProvider alloc]init];
               requestMorePhotos.delegateMorePhotos = self;
           }
           [requestMorePhotos configURLByVenueID:[dictInfo objectForKey:@"id"]];
           [requestMorePhotos requestData];

    }else {
        //ipad
//        if (!photosViewController) {
//            photosViewController = [[PhotosViewController alloc]initWithNibName:@"PhotosViewController" bundle:nil];
//        }
//        photosViewController.modalPresentationStyle = UIModalPresentationFullScreen;
//        photosViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//        photosViewController.numberPhotos =self.numberPhotos;
//        
//        [self presentModalViewController:photosViewController animated:YES];
//        //    [photosViewController createBasicViewPhotos];
//        if (!requestMorePhotos) {
//            requestMorePhotos = [[MorePhotosProvider alloc]init];
//            requestMorePhotos.delegateMorePhotos = self;
//        }
//        [requestMorePhotos configURLByVenueID:[dictInfo objectForKey:@"id"]];
//        [requestMorePhotos requestData];

    }
    
    
}
#pragma mark -
#pragma mark Table View Tips Delegate
-(void)presentPhotosViewFromtips:(PhotosViewController *)photosView
{
    [self presentModalViewController:photosView animated:YES];
    
}
#pragma mark CloseRequestProvider Delegate
-(void) closeRequestImageProvider
{
    for (ImagesProfileProvider *provider in arrayProvider) {
        if (provider.loadingData ==YES) {
            [provider cancelDownloadProvider];
        }
    }
}
-(void)requestMoreProviderWithSubArrayPhotos:(NSMutableArray *)subArrayPhotos
{
    //not implement here
    if (self.arrayProvider) {
        for (ImagesProfileProvider *imageProvider in arrayProvider) {
            if (imageProvider.loadingData==YES) {
                [imageProvider cancelDownloadProvider];
            }
        }
    }else {
        self.arrayProvider = [NSMutableArray array];
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
#pragma mark MorePhotoProvider Delegate
-(void)MorePhotosDidFinishParsing:(MorePhotosProvider *)provider
{
    if (provider.resultContent) {
        self.arrayFullPhotos = [NSMutableArray arrayWithArray:provider.resultContent];
        self.arrayProvider = [NSMutableArray array];
        photosViewController.arrayPhotos = arrayFullPhotos;
        [photosViewController createSubPhotosWithIndex:1];
        [photosViewController clearAllImageInView];
        
        [photosViewController createBasicViewPhotosForPopOver:1];
        for(NSDictionary *dictPhoto in photosViewController.subArrayPhotos)
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
                    for (int i =0; i<[arrayFullPhotos count]; i++) {
                        NSDictionary *dict = [arrayFullPhotos objectAtIndex:i];
                        if ([provider.categoryName isEqual:[dict objectForKey:@"id"]]) {
//                            NSLog(@"index =%d",i);
                        }
                    }
                    [self reloadImageById:provider.categoryName];
                    [photosViewController reloadPhotoById:provider.categoryName];
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
//    provider.finishLoad = YES;
    counter ++;
    [self loadOneByOneImage];
   
}
#pragma mark ImagesViewController Delegate
-(void) closeImagesView
{
    UIView *subView = [self.view viewWithTag:TAG_IMAGE_VIEW];
    [subView removeFromSuperview];
    
}
#pragma mark DetailImageView Delegate
-(void) loadPreImage:(NSString *)Id
{
    for (int i=0; i< [arrayImages count]; i++) {
        NSDictionary *dictImage = [arrayImages objectAtIndex:i];
        if ([[dictImage objectForKey:@"id"] isEqual:Id]) {
            if (i>0&&i<([arrayImages count]-1)) {
                UIView *subview = [self.view viewWithTag:TAG_DETAIL_VIEW_IMAGE];
                if (subview) {
                    [subview removeFromSuperview];
                }
                break;
            }
        }
    }

    for (int i=1; i< [arrayImages count]; i++) {
        NSDictionary *dictImage = [arrayImages objectAtIndex:i];
        if ([[dictImage objectForKey:@"id"] isEqual:Id]) {
           
            DetailImageViewController *imageViewController = [[DetailImageViewController alloc]initWithNibName:@"DetailImageViewController" bundle:nil];
            imageViewController.delegate =self;
            [imageViewController.view setTag:TAG_DETAIL_VIEW_IMAGE];
            imageViewController.currentImageId = [dictImage objectForKey:@"id"];
            [self.view addSubview:imageViewController.view];
            [self.view bringSubviewToFront:imageViewController.view];
            NSDictionary *preDictImage = [arrayImages objectAtIndex:(i-1)];
            [imageViewController loadImageFromID:[preDictImage objectForKey:@"id"] url:[preDictImage objectForKey:@"url"]];
            CGRect frame = self.view.frame;
            frame.origin.x =-500;
            imageViewController.view.frame = frame;
            [UIView beginAnimations:@"Show Detail Image" context:nil];
            frame.origin.x =0;
            imageViewController.view.frame = frame;
            [UIView commitAnimations];
        }
    }
}
-(void) loadNextImage:(NSString *)Id
{
    
    for (int i=0; i< [arrayImages count]; i++) {
        NSDictionary *dictImage = [arrayImages objectAtIndex:i];
        if ([[dictImage objectForKey:@"id"] isEqual:Id]) {
            if (i>0&&i<([arrayImages count]-1)) {
                UIView *subview = [self.view viewWithTag:TAG_DETAIL_VIEW_IMAGE];
                if (subview) {
                    [subview removeFromSuperview];
                }
                break;
            }
        }
    }
    for (int i=0; i< [arrayImages count]-1; i++) {
        NSDictionary *dictImage = [arrayImages objectAtIndex:i];
        if ([[dictImage objectForKey:@"id"] isEqual:Id]) {
            
            DetailImageViewController *imageViewController = [[DetailImageViewController alloc]initWithNibName:@"DetailImageViewController" bundle:nil];
            imageViewController.delegate =self;
            [imageViewController.view setTag:TAG_DETAIL_VIEW_IMAGE];
            imageViewController.currentImageId = [dictImage objectForKey:@"id"];
            [self.view addSubview:imageViewController.view];
            [self.view bringSubviewToFront:imageViewController.view];
            NSDictionary *preDictImage = [arrayImages objectAtIndex:(i+1)];
            [imageViewController loadImageFromID:[preDictImage objectForKey:@"id"] url:[preDictImage objectForKey:@"url"]];
            CGRect frame = self.view.frame;
            frame.origin.x =500;
            imageViewController.view.frame = frame;
            [UIView beginAnimations:@"Show Detail Image" context:nil];
            frame.origin.x =0;
            imageViewController.view.frame = frame;
            [UIView commitAnimations];
        }
    }

}
-(void)closeView
{
    for (UIView *subView in self.view.subviews)
    {
        UIView *subview = [self.view viewWithTag:TAG_DETAIL_VIEW_IMAGE];
        
        if (subView) {
            [subview removeFromSuperview];
        }
    }
   
}
@end
