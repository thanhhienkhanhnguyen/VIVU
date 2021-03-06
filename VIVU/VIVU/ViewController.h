//
//  ViewController.h
//  VIVU
//
//  Created by MacPro on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MessageUI/MessageUI.h>
#import <AudioToolbox/AudioToolbox.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <CoreLocation/CoreLocation.h>
#include <QuartzCore/QuartzCore.h>
#import "PlaceTableViewController.h"
#import "SearchPlaceProvider.h"
#import "ImagesProfileProvider.h"
#import "GroupAnnotation/SingleAnnotation.h"
#import "GroupAnnotation/GroupedAnnotation.h"
#import "VIVUtilities.h"
#import "ShowAllPlaceViewController.h"
#import "CustomBadge.h"
#import "DetailPlaceProvider.h"
#import "DetailPlaceViewControllerViewController.h"
#import "SearchViewController.h"
#import "ShowAllPlaceViewController_Ipad.h"
#import "DetailplaceViewControllerIpad.h"
#import "DetailVenueViewControllerIpad.h"
#import "SearchVenueViewController.h"
#import "GADBannerView.h"


@class SearchPlaceProvider;
@class ImagesProfileProvider;
@interface ViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,UIPopoverControllerDelegate,SearchPlaceDelegate,ShowAllPlaceDelegate,DetailPlaceDelegate,DetailViewControllerDelegate,ImagesProfileProviderDelegate,SearchViewControllerDelegate,DetailViewControllerDelegateIpad,ShowPlaceTableDelegateIpad,PhotosViewControllerDelegate,PlaceTableViewDelagate,SearchVenueViewControllerDelegate,DetailVenueViewControllerDelegate,PhotosScrollViewDelegate, GADBannerViewDelegate>
{
    BOOL enableCompass;
    NSMutableArray *arrayImagesProvider;
    NSMutableArray *annotations;
    BOOL isVisibleTableView;
    BOOL allowLoadingMap;
//    BOOL popOverEnable;
    MKAnnotationView *currentAnnotation;
    GADBannerView *AbMob;
    SingleAnnotation *currentAnnoSelected;
    PhotosScrollViewController *photosScrollView;

}
@property (nonatomic, retain) SingleAnnotation *currentAnnoSelected;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *coorCurent;
@property (nonatomic, retain ) IBOutlet UIBarButtonItem *setRegionBtn;
@property (nonatomic, retain) IBOutlet UIButton *mapType;
@property (nonatomic, retain) IBOutlet UIButton *compassBtn;
@property (nonatomic, retain) IBOutlet UIButton *showAllPlaceBtn;
@property (nonatomic, retain) IBOutlet UIButton *searchBtn;
@property (nonatomic, retain) IBOutlet UIToolbar *toolBar;
@property (nonatomic, retain) SearchPlaceProvider *requestLocations;
@property (nonatomic, retain)  ShowAllPlaceViewController*placeTableViewController;
@property (nonatomic, retain)  PlaceTableViewController*placeTableViewControllerIpad;
@property (nonatomic, retain) NSMutableArray *arrayImagesProvider;
@property (nonatomic, retain) NSMutableArray *dataSourceInTableView;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) NSMutableArray *tempDataSourceTableView;

@property (nonatomic, retain) ShowAllPlaceViewController *showGroupTableViewIphone;
@property (nonatomic, retain) ShowAllPlaceViewController_Ipad *showAllPlaceTableViewIpad;
@property (nonatomic, retain) DetailPlaceViewControllerIpad *detailPlaceViewControllerIpad;
@property (nonatomic, retain) IBOutlet UIButton *customeViewBtn;
@property (nonatomic, retain) DetailPlaceViewControllerViewController *detailViewController;
@property (nonatomic, retain) DetailPlaceProvider *requestDetaiLocation;
@property (nonatomic, retain) NSMutableArray *arrayImages;
@property (nonatomic, retain) NSMutableArray *arrayProvider;
@property (nonatomic, assign) NSInteger counter;
@property (nonatomic, retain) SearchViewController *searchController;
@property (nonatomic, retain) UIView *spinView;

@property (nonatomic, retain) SearchVenueViewController *searchVenueController;

@property (nonatomic, retain) DetailVenueViewControllerIpad *detailVenueViewController;
@property (nonatomic, retain) PhotosViewController *photosViewControllerMainView;
@property (nonatomic, assign) CGRect currentFramePopOver;
@property (nonatomic, retain) DetailVenueViewControllerIpad *tempDetailVenueViewController;
@property (nonatomic, retain) ShowAllPlaceViewController_Ipad *tempShowPlaceInTableViewController;
@property (nonatomic, assign) CGFloat oldRadian;
@property (nonatomic, retain) IBOutlet UIView *panelView;
@property (nonatomic, retain) PhotosScrollViewController *photosScrollView;







-(IBAction)customeViewMapView:(id)sender;
-(void) setRegion:(CLLocation *)coordinate2D;
-(IBAction)UpdateRegionbtn:(id)sender;
-(IBAction)changeMapType:(id)sender;
-(IBAction)enableCompass:(id)sender;
-(IBAction)showAllPlaceInTableView:(id)sender;
-(IBAction)searchTableView:(id)sender;
-(IBAction) showALLPlaceInPopOver:(id)sender;
-(IBAction) searchPlaceInPopOver:(id)sender;
- (void)mapView:(MKMapView *)mapViewParam regionDidChangeAnimated:(BOOL)animated;
-(void) refreshAllAnnotation;
-(void) tempFunction;
-(void) foundSubView;
-(void) addPhotosScroolView:(PhotosScrollViewController*)photosScroolView;
-(void)pushPhotosViewControllerFromMainView:(PhotosScrollViewController *)photosViewController;
@end;

@interface reUseable : ShowAllPlaceViewController

@end


