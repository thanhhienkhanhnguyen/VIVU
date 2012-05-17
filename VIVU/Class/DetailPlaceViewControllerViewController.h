//
//  DetailPlaceViewControllerViewController.h
//  VIVU
//
//  Created by MacPro on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIVUtilities.h"
#import "CustomeButton.h"
#import "DetailImageViewController.h"
#import "ImagesViewController.h"
#import "tableViewTipsControllerViewController.h"
#import "MorePhotosProvider.h"
#import "PhotosViewController.h"
#import "PhotosScrollViewController.h"

@protocol DetailViewControllerDelegate <NSObject>

-(void) disMissDetailViewController;

@end

@interface DetailPlaceViewControllerViewController : UIViewController<DetailImageViewDelegate,ImagesViewControllerDelegate,MorePhotosDelegate,ImagesProfileProviderDelegate>
{
    BOOL finishLoadImage;
}
@property (nonatomic, retain) NSDictionary *dictInfo;
@property (nonatomic, retain) NSDictionary *userMostActive;
@property (nonatomic, retain) NSMutableArray *arrayImages;
@property (nonatomic, retain) NSMutableArray *arrayTips;
@property (nonatomic, assign)  BOOL finishLoadImage;
@property (nonatomic, retain) IBOutlet UILabel *lblNameLocation;
@property (nonatomic, retain) IBOutlet UILabel *lblDistant;
@property (nonatomic, retain) IBOutlet UILabel *lblAddress;
@property (nonatomic, retain) IBOutlet UIImageView *imageCagetory;
@property (nonatomic, retain) IBOutlet UIButton *btnClose;
@property (nonatomic, retain) IBOutlet UIButton *btnPhoto;
@property (nonatomic, retain) IBOutlet UIButton *btnTips;

@property (nonatomic, retain) IBOutlet UILabel *lblUserName;
@property (nonatomic, retain) IBOutlet UILabel *checkInCount;
@property (nonatomic, retain) IBOutlet UIImageView *imageUser;
@property (nonatomic, retain) IBOutlet UIImageView *faviconMostActive;

@property (nonatomic, retain) IBOutlet UIView *viewDetail;


@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;


@property (nonatomic, assign) id<DetailViewControllerDelegate> delegate;

@property (nonatomic, retain) ImagesViewController *imgViewController;
@property (nonatomic, retain) PhotosViewController *photosViewController;
@property (nonatomic, retain) PhotosScrollViewController *photosDetailView;
@property (nonatomic, retain) tableViewTipsControllerViewController *tableViewTips;
@property (nonatomic, retain) MorePhotosProvider *requestMorePhotos;
@property (nonatomic, retain) NSMutableArray *arrayFullPhotos;
@property (nonatomic, retain) NSMutableArray *arrayProvider;
@property (nonatomic, assign) NSInteger counter;
@property (nonatomic ,assign) NSInteger numberPhotos;


-(void) configureView;
-(IBAction)closeDetailView:(id)sender;
-(IBAction)showMorePhotos:(id)sender;
-(void) reloadImageById:(NSString *)Id;
-(void) reloadAvatarMostActive;
-(void) createBasicViewDetail;
@end
