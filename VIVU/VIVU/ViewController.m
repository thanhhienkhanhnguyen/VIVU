//
//  ViewController.m
//  VIVU
//
//  Created by MacPro on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#define WIDTH_VIEWCONTROLLER_PANEL 60

#define MERCATOR_OFFSET 268435456
#define MERCATOR_RADIUS 85445659.44705395
#define AdMob_ID        @"a14fbef77ff0a14"
#define GEORGIA_TECH_LATITUDE 33.777328
#define GEORGIA_TECH_LONGITUDE -84.397348 

#define ZOOM_LEVEL 14
#define DEFAULT_IMAGE_LINK  @"https://vietnamagilemobile.com.vn/image/default"
#define TAG_SHOW_TABLE_VIEW    500
#define TAG_CUSTOM_BADGE       501
#define TAG_SHOW_DETAIL_VIEW   502
#define TAG_SPIN_VIEW          503
#define TAG_SPIN               504
#define TAG_LABEL              505
#define TAG_MORE_PHOTO_VIEW_CONTROLLER 506
#define TAG_PHOTOS_SCROLL_VIEW_CONTROLLER 507

#import "ViewController.h"
#import "GroupAnnotation/MKMapView+AnnotationGrouping.h"
#import "GroupAnnotation/SingleAnnotation.h"
#import "ViewController.h"


@interface ViewController ()

@end


@implementation ViewController

