//
//  DetailVenueViewControllerIpad.h
//  VIVU
//
//  Created by MacPro on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MorePhotosProvider.h"
#import "PhotosViewController.h"
#import "ImagesProfileProvider.h"
#import "MoreTisProvider.h"
#import "tableViewTipsControllerViewController.h"

@protocol DetailVenueViewControllerDelegate <NSObject>

-(void)loadDetailPhotoFromPopOver:(PhotosScrollViewController*)photosScrollViewController;
-(void) rePresentPopOVerFromDetailVenue;

@end

@interface DetailVenueViewControllerIpad : UIViewController<UITableViewDelegate,UITableViewDataSource,MorePhotosDelegate,PhotosViewControllerDelegate,ImagesProfileProviderDelegate,MoreTisProviderDelegate,TableViewTipsDelegate>

@property (nonatomic, retain) NSDictionary *dictInfo;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataSourceTableView;
@property (nonatomic, retain) MorePhotosProvider *requestMorePhoto;
@property (nonatomic, retain) PhotosViewController *photosViewController;

@property (nonatomic, retain) MoreTisProvider *requestMoreTips;
@property (nonatomic, retain) tableViewTipsControllerViewController *tableViewTips;

@property (nonatomic, retain) NSMutableArray *arrayFullPhotos;
@property (nonatomic, retain) NSMutableArray *arraySubPhotos;
@property (nonatomic, retain) NSMutableArray *arrayProvider;
@property (nonatomic, retain) NSMutableArray *arraySubProvider;
@property (nonatomic, assign) NSInteger counter;
@property (nonatomic ,assign) NSInteger numberPhotos;
@property (nonatomic, retain) id<DetailVenueViewControllerDelegate>delegate;

-(void)configureView;
-(CGSize)sizeInPopoverView;
@end
