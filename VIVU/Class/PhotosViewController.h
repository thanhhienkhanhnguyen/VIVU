//
//  PhotosViewController.h
//  VIVU
//
//  Created by MacPro on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotosScrollViewController.h"

@protocol PhotosViewControllerDelegate <NSObject>

-(void) loadDetailPhotos:(PhotosScrollViewController *)photosScrollView;
-(void) closeMorePhoto;
-(void) backToDetailVenueViewControllerFromPhotosView;
-(void) requestMoreProviderWithSubArrayPhotos:(NSMutableArray *)subArrayPhotos;
-(void) rePresentPopOverFromPhotosViewController;


@end
@protocol CloseRequestFromSubview <NSObject>

-(void) closeRequestImageProvider;
-(void) requestMoreProviderWithSubArrayPhotos:(NSMutableArray *)subArrayPhotos;

@end
@interface PhotosViewController : UIViewController<PhotosScrollViewDelegate>
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *arrayPhotos;
@property (nonatomic, retain) NSMutableArray *subArrayPhotos;
@property (nonatomic, assign) NSInteger numberPhotos;
@property (nonatomic, retain) PhotosScrollViewController *photosView;
@property (nonatomic, assign) id<PhotosViewControllerDelegate>delegate;
@property (nonatomic, assign) id<CloseRequestFromSubview> delegatePhotosView;
@property (nonatomic, assign) BOOL isBelongToPopOver;
@property (nonatomic, retain) IBOutlet UIButton *btnClose;
-(void) createBasicViewPhotos;
-(IBAction)closeView:(id)sender;
-(void) reloadPhotoById:(NSString *)Id;
-(void) createSubPhotosWithIndex:(NSInteger)page;
-(void) createBasicViewPhotosForPopOver:(NSInteger)page;
-(void) clearAllImageInView;
@end