@synthesize mapView;
@synthesize coorCurent;
@synthesize setRegionBtn;
@synthesize mapType;
@synthesize locationManager;
@synthesize compassBtn;
@synthesize showAllPlaceBtn;
@synthesize requestLocations;
@synthesize placeTableViewController;
@synthesize searchBtn;
@synthesize popoverController;
@synthesize toolBar;
@synthesize customeViewBtn;
@synthesize arrayImagesProvider;
@synthesize dataSourceInTableView;
@synthesize tempDataSourceTableView;
@synthesize showGroupTableViewIphone;
@synthesize detailViewController;
@synthesize requestDetaiLocation;
@synthesize arrayImages;
@synthesize arrayProvider;
@synthesize counter;
@synthesize searchController;
@synthesize spinView;
@synthesize placeTableViewControllerIpad;
@synthesize showAllPlaceTableViewIpad;
@synthesize detailPlaceViewControllerIpad;
@synthesize detailVenueViewController;
@synthesize photosViewControllerMainView;
@synthesize searchVenueController;
@synthesize currentFramePopOver;
@synthesize tempDetailVenueViewController;
@synthesize tempShowPlaceInTableViewController;
@synthesize oldRadian;
@synthesize panelView;
@synthesize photosScrollView;
@synthesize currentAnnoSelected;
-(void)dealloc
{
    [currentAnnoSelected release];
    [photosScrollView release];
    [panelView release];
    AbMob.delegate = nil;
    [AbMob release];
    [tempDetailVenueViewController release];
    [tempShowPlaceInTableViewController release];
    [searchVenueController release];
    [photosViewControllerMainView release];
    [detailVenueViewController release];
    [detailPlaceViewControllerIpad release];
    [showAllPlaceTableViewIpad release];
    [placeTableViewControllerIpad release];
    [searchController release];
    [spinView release];
    [arrayProvider release];
    [arrayImages release];
    [placeTableViewController release];
    [detailViewController release];
    [requestDetaiLocation release];
    [showGroupTableViewIphone release];
    [tempDataSourceTableView release];
    [dataSourceInTableView release];
    [arrayImagesProvider release];
    [customeViewBtn release];
    [toolBar release];
    [popoverController release];
    [searchBtn release];
    [showAllPlaceBtn release];
    [requestLocations release];
    [compassBtn release];
    [locationManager release];
    [mapType release];
    [setRegionBtn release];
    [mapView release];
    [coorCurent release];
    [super dealloc];
}
#pragma mark -
#pragma mark App Life Cycle
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"memory warning");
}
-(void)viewWillAppear:(BOOL)animated
{
    
//    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[self scaleImage:[UIImage imageNamed:@"btnReset.png"] withSize:CGSizeMake(24.0, 24.0)]
//															   style:UIBarButtonItemStylePlain 
//															  target:self 
//                                                            action:@selector(UpdateRegionbtn:)];
//
//    
//	self.setRegionBtn = button;
//	[button release];
//    button = [[UIBarButtonItem alloc] initWithImage:[self scaleImage:[UIImage imageNamed:@"btnChangeType.png"] withSize:CGSizeMake(24.0, 24.0)]
//															   style:UIBarButtonItemStylePlain 
//															  target:self 
//															  action:@selector(changeMapType:)];
//	self.mapType = button;
//	[button release];
//    
//    button = [[UIBarButtonItem alloc] initWithImage:[self scaleImage:[UIImage imageNamed:@"btnLockCompass.png"] withSize:CGSizeMake(24.0, 24.0)]
//															   style:UIBarButtonItemStylePlain 
//															  target:self 
//															  action:@selector(enableCompass:)];
//	self.compassBtn = button;
//	[button release];
//    button = [[UIBarButtonItem alloc] initWithImage:[self scaleImage:[UIImage imageNamed:@"btnViewList.png"] withSize:CGSizeMake(24.0, 24.0)]
//                                              style:UIBarButtonItemStylePlain 
//                                             target:self 
//                                             action:@selector(showAllPlaceInTableView:)];
//	self.showAllPlaceBtn = button;
//	[button release];
////    [toolBar setItems:[NSArray arrayWithObjects:showAllPlaceBtn,setRegionBtn,mapType,compassBtn, nil]];
    [self.navigationItem setTitle:@""];
    [self.toolBar setBackgroundColor:[UIColor blackColor]];
    [self.toolBar setBarStyle:UIBarStyleBlackTranslucent];
    allowLoadingMap = YES;
    if (popoverController) {
        if (popoverController.popoverVisible) {
            NSLog(@"size popOver :%f",popoverController.popoverContentSize.height);
        }
    }   
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    allowLoadingMap = YES;
    if ([VIVUtilities isIpadDevice]) {
        CGRect frame= self.mapView.frame;
        NSLog(@"%@",NSStringFromCGRect(frame));
        CGFloat x = (frame.size.width - 768)/2;
        CGFloat y = (frame.size.height-1004)/2;
        CGRect framefix = CGRectMake(-x, -y, frame.size.width, frame.size.height);
        self.mapView.frame = framefix;
    }
    
    
    [self setRegion:self.coorCurent];
    self.panelView.hidden = YES;
    self.currentAnnoSelected = nil;
//    NSArray *array = self.mapView.gestureRecognizers;
//    for(UIGestureRecognizer *get in array)
//    {
//        if ([get isKindOfClass:[UILongPressGestureRecognizer class]]) {
//            [self.mapView removeGestureRecognizer:get];
//            break;
//        }
//    }
    self.navigationController.navigationBarHidden = YES;
    [self installUncaughtExceptionHandler];
    currentFramePopOver = CGRectNull;
    currentAnnotation  =nil;
    //if (![VIVUtilities isIpadDevice]) {
    AbMob = [[GADBannerView alloc]
                 initWithFrame:CGRectMake((self.view.frame.size.width - kGADAdSizeBanner.size.width), 0, kGADAdSizeBanner.size.width,
                                          kGADAdSizeBanner.size.height)];
    AbMob.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    NSLog(@"frame Ab : %@",NSStringFromCGRect(AbMob.frame));
//    [AbMob setBackgroundColor:[UIColor greenColor]];
    AbMob.adUnitID = AdMob_ID;
    AbMob.rootViewController = self;    
    AbMob.hidden = YES;
    [self.view addSubview:AbMob];
    AbMob.delegate = self;
        
        
    GADRequest *r = [[GADRequest alloc] init];
    r.testing = YES;
    [AbMob loadRequest:r];
    
    //}
//    popOverEnable = NO;
    
    
   // userTrackingMode.MKUserTrackingModeFollowWithHeading
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    NSLog(@"viewDidUnload");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (enableCompass) {
        return NO;
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (enableCompass) {
        if (!locationManager) {
            locationManager = [[CLLocationManager alloc]init];
            locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            locationManager.delegate=self;
        }
       [locationManager startUpdatingHeading];
        
    }
    allowLoadingMap = NO;
    
}
-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{

    [self configApp];
    [self refreshALLCustomBadge];
    allowLoadingMap = YES;
//    if (photosScrollView) {
//        [photosScrollView rotatePhotosScrollView];
////        [photosScrollView willRotateToInterfaceOrientation:fromInterfaceOrientation duration:];
////        [photosScrollView didRotateFromInterfaceOrientation:fromInterfaceOrientation];
//    }
}
-(void) configApp
{
    if (popoverController.popoverVisible) {
        if (currentAnnotation) {
            CGPoint annotationPoint = [self.mapView convertCoordinate:self.mapView.centerCoordinate toPointToView:self.view];
            float boxDY=annotationPoint.y-13;
            float boxDX=annotationPoint.x+10;
            CGRect box = CGRectMake(boxDX,boxDY,5,5);
            UILabel *displayLabel = [[UILabel alloc] initWithFrame:box];
            currentFramePopOver = displayLabel.frame;
            [popoverController presentPopoverFromRect:displayLabel.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
            
        }
        
    }
    if (self.spinView) {
        if ([VIVUtilities isIpadDevice]) {
            CGSize size = [VIVUtilities getSizeDevice];
            NSInteger width = 200;
            CGRect frame = CGRectMake((size.width/2-width/2), -20, width, 80);
            CGRect framefix = self.spinView.frame;
            framefix.origin.x = frame.origin.x;
            [self.spinView setFrame:framefix];
        }
    }
    if (AbMob) {
        CGRect frame = AbMob.frame;
        frame.origin.x = ([VIVUtilities getSizeDevice].width- frame.size.width);
        AbMob.frame =frame;
        
    }
}
#pragma mark -
#pragma mark MK MapView Delegate
- (double)longitudeToPixelSpaceX:(double)longitude
{
    return round(MERCATOR_OFFSET + MERCATOR_RADIUS * longitude * M_PI / 180.0);
}

- (double)latitudeToPixelSpaceY:(double)latitude
{
    return round(MERCATOR_OFFSET - MERCATOR_RADIUS * logf((1 + sinf(latitude * M_PI / 180.0)) / (1 - sinf(latitude * M_PI / 180.0))) / 2.0);
}

- (double)pixelSpaceXToLongitude:(double)pixelX
{
    return ((round(pixelX) - MERCATOR_OFFSET) / MERCATOR_RADIUS) * 180.0 / M_PI;
}

- (double)pixelSpaceYToLatitude:(double)pixelY
{
    return (M_PI / 2.0 - 2.0 * atan(exp((round(pixelY) - MERCATOR_OFFSET) / MERCATOR_RADIUS))) * 180.0 / M_PI;
} 
- (MKCoordinateSpan)coordinateSpanWithMapView:(MKMapView *)mapView
                             centerCoordinate:(CLLocationCoordinate2D)centerCoordinate
                                 andZoomLevel:(NSUInteger)zoomLevel
{
    // convert center coordiate to pixel space
    double centerPixelX = [self longitudeToPixelSpaceX:centerCoordinate.longitude];
    double centerPixelY = [self latitudeToPixelSpaceY:centerCoordinate.latitude];
    
    // determine the scale value from the zoom level
    NSInteger zoomExponent = 20 - zoomLevel;
    double zoomScale = pow(2, zoomExponent);
    
    // scale the map’s size in pixel space
    CGSize mapSizeInPixels = self.mapView.bounds.size;
    double scaledMapWidth = mapSizeInPixels.width * zoomScale;
    double scaledMapHeight = mapSizeInPixels.height * zoomScale;
    
    // figure out the position of the top-left pixel
    double topLeftPixelX = centerPixelX - (scaledMapWidth / 2);
    double topLeftPixelY = centerPixelY - (scaledMapHeight / 2);
    
    // find delta between left and right longitudes
    CLLocationDegrees minLng = [self pixelSpaceXToLongitude:topLeftPixelX];
    CLLocationDegrees maxLng = [self pixelSpaceXToLongitude:topLeftPixelX + scaledMapWidth];
    CLLocationDegrees longitudeDelta = maxLng - minLng;
    
    // find delta between top and bottom latitudes
    CLLocationDegrees minLat = [self pixelSpaceYToLatitude:topLeftPixelY];
    CLLocationDegrees maxLat = [self pixelSpaceYToLatitude:topLeftPixelY + scaledMapHeight];
    CLLocationDegrees latitudeDelta = -1 * (maxLat - minLat);
    
    // create and return the lat/lng span
    MKCoordinateSpan span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta);
    return span;
} 
-(void) setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate zoomLevel:(NSUInteger)zoomLevel animated:(BOOL)animated
{
    // clamp large numbers to 28
    zoomLevel = MIN(zoomLevel, 28);
    
    // use the zoom level to compute the region
    MKCoordinateSpan span = [self coordinateSpanWithMapView:self.mapView centerCoordinate:centerCoordinate andZoomLevel:zoomLevel];
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, span);
    
    // set the region like normal
    [self.mapView setRegion:region animated:animated];
    
}
- (NSUInteger) zoomLevel {
    MKCoordinateRegion region = self.mapView.region;
    
    double centerPixelX = [self longitudeToPixelSpaceX: region.center.longitude];
    double topLeftPixelX = [self longitudeToPixelSpaceX: region.center.longitude - region.span.longitudeDelta / 2];
    
    double scaledMapWidth = (centerPixelX - topLeftPixelX) * 2;
    CGSize mapSizeInPixels = self.mapView.bounds.size;
    double zoomScale = scaledMapWidth / mapSizeInPixels.width;
    double zoomExponent = log(zoomScale) / log(2);
    double zoomLevel = 20 - zoomExponent;
    
    return zoomLevel;
}
-(void)setRegion:(CLLocation *)coordinate2D
{

//    NSLog(@"coorCurrent region did update %f &&%f",coorCurent.coordinate.latitude,coorCurent.coordinate.longitude);
    CLLocationCoordinate2D coor = {.latitude = self.coorCurent.coordinate.latitude , .longitude =  self.coorCurent.coordinate.longitude};
    MKCoordinateSpan span = {.latitudeDelta = 0.03,.longitudeDelta = 0.03};
    MKCoordinateRegion region ={coor,span};
    region = [mapView regionThatFits:region];
    [mapView setRegion:region animated:YES];
//    [mapView setCenterCoordinate:coorCurent.coordinate animated:YES];
//    [self setCenterCoordinate:coorCurent.coordinate zoomLevel:14 animated:YES];
    //    [mapView setCenterCoordinate:mapView.userLocation.coordinate animated:YES];
    //    [mapView setCenterCoordinate:coor animated:YES];
    
    
    mapView.showsUserLocation = YES;
    
}
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
//    id<MKAnnotation> tempAnno = view.annotation;
//    if (![view.annotation isKindOfClass:[MKUserLocation class]]) {
//        [self.mapView removeAnnotation:view.annotation];
//        if (![annotations containsObject:tempAnno]) {
//            [annotations addObject:tempAnno];
//            [self.mapView addAnnotations:annotations withGroupDistance:30.0f];
//        }
//        
//        
//    }
    if ([view.annotation isKindOfClass:[MKUserLocation class]]) {
        return ;
    }
    currentAnnotation = view;
    if ([view.annotation isKindOfClass:[GroupedAnnotation class]]||[view.annotation isKindOfClass:[SingleAnnotation class]]) {
        
        NSMutableArray *arrayDataSource =[[NSMutableArray alloc]init];
        if ([view.annotation isKindOfClass:[GroupedAnnotation class]]) {
            //datasoure of group
            for (SingleAnnotation *spin in ((GroupedAnnotation*)view.annotation).listAnnotations) {
                [arrayDataSource addObject:spin.dictInfor];
            }
            
        }else {
            //datasoure of single spin
            [arrayDataSource addObject:((SingleAnnotation *)view.annotation).dictInfor];
        }
        
      
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            if (!showGroupTableViewIphone) {
                 showGroupTableViewIphone =[[ShowAllPlaceViewController alloc]initWithNibName:@"ShowAllPlaceViewController" bundle:nil];
                showGroupTableViewIphone.delegate = self;
            }else {
                [showGroupTableViewIphone.dataSourceTableView removeAllObjects];
            }

            if (showGroupTableViewIphone.view.hidden) {
                showGroupTableViewIphone.view.hidden = NO;
                NSLog(@"AAaaaaaa");
            }
            
//            UITapGestureRecognizer* tapRec = [[UITapGestureRecognizer alloc] 
//                                              initWithTarget:self action:@selector(didTapMap:)];
//            
//            [self.mapView addGestureRecognizer:tapRec];
//            [tapRec release];
            showGroupTableViewIphone.dataSourceTableView =[NSMutableArray arrayWithArray:arrayDataSource];
            [showGroupTableViewIphone.tableView reloadData];
//            showGroupTableViewIphone.view.center = self.view.center;
            CGSize size = [showGroupTableViewIphone sizeInPopoverView];
            CGRect frame = self.view.frame;
            frame.size = size;
            frame.origin.x =10;
            CGRect framefix = self.view.frame;
            framefix.size.height = self.view.frame.size.height -44;
            showGroupTableViewIphone.view.frame =framefix;
            showGroupTableViewIphone.cheatView.frame =frame;
            frame = showGroupTableViewIphone.cheatView.bounds;
            [showGroupTableViewIphone.tableView setFrame:frame];
            [showGroupTableViewIphone.view setTag:TAG_SHOW_TABLE_VIEW];
            [self.view addSubview:showGroupTableViewIphone.view];
            
            [showGroupTableViewIphone.cheatView setCenter:self.view.center];
            [showGroupTableViewIphone.cheatView.layer setBorderColor:[UIColor greenColor].CGColor];
            [showGroupTableViewIphone.cheatView.layer setBorderWidth:2.0f];
            [showGroupTableViewIphone.cheatView.layer setCornerRadius:5.0f];
            [self.mapView deselectAnnotation:view.annotation animated:NO];
            
                       

            
            
        } else {
           //ipad
            
            
            if ([view.annotation isKindOfClass:[GroupedAnnotation class]]) {
                if (self.popoverController != nil) {
                    if (popoverController.popoverVisible == YES) {
                        [popoverController dismissPopoverAnimated:YES];
                    }
                    [popoverController release];
                    popoverController = nil;
                }
                if (!self.showAllPlaceTableViewIpad) {
                    showAllPlaceTableViewIpad = [[ShowAllPlaceViewController_Ipad alloc]initWithNibName:@"ShowAllPlaceViewController_Ipad" bundle:nil];
                    showAllPlaceTableViewIpad.delegate =self;
                }else {
                    [showAllPlaceTableViewIpad release];
                    showAllPlaceTableViewIpad = nil;
                    showAllPlaceTableViewIpad = [[ShowAllPlaceViewController_Ipad alloc]initWithNibName:@"ShowAllPlaceViewController_Ipad" bundle:nil];
                    showAllPlaceTableViewIpad.delegate = self;
                }
//                }else {
//                    [showAllPlaceTableViewIpad.dataSourceTableView removeAllObjects];
//                }
                showAllPlaceTableViewIpad.dataSourceTableView  =[NSMutableArray arrayWithArray:arrayDataSource];
                [showAllPlaceTableViewIpad.tableView reloadData];
                                
                UINavigationController *content = [[UINavigationController alloc] initWithRootViewController:showAllPlaceTableViewIpad];
                

                popoverController = [[UIPopoverController alloc] initWithContentViewController:showAllPlaceTableViewIpad.navigationController];
                popoverController.delegate = self;
//                CGSize popOverSize = [showAllPlaceTableViewIpad sizeInPopoverView];
                CGSize popOverSize = CGSizeMake(330, 330);
                popoverController.popoverContentSize = popOverSize; 
                //                CGRect frame = detailVenueViewController.view.frame;
                //                //        CGRect ff = self.view.bounds;
                //                frame.size.height = popOverSize.height;
                //                frame.size.width = 250;
                //                detailVenueViewController.view.frame = frame;
                //                [detailVenueViewController.tableView setBackgroundColor:[UIColor whiteColor]];
                //        showGroupTableView.tableView.frame = frame;
                
                //                CGPoint annotationPoint = [self.mapView convertCoordinate:view.annotation.coordinate toPointToView:self.view];
                
                CGPoint annotationPoint = [self.mapView convertCoordinate:self.mapView.centerCoordinate toPointToView:self.view];
                float boxDY=annotationPoint.y-13;
                float boxDX=annotationPoint.x+10;
                CGRect box = CGRectMake(boxDX,boxDY,5,5);
                UILabel *displayLabel = [[UILabel alloc] initWithFrame:box];
                currentFramePopOver = displayLabel.frame;
                [popoverController presentPopoverFromRect:displayLabel.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
                //                [detailVenueViewController release];
                //                detailVenueViewController = nil;
//                self.tempDetailVenueViewController = detailVenueViewController;
                self.tempShowPlaceInTableViewController = showAllPlaceTableViewIpad;
                self.tempDetailVenueViewController = nil;
                [content release];
                [arrayDataSource release];
                [displayLabel release];
                id<MKAnnotation> anno = view.annotation;
                CLLocationCoordinate2D coor = anno.coordinate;
                [self.mapView setCenterCoordinate:coor animated:YES];
            
                [self refreshALLCustomBadge];
                [self.mapView deselectAnnotation:view.annotation animated:NO];
                if (currentAnnoSelected) {
                    for (int i =0; i < [showAllPlaceTableViewIpad.dataSourceTableView count]; i++) {
                        NSDictionary *dictCompare = [showAllPlaceTableViewIpad.dataSourceTableView objectAtIndex:i];
                        if (dictCompare) {
                            if ([dictCompare isEqual:currentAnnoSelected.dictInfor]) {
                                NSIndexPath *index =  [NSIndexPath indexPathForRow:i inSection:0];
                                
                                [showAllPlaceTableViewIpad.tableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionNone];
                                [showAllPlaceTableViewIpad.tableView.delegate tableView:showAllPlaceTableViewIpad.tableView didSelectRowAtIndexPath:index];
                               
                                self.currentAnnoSelected =nil;
                                break;
                            }
                        }
                    }
                    
                }


            }
            //            CGRect frameCheatView = self.view.frame;
//            frameCheatView.size = size;
//            CGSize sizeDevice = [VIVUtilities getSizeIpad];
//            frameCheatView.origin.x =(sizeDevice.width/2-size.width/2)-WIDTH_VIEWCONTROLLER_PANEL;
//            frameCheatView.origin.y = (sizeDevice.height/2 - size.height)-25;
//            CGRect framefix = self.view.frame;
//            framefix.size.width = self.view.frame.size.width -WIDTH_VIEWCONTROLLER_PANEL;
//            framefix.origin.x = WIDTH_VIEWCONTROLLER_PANEL;
//            showAllPlaceTableViewIpad.view.frame =framefix;
//            showAllPlaceTableViewIpad.cheatView.frame =frameCheatView;
//            
//            [showAllPlaceTableViewIpad.tableView reloadData];
//            CGRect frameView = CGRectMake(WIDTH_VIEWCONTROLLER_PANEL, 0, [VIVUtilities getSizeIpad].width -WIDTH_VIEWCONTROLLER_PANEL+60, [VIVUtilities getSizeIpad].height);
//            [showAllPlaceTableViewIpad.view setFrame:frameView];
//            [showAllPlaceTableViewIpad.view setTag:TAG_SHOW_TABLE_VIEW];
//            [self.view addSubview:showAllPlaceTableViewIpad.view];
//
//            [showAllPlaceTableViewIpad.cheatView.layer setBorderColor:[UIColor greenColor].CGColor];
//            [showAllPlaceTableViewIpad.cheatView.layer setBorderWidth:2.0f];
//            [showAllPlaceTableViewIpad.cheatView.layer setCornerRadius:5.0f];
            if ([view.annotation isKindOfClass:[SingleAnnotation class]]) {
                if (self.popoverController != nil) {
                    if (popoverController.popoverVisible == YES) {
                        [popoverController dismissPopoverAnimated:YES];
                    }
                    [popoverController release];
                    popoverController = nil;
                }
                if (!detailVenueViewController) {
                    detailVenueViewController = [[DetailVenueViewControllerIpad alloc]initWithNibName:@"DetailVenueViewControllerIpad" bundle:nil];
                    detailVenueViewController.delegate = self;
                }else {
                    [detailVenueViewController release];
                    detailVenueViewController = nil;
                    detailVenueViewController = [[DetailVenueViewControllerIpad alloc]initWithNibName:@"DetailVenueViewControllerIpad" bundle:nil];
                    detailVenueViewController.delegate = self;
                }
                [detailVenueViewController.view setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin)];
                detailVenueViewController.dictInfo = ((SingleAnnotation *)view.annotation).dictInfor;
//                [detailVenueViewController.tableView reloadData];
//                [detailVenueViewController configureView];
                UINavigationController *content = [[UINavigationController alloc] initWithRootViewController:detailVenueViewController];
                popoverController = [[UIPopoverController alloc] initWithContentViewController:detailVenueViewController.navigationController];
                popoverController.delegate = self;
                CGSize popOverSize = CGSizeMake(330, 330);
                popoverController.popoverContentSize = popOverSize; 
//                CGRect frame = detailVenueViewController.view.frame;
//                //        CGRect ff = self.view.bounds;
//                frame.size.height = popOverSize.height;
//                frame.size.width = 250;
//                detailVenueViewController.view.frame = frame;
//                [detailVenueViewController.tableView setBackgroundColor:[UIColor whiteColor]];
                //        showGroupTableView.tableView.frame = frame;
                
//                CGPoint annotationPoint = [self.mapView convertCoordinate:view.annotation.coordinate toPointToView:self.view];
                CGPoint annotationPoint = [self.mapView convertCoordinate:self.mapView.centerCoordinate toPointToView:self.view];
                float boxDY=annotationPoint.y-13;
                float boxDX=annotationPoint.x+10;
                CGRect box = CGRectMake(boxDX,boxDY,5,5);
                UILabel *displayLabel = [[UILabel alloc] initWithFrame:box];
                currentFramePopOver = displayLabel.frame;
                [popoverController presentPopoverFromRect:displayLabel.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
//                [detailVenueViewController release];
//                detailVenueViewController = nil;
                self.tempDetailVenueViewController = detailVenueViewController;
                self.tempShowPlaceInTableViewController = nil;
                [content release];
                [arrayDataSource release];
                [displayLabel release];
                id<MKAnnotation> anno = view.annotation;
                CLLocationCoordinate2D coor = anno.coordinate;
                [self.mapView setCenterCoordinate:coor animated:YES];
                [self.mapView deselectAnnotation:view.annotation animated:NO];
                [self refreshALLCustomBadge];
//                [self initAnnotations:tempDataSourceTableView];
//                [self refreshAllAnnotation];
                
            }
            
        }
        
        
    }    
}



