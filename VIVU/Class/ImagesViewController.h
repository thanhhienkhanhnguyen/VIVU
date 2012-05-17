//
//  ImagesViewController.h
//  VIVU
//
//  Created by Khanh on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define FLEXIBLE_SPACE               10
#define WIDTH_IMAGE                  60

#define TAG_DETAIL_VIEW_IMAGE        100
#define TAG_LATEST_VIEW_FRAME_DETAIL 101
#define TAG_LATEST_IMAGE_BUTTON      102

#import <UIKit/UIKit.h>
#import "DetailImageViewController.h"


@protocol ImagesViewControllerDelegate <NSObject>

-(void) closeImagesView;

@end

@interface ImagesViewController : UIViewController<DetailImageViewDelegate>

@property (nonatomic, retain) NSMutableArray *arrayPhotos;
@property (nonatomic, assign) id<ImagesViewControllerDelegate> delegate;
@property (nonatomic, retain) UIActivityIndicatorView *spiner;

-(void) configureView;
-(void)showDetailImage:(id)sender;
-(IBAction)closeImagesViewController:(id)sender;

@end