-(void)requestNewLocation:(CLLocation *)newLocation 
{
    if (!requestLocations) {
        requestLocations =[[SearchPlaceProvider alloc]init];
        requestLocations.delegate = self;
     
    }
    if (requestLocations.loadingData ==YES) {
        //
        [requestLocations cancelDownload];
    }
    [self startSpinner:self.view];
    [requestLocations configURL:newLocation];
    [requestLocations requestData];
    
}
-(void) refreshAllAnnotation
{
    /*note */
    for(UIView *subView in self.mapView.subviews)
    {
        if ([subView isKindOfClass:[CustomBadge class]]) {
            [subView removeFromSuperview];
        }
    }
    /*note */
    for (id<MKAnnotation> anno in mapView.annotations)
    {
        if (![anno isKindOfClass:[MKUserLocation class]]) {
            [mapView removeAnnotation:anno];
        }
    }
    if (annotations) {
        //        NSLog(@"zoom level current is :....%d",[self zoomLevel]);
        CGFloat dist= 30.0f; //default distance to group
        if ([self zoomLevel]>= 17) {
            dist = 10.0f;
        }
        [mapView addAnnotations:annotations withGroupDistance:dist];
    }
    for (id<MKAnnotation> anno in mapView.annotations)
    {
        if ([anno isKindOfClass:[GroupedAnnotation class]]) {
            NSString *count =[NSString stringWithFormat:@"%d",((GroupedAnnotation*)anno).count];
            CustomBadge *customBadge = [CustomBadge customBadgeWithString:count
                                                          withStringColor:[UIColor whiteColor] 
                                                           withInsetColor:[UIColor redColor] 
                                                           withBadgeFrame:YES 
                                                      withBadgeFrameColor:[UIColor whiteColor] 
                                                                withScale:1.0
                                                              withShining:YES];
            CGPoint annotationPoint = [self.mapView convertCoordinate:anno.coordinate toPointToView:self.mapView];
            float boxDY=annotationPoint.y;
            float boxDX=annotationPoint.x;
            CGRect box = CGRectMake(boxDX,boxDY-30,30,30);
            [customBadge setFrame:box];
            [customBadge setTag:TAG_CUSTOM_BADGE];
            [self.mapView addSubview:customBadge];
//            [self.view insertSubview:customBadge atIndex:0];
//            [self.view bringSubviewToFront:customBadge];
//           [customBadge release];

        }
        
    }
    
}
-(void) mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    for(int i =0;i< [self.view.subviews count]; i++)
    {
        UIView *temp = [self.view.subviews objectAtIndex:i];
        if ([temp isKindOfClass:[CustomBadge class]]) {
            [temp removeFromSuperview];
            i--;
        }
    }
    for(UIView *subView in self.mapView.subviews)
    {
        if ([subView isKindOfClass:[CustomBadge class]]) {
            [subView removeFromSuperview];
        }
    }
    

}
-(void) refreshALLCustomBadge
{
    for (id<MKAnnotation> anno in mapView.annotations)
    {
        if ([anno isKindOfClass:[GroupedAnnotation class]]) {
            NSString *count =[NSString stringWithFormat:@"%d",((GroupedAnnotation*)anno).count];
            CustomBadge *customBadge = [CustomBadge customBadgeWithString:count
                                                          withStringColor:[UIColor whiteColor] 
                                                           withInsetColor:[UIColor redColor] 
                                                           withBadgeFrame:YES 
                                                      withBadgeFrameColor:[UIColor whiteColor] 
                                                                withScale:1.0
                                                              withShining:YES];
            CGPoint annotationPoint = [self.mapView convertCoordinate:anno.coordinate toPointToView:self.mapView];
            float boxDY=annotationPoint.y;
            float boxDX=annotationPoint.x;
            CGRect box = CGRectMake(boxDX,boxDY-30,30,30);
            [customBadge setFrame:box];
            [customBadge setTag:TAG_CUSTOM_BADGE];
            [self.mapView addSubview:customBadge];
            //            [self.view insertSubview:customBadge atIndex:0];
            //            [self.view bringSubviewToFront:customBadge];
//            [customBadge release];
            
        }
        
    }

}
- (void)mapView:(MKMapView *)mapViewParam regionDidChangeAnimated:(BOOL)animated
{
    CLLocation *newLocation =[[[CLLocation alloc]initWithLatitude:mapView.centerCoordinate.latitude longitude:mapView.centerCoordinate.longitude]autorelease];
   
    if (!allowLoadingMap) {
        // don't do anything
    }else {
        if (popoverController) {
            if (popoverController.popoverVisible==NO) {
                [self requestNewLocation:newLocation];
            }else if (popoverController.popoverContentSize.height>400) {
                //popOver and allow loading new location
                [self requestNewLocation:newLocation];
            }
                //don't loading new annotation when popOver is visible
        
        }else {
            [self requestNewLocation:newLocation];
        }
         
    }
   
    	
}
- (MKAnnotationView *)mapView:(MKMapView *)mapViewParam viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    NSString *AnnotationViewID = @"AnnotationViewID";
    MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView==nil) {
        annotationView = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID] autorelease];

    }
    
//	MKPinAnnotationView* pinView;
//	pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"id"];
//	if(!pinView)
//	{
//		pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"id"];
//		pinView.canShowCallout = NO;
//        UIImage *imageDefault =[UIImage imageNamed:@"default_32.png"];
//        pinView.image =imageDefault;
//	}
	
	if([annotation class] == [SingleAnnotation class])
	{
        SingleAnnotation *anno = (SingleAnnotation *)annotation;
        //		pinView.pinColor = MKPinAnnotationColorRed;
        NSString *filePath = [NSString stringWithFormat:@"%@/favicon/%@.favicon.ico",
                              [VIVUtilities applicationDocumentsDirectory],
                              anno.categoryName];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        if (!image) {
            image =[UIImage imageNamed:@"default_32.png"];
        }
//        pinView.image = image;
         annotationView.annotation = annotation;
         annotationView.image = image;
        
        
	}
	if([annotation class] == [GroupedAnnotation class])
	{
        GroupedAnnotation *group = (GroupedAnnotation*)annotation;
        //		pinView.pinColor = MKPinAnnotationColorGreen;
        NSString *filePath = [NSString stringWithFormat:@"%@/favicon/%@.favicon.ico",
                              [VIVUtilities applicationDocumentsDirectory],
                              group.categoryName];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        if (!image) {
            //load image default
            image =[UIImage imageNamed:@"default_32.png"];
        }else {
            image = image;
        }
        annotationView.annotation = annotation;
        annotationView.image = image;
        
        
	}
	
	return annotationView;
}
-(void)initAnnotations:(NSMutableArray *)resultContent
{
    if (resultContent) {
        if (!annotations) {
            annotations = [[NSMutableArray array]retain];
        }else {
            [annotations removeAllObjects];
        }
        
        for (int i =0; i< [resultContent count]; i++) {
            NSDictionary *dictInfor = [resultContent objectAtIndex:i];
            NSDictionary *dictLocation = [dictInfor objectForKey:@"location"];
            CGFloat lat = [[dictLocation objectForKey:@"lat"]floatValue];
            CGFloat lng = [[dictLocation objectForKey:@"lng"]floatValue];
            CGFloat distance = [[dictLocation objectForKey:@"distance"]floatValue];
            CLLocationCoordinate2D coorSpiner = {.latitude = lat , .longitude =  lng};
            
            SingleAnnotation *annotation = [[SingleAnnotation alloc]initSingleAnnatation:[dictInfor objectForKey:@"type"] itemID:[dictInfor objectForKey:@"id"] coorSpiner:coorSpiner distanceParameter:distance];
            annotation.dictInfor = dictInfor;
            
            //            [annotations addObject:[[[SingleAnnotation alloc] initWithCoordinate:coorSpiner] autorelease]];
            [annotations addObject:annotation];
            [annotation release];
            
            //            ImagesProfileProvider *imageProvider =[[ImagesProfileProvider alloc]init];
            //            imageProvider.categoryName = [dictInfor objectForKey:@"type"];
            //            NSString *linkImage = [dictInfor objectForKey:@"imagelink"];
            //            if (linkImage) {
            //                [imageProvider configURLByURL:[dictInfor objectForKey:@"imagelink"]];
            //            }else {
            //                [imageProvider configURLByURL:DEFAULT_IMAGE_LINK];
            //            }
            //            NSDictionary *dictFavicon = [NSDictionary dictionaryWithObjectsAndKeys:
            //                                         imageProvider,@"provider", 
            //                                         [dictInfor objectForKey:@"type"],@"type",
            //                                         nil];
            //            [arrayImagesProvider addObject:dictFavicon];
            //            [imageProvider release];
            
            
            
            
        }
        
    }
//    if (annotations) {
//        for (id<MKAnnotation> anno in mapView.annotations)
//        {
//            if (![anno isKindOfClass:[MKUserLocation class]]) {
//                [mapView removeAnnotation:anno];
//            }
//        }
//            CGFloat dist= 30.0f; //default distance to group
//            if ([self zoomLevel]>= 17) {
//                dist = 10.0f;
//            }
//            [mapView addAnnotations:annotations withGroupDistance:dist];
//    }
}
-(BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager
{
    return YES;
}
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    if (enableCompass) {  

        
        float oldRad =  -manager.heading.magneticHeading * M_PI / 180.0f;
        float newRad =  -newHeading.magneticHeading * M_PI / 180.0f;		
        CABasicAnimation *theAnimation;
        theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        theAnimation.fromValue = [NSNumber numberWithFloat:oldRad];
        theAnimation.toValue=[NSNumber numberWithFloat:newRad];
        theAnimation.duration = 0.5f;    
        [self.mapView.layer addAnimation:theAnimation forKey:@"animateMyRotation"];
        if (oldRad ==self.oldRadian) {
            [UIView beginAnimations:@"start compass" context:nil];
             self.mapView.transform = CGAffineTransformMakeRotation(newRad);
            [UIView commitAnimations];
        }else {
             self.mapView.transform = CGAffineTransformMakeRotation(newRad);
        }
        
       
//        self.view.transform =CGAffineTransformMakeRotation(newRad);
//        CGRect frame = self.mapView.frame;
//        frame.size =self.view.frame.size;
//        self.mapView.frame = frame;
//        CGRect frame = self.mapView.frame;
//        CGSize size = [VIVUtilities getSizeDevice];
//        frame.size =size;
//        self.mapView.frame = frame;
          NSLog(@"update from %f (%f) => %f (%f)", manager.heading.magneticHeading, oldRad, newHeading.magneticHeading, newRad);
//        NSLog()
        

//        [self.mapView setTransform:CGAffineTransformMakeRotation(-1 * newHeading.magneticHeading * M_PI / 180)]  ;
//        for (id <MKAnnotation> anno in self.mapView.annotations) {
//            MKAnnotationView *annotationView = [self.mapView viewForAnnotation:anno]; 
//            [annotationView setTransform:CGAffineTransformMakeRotation(-1*newHeading.trueHeading * M_PI / 180)];
//            annotationView.layer.anchorPoint = CGPointMake(0.5, 1.0);
//
//        }
//        for(UIView *subView in self.mapView.subviews)
//        {
//            if ([subView isKindOfClass:[CustomBadge class]]) {
//                [subView setTransform:CGAffineTransformMakeRotation(-1 * newHeading.magneticHeading * M_PI / 180)]  ;
//            }
//        }

    }
  
}
-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
//    NSLog(@"asdasd");
}
#pragma mark Button Event
-(IBAction)customeViewMapView:(id)sender
{
    if ([sender isSelected]) {
        //collapse mapview
        [sender setImage:[UIImage imageNamed:@"btnMinus.png"] forState:UIControlStateNormal];        
        [sender setSelected:NO];
        CGRect frame = mapView.frame;
//        frame.origin.y = 44;
//        frame.size.height = self.view.frame.size.height -44;
        [UIView beginAnimations:@"Collapse MapView" context:nil];
        self.navigationController.navigationBarHidden = YES;
        self.toolBar.hidden = NO;
        mapView.frame = frame;
        [UIView commitAnimations];
    }else {
        //expand mapview
        [sender setImage:[UIImage imageNamed:@"btnMinus_selected.png"] forState:UIControlStateSelected];
        [sender setSelected:YES];
        
        CGRect frame = mapView.frame;
        frame = self.view.frame;
        [UIView beginAnimations:@"Expand MapView" context:nil];
        self.navigationController.navigationBarHidden = YES;
        self.toolBar.hidden = YES;
        mapView.frame = self.view.frame;
        [UIView commitAnimations];
        
    }

}
-(IBAction)changeMapType:(id)sender
{
    if ([sender isSelected]) {
        [sender setImage:[UIImage imageNamed:@"btnChangeType.png"] forState:UIControlStateNormal];
        [sender setSelected:NO];
    }else {
        [sender setImage:[UIImage imageNamed:@"btnChangeType_selected.png"] forState:UIControlStateSelected];
        [sender setSelected:YES];
        
    }
    
    
    if (self.mapView.mapType == MKMapTypeHybrid) {
        self.mapView.mapType = MKMapTypeStandard;
    }else {
        self.mapView.mapType = MKMapTypeHybrid;
    }
//    [self refreshAllAnnotation];
    /*note*/
//    UIView *subView = [self.view viewWithTag:TAG_SHOW_TABLE_VIEW];
//    if (subView) {
//        for (int i=0; i<[self.view.subviews count]; i++) {
//            UIView *customBadgeView = [self.view viewWithTag:TAG_CUSTOM_BADGE];
//            if (customBadgeView) {
//                [self.view sendSubviewToBack:customBadgeView];
//            }
//        }
//    }
    
    
}
-(IBAction)UpdateRegionbtn:(id)sender
{
    [self setRegion:self.coorCurent];
}
-(void)searchPlaceInPopOver:(id)sender
{
//    popOverEnable = YES;


    
    BOOL needShowPopOver = NO;
    currentAnnotation = nil;//see confip App
    if (self.popoverController != nil) {
        if (popoverController.popoverVisible == YES) {
            if (self.searchBtn.selected ==YES) {
                needShowPopOver = NO;
            }else {
                needShowPopOver = YES;
            }
            if (needShowPopOver) {
                [popoverController dismissPopoverAnimated:YES];
                [popoverController release];
                popoverController = nil;
            }
           
        }else {
            needShowPopOver = YES;
        }
        
    }else {
        needShowPopOver = YES;
    }
    if ([sender isSelected]) {
        //        [sender setImage:[UIImage imageNamed:@"btnLockCompass.png"] forState:UIControlStateNormal];
        [sender setSelected:YES];
    }else {
        //        [sender setImage:[UIImage imageNamed:@"btnLockCompass_Selected.png"] forState:UIControlStateSelected];
        [sender setSelected:YES];
        
    }
    if (needShowPopOver) {
        if (!self.searchVenueController) {
            searchVenueController = [[SearchVenueViewController alloc]initWithNibName:@"SearchVenueViewController" bundle:nil];
            searchVenueController.delegate = self;
            
        }
        if (tempDataSourceTableView) {
            searchVenueController.dataSourceTableView = tempDataSourceTableView;
        }
        if (!self.requestLocations) {
            requestLocations = [[SearchPlaceProvider alloc]init];
            requestLocations.delegate =self;
        }
        if (!placeTableViewControllerIpad.dataSourceTableView) {
            [requestLocations configURL:self.coorCurent];
            [requestLocations requestData];
        }
        UINavigationController *content = [[UINavigationController alloc] initWithRootViewController:searchVenueController];
        popoverController = [[UIPopoverController alloc] initWithContentViewController:searchVenueController.navigationController];
        popoverController.passthroughViews = [[[NSArray alloc] initWithObjects:self.view, nil] autorelease];
        
        popoverController.delegate = self;
        //    CGSize popOverSize = [placeTableViewControllerIpad sizeInPopoverView];
        CGSize popOverSize = CGSizeMake(330, [VIVUtilities getSizeDevice].height-100);
        popoverController.popoverContentSize = popOverSize; 
        //                CGRect frame = detailVenueViewController.view.frame;
        //                //        CGRect ff = self.view.bounds;
        //                frame.size.height = popOverSize.height;
        //                frame.size.width = 250;
        //                detailVenueViewController.view.frame = frame;
        //                [detailVenueViewController.tableView setBackgroundColor:[UIColor whiteColor]];
        //        showGroupTableView.tableView.frame = frame;
        
        //                CGPoint annotationPoint = [self.mapView convertCoordinate:view.annotation.coordinate toPointToView:self.view];
        
        [popoverController presentPopoverFromRect:((UIButton *)sender).frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
        [content release];

    }
      

   
}
-(IBAction)searchTableView:(id)sender
{
//    UINavigationController *navi = nil;
//    allowLoadingMap = NO;
//    self.navigationController.navigationBarHidden = NO;
    if (!self.searchController) {
        searchController =[[SearchViewController alloc]initWithNibName:@"SearchViewController" bundle:nil];
        searchController.delegate =self;
        if (tempDataSourceTableView) {
            searchController.dataSourceTableView = [NSArray arrayWithArray:tempDataSourceTableView];
        }
//        navi = [[UINavigationController alloc]initWithRootViewController:searchController];
    }else {
        searchController.dataSourceTableView = [NSArray arrayWithArray:tempDataSourceTableView];;
        [searchController.resultDatasource removeAllObjects];
    }
//    self.navigationController.navigationBarHidden = NO;
//    if (!navi) {
//        navi = [[UINavigationController alloc]initWithRootViewController:searchController];
//    }
//    navi.title =@"Search";
    searchController.modalPresentationStyle = UIModalPresentationFullScreen;
    searchController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:searchController animated:YES];

    
    

}
-(IBAction)enableCompass:(id)sender
{
    if ([sender isSelected]) {
        [sender setImage:[UIImage imageNamed:@"btnLockCompass.png"] forState:UIControlStateNormal];
        [sender setSelected:NO];
    }else {
        [sender setImage:[UIImage imageNamed:@"btnLockCompass_Selected.png"] forState:UIControlStateSelected];
        [sender setSelected:YES];
        
    }
    
    
    
    if (enableCompass) {
        enableCompass = NO;
        if (locationManager) {
            [locationManager stopUpdatingHeading];
            [UIView beginAnimations:@"stop tranform" context:nil];
            self.mapView.transform = CGAffineTransformMakeRotation(self.oldRadian);
            [UIView commitAnimations];
        }
//        mapView.userTrackingMode = MKUserTrackingModeNone;
//        [self.mapView setTransform:CGAffineTransformMakeRotation(1)];
    }else {
        enableCompass = YES;
        if (!locationManager) {
            locationManager = [[CLLocationManager alloc]init];
            locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            locationManager.delegate=self;
        }
//         mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
        [locationManager startUpdatingHeading];
    }
//    [self refreshAllAnnotation];
}
-(void) showALLPlaceInPopOver:(id)sender
{

    

    currentAnnotation =nil;//see confip App
    BOOL needShowPopOver = NO;
    if (self.popoverController != nil) {
        if (popoverController.popoverVisible == YES) {
            if (self.showAllPlaceBtn.selected ==YES) {
                needShowPopOver = NO;
            }else {
                needShowPopOver = YES;
            }
            if (needShowPopOver) {
                [popoverController dismissPopoverAnimated:YES];
                [popoverController release];
                popoverController = nil;
            }
            
        }else {
            needShowPopOver = YES;
        }
        
    }else {
        needShowPopOver = YES;
    }
    if ([sender isSelected]) {
        
        [sender setSelected:YES];
    }else {
        
        [sender setSelected:YES];
        
    }
    if (needShowPopOver) {
        if (!self.placeTableViewControllerIpad) {
            placeTableViewControllerIpad = [[PlaceTableViewController alloc]initWithNibName:@"PlaceTableViewController" bundle:nil];
            placeTableViewControllerIpad.delegate =self;
            [placeTableViewControllerIpad.view setAutoresizingMask:(/*UIViewAutoresizingFlexibleWidth|*/UIViewAutoresizingFlexibleTopMargin|/*UIViewAutoresizingFlexibleRightMargin|*/UIViewAutoresizingFlexibleHeight)];
            
            
        }
        if (!self.requestLocations) {
            requestLocations = [[SearchPlaceProvider alloc]init];
            requestLocations.delegate =self;
        }
        if (!placeTableViewControllerIpad.dataSourceTableView) {
            [requestLocations configURL:self.coorCurent];
            [requestLocations requestData];
        }
        UINavigationController *content = [[UINavigationController alloc] initWithRootViewController:placeTableViewControllerIpad];
        popoverController = [[UIPopoverController alloc] initWithContentViewController:placeTableViewControllerIpad.navigationController];
        popoverController.passthroughViews = [[[NSArray alloc] initWithObjects:self.view, nil] autorelease];
        popoverController.delegate = self;
        //    CGSize popOverSize = [placeTableViewControllerIpad sizeInPopoverView];
        CGSize popOverSize = CGSizeMake(330, [VIVUtilities getSizeDevice].height-100);
        popoverController.popoverContentSize = popOverSize; 
        //                CGRect frame = detailVenueViewController.view.frame;
        //                //        CGRect ff = self.view.bounds;
        //                frame.size.height = popOverSize.height;
        //                frame.size.width = 250;
        //                detailVenueViewController.view.frame = frame;
        //                [detailVenueViewController.tableView setBackgroundColor:[UIColor whiteColor]];
        //        showGroupTableView.tableView.frame = frame;
        
        //                CGPoint annotationPoint = [self.mapView convertCoordinate:view.annotation.coordinate toPointToView:self.view];
        
        [popoverController presentPopoverFromRect:((UIButton *)sender).frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
        [content release];

    }

    
    

}
-(void) showAllPlaceInTableView:(id)sender
{
    if ([sender isSelected]) {
        [sender setImage:[UIImage imageNamed:@"btnViewList.png"] forState:UIControlStateNormal];
        [sender setSelected:NO];
    }else {
        [sender setImage:[UIImage imageNamed:@"btnViewList_selected.png"] forState:UIControlStateSelected];
        [sender setSelected:YES];
        
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if (!self.placeTableViewController) {
            self.placeTableViewController = [[ShowAllPlaceViewController alloc]initWithNibName:@"ShowAllPlaceViewController" bundle:nil];
            placeTableViewController.delegate = self;
            //        [placeTableViewController.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"collapse_bar"]]];
            
            //        self.placeTableViewController = [[PlaceTableViewController alloc]init];
            //        [placeTableViewController configureView];
            //        [placeTableViewController.view setAutoresizesSubviews:YES];
            //        [placeTableViewController.view setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin)];
            
            
        }
        
        if (!isVisibleTableView) {
            //show table view
            isVisibleTableView = YES;
            if (requestLocations) {
                if (requestLocations.loadingData ==NO) {
                    [placeTableViewController.tableView reloadData];//deselected row
                }
            } 
            CGRect frame = placeTableViewController.view.frame;
            frame.origin.x = 0;
            frame.origin.y = 500;
            frame.size.height = 44*9+22;
            placeTableViewController.view.frame = frame;
            CGRect frameview = placeTableViewController.view.bounds;
            placeTableViewController.tableView.frame =frameview;
            placeTableViewController.view.layer.masksToBounds = YES;
            [self.view addSubview:placeTableViewController.view];
            [UIView beginAnimations:@"Explore TableView" context:nil];
            frame.origin.y = 0;
            CGRect ff = placeTableViewController.view.bounds;
            frame.size.height = ff.size.height;
            //        frame.size.width = 250;
            placeTableViewController.view.frame = frame;
            [UIView commitAnimations];
            
        }else {
            //hiden table view
            isVisibleTableView = NO;
            CGRect frame = placeTableViewController.view.frame;
            frame.origin.y = 500;
            [UIView beginAnimations:@"Hiden Table View" context:nil];
            placeTableViewController.view.frame = frame;
            [UIView commitAnimations];
        }
        if (!self.requestLocations) {
            requestLocations = [[SearchPlaceProvider alloc]init];
            requestLocations.delegate =self;
        }
        if (!placeTableViewController.dataSourceTableView) {
            [requestLocations configURL:self.coorCurent];
            [requestLocations requestData];
        }
        

    }else {
        if (!self.placeTableViewControllerIpad) {
            self.placeTableViewControllerIpad = [[PlaceTableViewController alloc]initWithNibName:@"PlaceTableViewController" bundle:nil];
            placeTableViewControllerIpad.delegate =self;
             [placeTableViewControllerIpad.view setAutoresizingMask:(/*UIViewAutoresizingFlexibleWidth|*/UIViewAutoresizingFlexibleTopMargin|/*UIViewAutoresizingFlexibleRightMargin|*/UIViewAutoresizingFlexibleHeight)];
            
            
        }
        if (!isVisibleTableView) {
            //show table view
            isVisibleTableView = YES;
            CGRect frame = placeTableViewControllerIpad.view.frame;
            frame.origin.x = 0;
            self.placeTableViewControllerIpad.view.frame = frame;
            [self.view addSubview:placeTableViewControllerIpad.view];
            [UIView beginAnimations:@"Explore TableView" context:nil];
            frame.origin.x = WIDTH_VIEWCONTROLLER_PANEL;
            frame.origin.y = 0;
            CGRect ff = self.view.bounds;
            frame.size.height = ff.size.height;
            frame.size.width = 320;
            placeTableViewControllerIpad.view.frame = frame;
            placeTableViewController.tableView.frame = frame;
            [UIView commitAnimations];
            
        }else {
            //hiden table view
            isVisibleTableView = NO;
            CGRect frame = placeTableViewControllerIpad.view.frame;
            frame.origin.x = -400;
            [UIView beginAnimations:@"Hiden Table View" context:nil];
            placeTableViewControllerIpad.view.frame = frame;
            [UIView commitAnimations];
        }
        if (!self.requestLocations) {
            requestLocations = [[SearchPlaceProvider alloc]init];
            requestLocations.delegate =self;
        }
        if (!placeTableViewControllerIpad.dataSourceTableView) {
            [requestLocations configURL:self.coorCurent];
            [requestLocations requestData];
        }
        

    }
        
    
    
    
    
    
    
    
    //    frame.origin.x = 0;
    //    placeTableViewController.tableView.frame = frame;
    
    
}
#pragma mark copy function
- (void)installUncaughtExceptionHandler
{
#if TARGET_IPHONE_SIMULATOR
#else
	InstallUncaughtExceptionHandler();
#endif
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
            if (detailPlaceViewControllerIpad) {
                [detailPlaceViewControllerIpad reloadImageById:provider.categoryName];
            }
            if (detailViewController) {
                [detailViewController reloadImageById:provider.categoryName];
            }
            if (photosViewControllerMainView) {
                [photosViewControllerMainView reloadPhotoById:provider.categoryName];
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

-(void)loadOneByOneImage
{
  
    if (arrayProvider) {
        [self loadImageFromArrayProviderWithCounter:counter];
    }
    
}
-(void) startSpinner:(UIView *)parrentView
{
    /*note*/
    if ([VIVUtilities isIpadDevice]) {
        CGSize size = [VIVUtilities getSizeIpad];
        NSInteger width = 200;
        CGRect frame = CGRectMake((size.width/2-width/2), -20, width, 80);
        
        if (!self.spinView) {
            spinView = [[UIView alloc]initWithFrame:frame];
            [spinView.layer setBorderWidth:5.0f];
            [spinView.layer setCornerRadius:10.0f];
            [spinView setBackgroundColor:[UIColor blackColor]];
            UIActivityIndicatorView *spin = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            CGRect fspin = spin.frame;
            fspin.origin.x =10;
            fspin.origin.y =10;
            spin.frame = fspin;
            [spinView addSubview:spin];
            frame.size.width = 140;
            frame.origin.x =0+40;
            frame.origin.y =-6;
            UILabel *label = [[UILabel alloc]initWithFrame:frame];
            [label setBackgroundColor:[UIColor clearColor]];
            label.textColor = [UIColor whiteColor];
            label.text = @"loading...";
            label.font =[UIFont systemFontOfSize:20.0f];
            label.textAlignment = UITextAlignmentCenter;
            [spinView addSubview:label];
            [parrentView addSubview:spinView];
            
            [spin startAnimating];
            frame = CGRectMake((size.width/2-width/2), -70, width, 60);
            spinView.frame =frame;
            [UIView beginAnimations:@"Show spinView" context:nil];
            frame.origin.y =-20;
            spinView.frame =frame;
            [UIView commitAnimations];
            [label release];
            [spin  release];
            
        }

        
    }else {
        CGSize size = [VIVUtilities getSizeIphone];
        NSInteger width = 120;
        CGRect frame = CGRectMake((size.width/2-width/2), -20, width, 40);
        if (!self.spinView) {
            self.spinView = [[UIView alloc]initWithFrame:frame];
            [spinView.layer setBorderWidth:5.0f];
            [spinView.layer setCornerRadius:10.0f];
            [spinView setBackgroundColor:[UIColor blackColor]];
            UIActivityIndicatorView *spin = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            CGRect frameSpin = spin.frame;
            frameSpin.origin.x =5;
            frameSpin.origin.y =15;
            [spin setFrame:frameSpin];
            [spinView addSubview:spin];
            frame.size.width = 60;
            frame.origin.x =0+30;
            frame.origin.y =8;
            frame.size.height=30;
            UILabel *label = [[UILabel alloc]initWithFrame:frame];
            [label setBackgroundColor:[UIColor blackColor]];
            label.textColor = [UIColor whiteColor];
            label.text = @"loading...";
            label.font =[UIFont systemFontOfSize:12.0]; 
            label.textAlignment =UITextAlignmentCenter;
            [spinView addSubview:label];
            [parrentView addSubview:spinView];
            [spin startAnimating];
            frame = CGRectMake((size.width/2-width/2), -70, width, 40);
            spinView.frame =frame;
            [UIView beginAnimations:@"Show spinView" context:nil];
            frame.origin.y =-10;
            spinView.frame =frame;
            [UIView commitAnimations];
            [label release];
            [spin  release];
            
        }

    }
               
}
-(void) stopSpinner:(UIView *)parrentView
{
//    UIView *subView = [parrentView viewWithTag:TAG_SPIN_VIEW];
//    UIView *label = [self.view viewWithTag:TAG_LABEL];
//    UIView *spin = [self.view viewWithTag:TAG_SPIN];
//    CGRect frame = subView.frame;
//    CGRect framelabel = label.frame;
//    if (subView) {
//        [UIView beginAnimations:@"Stop spinView" context:nil];
//        frame.origin.y = -30;
//        framelabel.origin.y =-30;
//        subView.frame =frame;
//        label.frame =framelabel;
//        if (spin) {
//            
//            [((UIActivityIndicatorView *)spin) stopAnimating];
//        }
//        [UIView commitAnimations];
//        [subView removeFromSuperview];
//        [label removeFromSuperview];
//        if (spin) {           
//            [spin removeFromSuperview];
//        }
//       
//       
//    }
    if (self.spinView) {
        CGRect frame = self.spinView.frame;
        [UIView beginAnimations:@"Close loading" context:nil];
        if ([VIVUtilities isIpadDevice]) {
            frame.origin.y = -60;
        }
        else {
            frame.origin.y = -70;
        }
        spinView.frame = frame;
        [UIView commitAnimations];
        [spinView release];
        spinView = nil;

    }
        
}

#pragma mark Ipad Delegate
-(void) addPhotosScroolView:(PhotosScrollViewController *)photosScroolView
{
    [self closePopOver];
    [self presentModalViewController:photosScrollView animated:YES];
//    [photosScrollView.view setTag:8000];
//    CGRect framefix = self.view.frame;
//    [photosScrollView.view setFrame:framefix];
//    
//    [self.view addSubview:photosScrollView.view];
//    CGRect frame = photosScrollView.view.frame;
//    frame.origin.y = [VIVUtilities getSizeDevice].height ;
//    photosScrollView.view.frame = frame;
//    [UIView beginAnimations:@"show scroll view photos" context:nil];
//    frame.origin.y =0;
//    photosScrollView.view.frame = frame;
//    [UIView commitAnimations];
}
-(void)foundSubView
{
    UIView *subView = [self.view viewWithTag:8000];
    if (subView) {
        [self.view bringSubviewToFront:subView];
    }
}
-(void) closePopOver
{
  
    if (self.popoverController) {
        if (popoverController.popoverVisible) {
            [popoverController dismissPopoverAnimated:YES];
            [popoverController release];
            popoverController = nil;
            
        }
    }
}
-(void)rePresentPopOver
{
    NSLog(@"asdasdasdsadd");
}
-(void)pushDetailFromPlaceTableView:(NSDictionary *)dictInfo
{
    [self addDetailPlaceView:dictInfo];
}
-(void)dismissPopOverFromTableView
{
    if (popoverController) {
        if (popoverController.popoverVisible) {
            [popoverController dismissPopoverAnimated:YES];
            [popoverController release];
            popoverController = nil;
        }
        
    }
}
-(void) tempFunction
{
    [self refreshALLCustomBadge];
    allowLoadingMap = YES;
    if (popoverController) {
        if (popoverController.popoverVisible) {
            [popoverController dismissPopoverAnimated:YES];
            [popoverController release];
            popoverController = nil;
        }
        
    }else {
        CGPoint annotationPoint = [self.mapView convertCoordinate:self.mapView.centerCoordinate toPointToView:self.view];
        float boxDY=annotationPoint.y-13;
        float boxDX=annotationPoint.x+10;
        CGRect box = CGRectMake(boxDX,boxDY,5,5);
        UILabel *displayLabel = [[UILabel alloc] initWithFrame:box];
        currentFramePopOver = displayLabel.frame;
//        [popoverController presentPopoverFromRect:displayLabel.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
        
        if (tempDetailVenueViewController) {
            [self closePopOver];
            if (!popoverController) {
                 UINavigationController *content = [[UINavigationController alloc] initWithRootViewController:tempDetailVenueViewController];
                popoverController =[[UIPopoverController alloc]initWithContentViewController:tempDetailVenueViewController.navigationController];
                popoverController.delegate = self;
                CGSize popOverSize = CGSizeMake(330, 330);
                popoverController.popoverContentSize = popOverSize; 
                
                [popoverController presentPopoverFromRect:currentFramePopOver inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
                [content release];
            }
            
          
        }
        
        if (tempShowPlaceInTableViewController) {
            [self closePopOver];
            if (tempShowPlaceInTableViewController.navigationController==nil) {
                  UINavigationController *content = [[UINavigationController alloc] initWithRootViewController:tempShowPlaceInTableViewController];
                popoverController =[[UIPopoverController alloc]initWithContentViewController:tempShowPlaceInTableViewController.navigationController];
                popoverController.delegate = self;
                CGSize popOverSize = CGSizeMake(330, 330);
                popoverController.popoverContentSize = popOverSize; 
                
                [popoverController presentPopoverFromRect:currentFramePopOver inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
                 [content release];
                
            }
           
           
            
        }
        
    }

}
-(void)rePresentPopOVerFromDetailVenue
{
//    [self performSelector:@selector(tempFunction) withObject:nil afterDelay:0.0];
   
    [self tempFunction];
   
    
}
#pragma mark Ipad DetailVenue Delegate
-(void)loadDetailPhotoFromPopOver:(PhotosScrollViewController *)photosScrollViewController
{
   
    if (self.popoverController) {
        if (popoverController.popoverVisible) {
            [popoverController dismissPopoverAnimated:YES];
            [popoverController release];
            popoverController = nil;
        }
    }
    NSLog(@"loadDetailPhotoFromPopOver1:%i", photosScrollViewController.retainCount);
    [self pushPhotosViewControllerFromMainView:photosScrollViewController];
    NSLog(@"loadDetailPhotoFromPopOver2:%i", photosScrollViewController.retainCount);
}
#pragma mark Ipad SearchVenue Delegate
-(void)dismissPopOverFromSearchView
{
    if (self.popoverController) {
        if (popoverController.popoverVisible) {
            [popoverController dismissPopoverAnimated:YES];
            [popoverController release];
            popoverController = nil;
        }
    }
}
-(void) pushDetailVenueFromSearchController:(NSDictionary *)dictDetail
{
    
    if (dictDetail) {
        [self addDetailPlaceView:dictDetail];
    }
    
}
#pragma mark Ipad PhotosViewController 


-(void) backToDetailVenueViewControllerFromPhotosView
{
    //implement in DetailVenue
    NSLog(@"not implement here");
}
-(void) rePresentPopOverFromPhotosViewController
{
    //implement in DetailVenue
    NSLog(@"not implement here");
}
-(void)requestMoreProviderWithSubArrayPhotos:(NSMutableArray *)subArrayPhotos
{
    //not implement here
}
-(void)loadDetailPhotos:(PhotosScrollViewController *)photosScrollView12
{
    [self closePopOver];
    [self pushPhotosViewControllerFromMainView:photosScrollView12];
    
}
//-(void) closeRequestImageProvider
//{
//    //implement for ipad
//}
-(void)closeMorePhoto
{
//    [VIVUtilities stopArrayProvider:arrayProvider];
//    [VIVUtilities closeRequestImageProviderWithArrayProvider:arrayProvider];
    UIView *subView = [self.view viewWithTag:TAG_MORE_PHOTO_VIEW_CONTROLLER];
    if (subView) {
        [subView removeFromSuperview];
        if (photosViewControllerMainView) {
            [photosViewControllerMainView release];
            photosViewControllerMainView = nil;
        }
    }
}
-(void)pushMorePhotosViewControllerFromMainView:(PhotosViewController *)photosViewController
{
    self.photosViewControllerMainView = photosViewController;
    photosViewController.delegate = self;
    [photosViewController.view setTag:TAG_MORE_PHOTO_VIEW_CONTROLLER];
    [self.view addSubview:photosViewController.view];
    CGRect frame = photosViewController.view.frame;
    frame.origin.x = [VIVUtilities getSizeIpad].width;
    photosViewController.view.frame =frame;
    [UIView beginAnimations:@"Show More Photo Ipad" context:nil];
    frame.origin.x = [VIVUtilities getSizeIpad].width-320;
    photosViewController.view.frame =frame;
    [UIView commitAnimations];
//    [self presentModalViewController:photosViewController animated:YES];
}
-(void)pushPhotosViewControllerFromMainView:(PhotosScrollViewController *)photosViewController
{

    allowLoadingMap = NO;
    
    [self closePopOver];
//    NSLog(@"loadDetailPhotosFromGroupPlace1:%i",photosViewController.retainCount);//4 ==1
   [self presentModalViewController:photosViewController animated:YES];
//    NSLog(@"loadDetailPhotosFromGroupPlace2:%i",photosViewController.retainCount);//5
//    [self presentViewController:photosViewController animated:YES
//    completion:nil];
//    self.photosScrollView = photosViewController;
    CGFloat w =0;
    CGFloat h =0;
    for (int i =0; i< [photosViewController.arrayDetailView count]; i++) {
        DetailImageViewController *imageViewController = [photosViewController.arrayDetailView objectAtIndex:(i)];
        
        
        CGRect frame = imageViewController.view.frame;
        frame.size =[VIVUtilities getSizeDevice];
        w += frame.size.width;
        h  =frame.size.height;
        frame.origin.x = i*frame.size.width;
        [imageViewController.view setFrame:frame];
        CGRect frameSpin = imageViewController.spiner.frame;
        frameSpin.origin.x = imageViewController.view.frame.size.width/2-frameSpin.size.width/2;
        frameSpin.origin.y  = imageViewController.view.frame.size.height/2-frameSpin.size.height/2;
//        NSLog(@"imageViewController %@",NSStringFromCGRect(imageViewController.view.frame));
//        NSLog(@"imageViewController.spiner %@",NSStringFromCGRect(imageViewController.spiner.frame));
        [imageViewController.spiner setFrame:frameSpin];
        
        
    }
}
-(void)disMissDetailViewControllerIpad
{
    [VIVUtilities closeRequestImageProviderWithArrayProvider:arrayProvider];
    UIView *subView = [self.view viewWithTag:TAG_SHOW_DETAIL_VIEW];
    if (subView) {
//        allowLoadingMap  = YES;
        [subView removeFromSuperview];
        [detailPlaceViewControllerIpad release];
        detailPlaceViewControllerIpad = nil;
    }

}
#pragma mark Show All Place Delegate
-(void)rePresentPopOverFromTableView
{
    [self tempFunction];

}
-(void) loadDetailPhotosFromGroupPlace:(PhotosScrollViewController *)photoScrollView
{
    if (self.popoverController) {
        if (popoverController.popoverVisible) {
            [popoverController dismissPopoverAnimated:YES];
            [popoverController release];
            popoverController = nil;
        }
    }
    NSLog(@"loadDetailPhotosFromGroupPlace1:%i",photoScrollView.retainCount);
    [self pushPhotosViewControllerFromMainView:photoScrollView];
    NSLog(@"loadDetailPhotosFromGroupPlace2:%i",photoScrollView.retainCount);
}
-(void)showDetailPlaceWithDictInfo:(NSDictionary *)dictInfo
{
    [self addDetailPlaceView:dictInfo];
}
-(void)closeTableView
{
    
    UIView *subView = [self.view viewWithTag:TAG_SHOW_TABLE_VIEW];
    if (subView) {
        allowLoadingMap  = YES;
        [subView removeFromSuperview];
        [showAllPlaceTableViewIpad release];
        showAllPlaceTableViewIpad = nil;
    }
}
#pragma mark SearchTableView Delegate

-(CLLocation *) getCurrentCoorLocation
{
    return  nil;
}
-(void) pushDetailViewControllerFromSearchView:(NSDictionary *)dictDetail
{
    allowLoadingMap = YES;
    if (dictDetail) {
        [self addDetailPlaceView:dictDetail];
    }
       
   
    
}
#pragma mark ShowAllPlace Delegate
-(void)closeRequestFromDetailView
{
    [VIVUtilities closeRequestImageProviderWithArrayProvider:arrayProvider];
}
-(void)disMissTableViewController:(id)sender
{
//    if (showGroupTableViewIphone.view.hidden ==NO) {
//        showGroupTableViewIphone.view.hidden =YES;
//    }
    UIView * subView = [self.view viewWithTag:TAG_SHOW_TABLE_VIEW];
    if (subView) {
        [subView removeFromSuperview];
        [showGroupTableViewIphone release];
        showGroupTableViewIphone = nil;

    }
}
-(void)addDetailPlaceView:(NSDictionary *)dictInfo
{
    
    if (![VIVUtilities isIpadDevice]) {
        if (!detailViewController) {
            detailViewController = [[DetailPlaceViewControllerViewController alloc]initWithNibName:@"DetailPlaceViewControllerViewController" bundle:nil];
            detailViewController.delegate =self;
        } 
        
        [detailViewController.view setTag:TAG_SHOW_DETAIL_VIEW];
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
        [UIView beginAnimations:@"Show Detail Place" context:nil];
        frameView.origin.y =0;
        detailViewController.view.frame = frameView;//
        [UIView commitAnimations];
        if (!requestDetaiLocation) {
            requestDetaiLocation = [[DetailPlaceProvider alloc]init];
            requestDetaiLocation.delegateDetail =self;
        }
        //    [self startSpinner:self.view];
        [requestDetaiLocation configURLByItemId:[dictInfo objectForKey:@"id"]];
        [requestDetaiLocation requestData];

    }else {
        for (MKAnnotationView *anno in self.mapView.annotations) {
            if ([anno isKindOfClass:[SingleAnnotation class]]) {
                SingleAnnotation *tempAnno = (SingleAnnotation *)anno;
                if ([tempAnno.dictInfor isEqual:dictInfo]) {
                     self.currentAnnoSelected = tempAnno;
                    [self.mapView selectAnnotation:tempAnno animated:YES];
                   
                    break;
                }
            }else if ([anno isKindOfClass:[GroupedAnnotation class]]) {
                GroupedAnnotation *group = (GroupedAnnotation *) anno;
                for(SingleAnnotation *singleAnno in group.listAnnotations)
                {
                    if ([singleAnno.dictInfor isEqual:dictInfo]) {
                        self.currentAnnoSelected = singleAnno;
                        [self.mapView selectAnnotation:group animated:YES];
                        break;
                    }
                }
            }
        }

        
        // remove detail exist
     /*   UIView *subView = [self.view viewWithTag:TAG_SHOW_DETAIL_VIEW];
        if (subView) {
            [subView removeFromSuperview];
            if (detailPlaceViewControllerIpad) {
                detailPlaceViewControllerIpad =nil;
            }
        }
        //close curretn request Imager provider
        [VIVUtilities closeRequestImageProviderWithArrayProvider:arrayProvider];
        if (!detailPlaceViewControllerIpad) {
            self.detailPlaceViewControllerIpad = [[DetailPlaceViewControllerIpad alloc]initWithNibName:@"DetailPlaceViewControllerIpad" bundle:nil];
            detailPlaceViewControllerIpad.delegate =self;
        } 
        CGRect frame = detailPlaceViewControllerIpad.view.frame;

        detailPlaceViewControllerIpad.view.frame = frame;
        [detailPlaceViewControllerIpad.view setTag:TAG_SHOW_DETAIL_VIEW];
        detailPlaceViewControllerIpad.dictInfo = dictInfo;
        [detailPlaceViewControllerIpad configureView];
        [self.view addSubview:detailPlaceViewControllerIpad.view];
        [self.view bringSubviewToFront:detailPlaceViewControllerIpad.view];
        CGRect frameView = CGRectMake([VIVUtilities getSizeIpad].width, 0, 320, [VIVUtilities getSizeIpad].height);
        detailPlaceViewControllerIpad.view.frame = frameView;
        [UIView beginAnimations:@"Show Detail Place" context:nil];
        if ([VIVUtilities getSizeIpad].width ==1004) {
            frameView.origin.x =([VIVUtilities getSizeIpad].width-300);
        }else {
            frameView.origin.x =([VIVUtilities getSizeIpad].width-320);
        }

        detailPlaceViewControllerIpad.view.frame = frameView;//
        [UIView commitAnimations];
        if (!requestDetaiLocation) {
            requestDetaiLocation = [[DetailPlaceProvider alloc]init];
            requestDetaiLocation.delegateDetail =self;
        }
        [requestDetaiLocation configURLByItemId:[dictInfo objectForKey:@"id"]];
        [requestDetaiLocation requestData];
      */

    }

   
}
#pragma DetailPlace provider delegate
-(void) DetailPlaceDidFinishParsing:(DetailPlaceProvider *)provider
{
//    [self stopSpinner:self.view];
    if (provider.resultContent&&[provider.resultContent count]>0) {
        self.arrayImages = [NSMutableArray array];
        BOOL isUserMostActive = YES;
        BOOL isBigImage = NO;
        NSDictionary *dictResult = [provider.resultContent objectAtIndex:0];
        NSDictionary *userMostAcvite = [dictResult objectForKey:@"userMostActive"];
        if (userMostAcvite&& [userMostAcvite objectForKey:@"user"]) {
            
            if (detailViewController) {
                 detailViewController.userMostActive = userMostAcvite;
            }
            if (detailPlaceViewControllerIpad) {
                detailPlaceViewControllerIpad.userMostActive = userMostAcvite;
            }
           
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
            
            if (detailViewController) {
                [detailViewController reloadAvatarMostActive];
            }
            if (detailPlaceViewControllerIpad) {
                [detailPlaceViewControllerIpad reloadAvatarMostActive];
            }
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
        if ([VIVUtilities isIpadDevice]) {
            if (detailPlaceViewControllerIpad) {
                [detailPlaceViewControllerIpad configureView];
            }
            if (detailPlaceViewControllerIpad) {
                detailPlaceViewControllerIpad.arrayTips =arraytips;
                detailPlaceViewControllerIpad.arrayImages =arrayPhotos;
                [detailPlaceViewControllerIpad createBasicViewDetail];
                
            }
        }else {
            //iphone
            if (detailViewController) {
                [detailViewController configureView];
            }
            
            if (detailViewController) {
                detailViewController.arrayTips =arraytips;
                detailViewController.arrayImages =arrayPhotos;
                [detailViewController createBasicViewDetail];
                
            }
        }
        
        
//        NSLog(@"%d",[detailViewController.arrayImages count]);
               [self initArrayProvider];
        self.counter =0;
        [self loadOneByOneImage];
        
        
        
    }

}
#pragma mark ImagesProvider Delegate
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
                        if (detailViewController) {
                            [detailViewController reloadImageById:provider.categoryName];
                            if (detailViewController.photosViewController) {
                                [detailViewController.photosViewController reloadPhotoById:provider.categoryName];
                            }
                        }
                        if (detailPlaceViewControllerIpad) {
                            [detailPlaceViewControllerIpad reloadImageById:provider.categoryName];
                        }
                        if (photosViewControllerMainView) {
                            [photosViewControllerMainView reloadPhotoById:provider.categoryName];
                        }
                        
                        //                        [detailViewController configureView];
                        provider.returnData = [NSData data];
                    }
                }                
            }
            if (provider.mode ==ProvierModeUserMostActive) {
                if (detailViewController) {
                    [detailViewController reloadAvatarMostActive];
                }
                if (detailPlaceViewControllerIpad) {
                    [detailPlaceViewControllerIpad reloadAvatarMostActive];
                }
            }
            
            
        }
        counter ++;
        [self loadOneByOneImage];
    }
    
    
}
-(void) ImagesProfileProviderDidFinishWithError:(NSError *)error provider:(ImagesProfileProvider *)provider
{
    NSLog(@"load image throw error :%@",[provider getCurrentURL]);
//    provider.finishLoad = YES;
    counter ++;
    [self loadOneByOneImage];
    if (provider.mode== ProvierModeUserMostActive) {
        if (detailViewController) {
            [detailViewController reloadAvatarMostActive];
        }
        if (detailPlaceViewControllerIpad) {
            [detailPlaceViewControllerIpad reloadAvatarMostActive];
        }
    }
    
}
#pragma mark detailplace delegate
-(void)disMissDetailViewController
{
//    [VIVUtilities stopArrayProvider:arrayProvider];
    UIView *subView = [self.view  viewWithTag:TAG_SHOW_DETAIL_VIEW];
    if (subView) {
        [subView removeFromSuperview];
        if (detailViewController) {
            [detailViewController release];
            detailViewController = nil;
        }
    }
}
#pragma mark SearchPlace Delegate
-(void)SearchPlaceDidFailWithError:(SearchPlaceProvider *)provider error:(NSError *)error
{
    [self stopSpinner:self.view];
    NSLog(@"");
}
-(void)SearchPlaceDidFinishParsing:(SearchPlaceProvider *)provider
{
    [self stopSpinner:self.view];
    if (!self.dataSourceInTableView) {
        self.dataSourceInTableView =[NSMutableArray array];
    }
    if (!placeTableViewController) {
        self.placeTableViewController =[[ShowAllPlaceViewController alloc]initWithNibName:@"ShowAllPlaceViewController" bundle:nil];
        placeTableViewController.delegate = self;
    }
    if (!placeTableViewControllerIpad) {
        self.placeTableViewControllerIpad = [[PlaceTableViewController alloc]initWithNibName:@"PlaceTableViewController" bundle:nil];
        placeTableViewControllerIpad.delegate =self;
        
    }
    if (!tempDataSourceTableView) {
        tempDataSourceTableView =[[NSMutableArray alloc]init];
    }
    if (provider.resultContent) {  
//        NSInteger t =[provider.resultContent count];
        if (!arrayImagesProvider) {
            //first load location
            self.arrayImagesProvider =[[NSMutableArray alloc]init];
            for (int i =0; i< [provider.resultContent count]; i++) {
                NSDictionary *dictInfor = [provider.resultContent objectAtIndex:i];
                ImagesProfileProvider *imageProvider =[[ImagesProfileProvider alloc]init];
                imageProvider.categoryName = [dictInfor objectForKey:@"type"];
                imageProvider.mode = ProviderModeIcon;
                NSString *linkImage = [dictInfor objectForKey:@"imagelink"];
                if (linkImage) {
                    [imageProvider configURLByURL:[dictInfor objectForKey:@"imagelink"]];
                }else {
                    [imageProvider configURLByURL:DEFAULT_IMAGE_LINK];
                }
                NSDictionary *dictFavicon = [NSDictionary dictionaryWithObjectsAndKeys:
                                             imageProvider,@"provider", 
                                             [dictInfor objectForKey:@"type"],@"type",
                                             nil];
                [arrayImagesProvider addObject:dictFavicon];
                [imageProvider release];
                
                
            }
            
            
        }else {
            //array images provider exist ,append new array for more location
            
            if (dataSourceInTableView) {
                for(NSDictionary *dictInfo in provider.resultContent)
                {   
                    BOOL found = NO;
                    for(NSDictionary *dictCompare in dataSourceInTableView)
                    {
                        if ([dictInfo isKindOfClass:[NSDictionary class]]&&[dictCompare isKindOfClass:[NSDictionary class]]) {
                            if ([[dictInfo objectForKey:@"id"]isEqual:[dictCompare objectForKey:@"id"]]) {
                                found = YES;
                                break;
                                
                            }

                        }
                    }
                    if (!found) {
                        // newlocation chua ton tai ->append
                        ImagesProfileProvider *imageProvider =[[ImagesProfileProvider alloc]init];
                        imageProvider.categoryName = [dictInfo objectForKey:@"type"];
                        imageProvider.mode = ProviderModeIcon;
                        NSString *linkImage = [dictInfo objectForKey:@"imagelink"];
                        if (linkImage) {
                            [imageProvider configURLByURL:[dictInfo objectForKey:@"imagelink"]];
                        }else {
                            [imageProvider configURLByURL:DEFAULT_IMAGE_LINK];
                        }
                        NSDictionary *dictFavicon = [NSDictionary dictionaryWithObjectsAndKeys:
                                                     imageProvider,@"provider", 
                                                     [dictInfo objectForKey:@"type"],@"type",
                                                     nil];
                        [arrayImagesProvider addObject:dictFavicon];
                        [imageProvider release];
                        [dataSourceInTableView addObject:dictInfo];
//                        [placeTableViewController.dataSourceTableView addObject:dictInfo];
                    }
                    
                }
            }
            
        }
        self.tempDataSourceTableView = provider.resultContent;
        if ([VIVUtilities isIpadDevice]==NO) {
            if (!placeTableViewController.dataSourceTableView) {
                self.dataSourceInTableView = [NSMutableArray arrayWithArray:provider.resultContent];
                //            placeTableViewController.dataSourceTableView =[NSMutableArray arrayWithArray:dataSourceInTableView];
                placeTableViewController.dataSourceTableView = tempDataSourceTableView;
                if (arrayImagesProvider) {
                    placeTableViewController.arraySourceFavicon =[NSMutableArray arrayWithArray:arrayImagesProvider];
                }
                [placeTableViewController.tableView reloadData];
                [placeTableViewController loadOneByOneIcon];
                [placeTableViewController convertDataSourceToGroup];
                [placeTableViewController.tableView reloadData];
                
                [self initAnnotations:tempDataSourceTableView];
                [self refreshAllAnnotation];
                
            }else {
                //load more location
                placeTableViewController.dataSourceTableView = tempDataSourceTableView;
                placeTableViewController.arraySourceFavicon =[NSMutableArray arrayWithArray:arrayImagesProvider];
                
                [placeTableViewController.tableView reloadData];
                [placeTableViewController loadOneByOneIcon];
                [placeTableViewController convertDataSourceToGroup];
                [placeTableViewController.tableView reloadData];
                
                //            [self initAnnotations:dataSourceInTableView];
                [self initAnnotations:tempDataSourceTableView];
                [self refreshAllAnnotation];
                
                
            }

        }else {
            if (!placeTableViewControllerIpad.dataSourceTableView) {
                self.dataSourceInTableView = [NSMutableArray arrayWithArray: provider.resultContent];
                //            placeTableViewController.dataSourceTableView =[NSMutableArray arrayWithArray:dataSourceInTableView];
                placeTableViewControllerIpad.dataSourceTableView = tempDataSourceTableView;
                if (arrayImagesProvider) {
                    placeTableViewControllerIpad.arraySourceFavicon =[NSMutableArray arrayWithArray:arrayImagesProvider];
                }
                [placeTableViewControllerIpad.tableView reloadData];
                [placeTableViewControllerIpad loadOneByOneImage];
//                [placeTableViewControllerIpad convertDataSourceToGroup];
                [placeTableViewControllerIpad.tableView reloadData];
                
                [self initAnnotations:tempDataSourceTableView];
                [self refreshAllAnnotation];
                
            }else {
                //load more location
                //            placeTableViewController.dataSourceTableView =[NSMutableArray arrayWithArray:dataSourceInTableView];
                placeTableViewControllerIpad.dataSourceTableView = tempDataSourceTableView;
                placeTableViewControllerIpad.arraySourceFavicon =[NSMutableArray arrayWithArray:arrayImagesProvider];
                
                [placeTableViewControllerIpad.tableView reloadData];
                [placeTableViewControllerIpad loadOneByOneImage];
//                [placeTableViewControllerIpad convertDataSourceToGroup];
                [placeTableViewControllerIpad.tableView reloadData];
                
                //            [self initAnnotations:dataSourceInTableView];
                [self initAnnotations:tempDataSourceTableView];
                [self refreshAllAnnotation];
                
                
            }

        }
                
    }
}

#pragma mark Ad Request Lifecycle Notifications
- (void)adViewDidReceiveAd:(GADBannerView *)view
{
    AbMob.hidden = NO;
}

- (void)adView:(GADBannerView *)view
didFailToReceiveAdWithError:(GADRequestError *)error
{
    AbMob.hidden = YES;
}
@end
