//
//  PhotosScrollViewController.h
//  VIVU
//
//  Created by MacPro on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailImageViewController.h"

@protocol PhotosScrollViewDelegate <NSObject>

//-(void) closePhotosView;
-(void)rePresentPopOver;

@end

@interface PhotosScrollViewController : UIViewController<UIScrollViewDelegate,DetailImageViewDelegate>


@property (nonatomic, retain) UIScrollView *scrollView;

@property (nonatomic, retain) NSMutableArray *arrayPhotos;
@property (nonatomic, assign) id<PhotosScrollViewDelegate> delegate;
@property (nonatomic, retain) UIActivityIndicatorView *spiner;
@property (nonatomic, assign) NSInteger numberImage;
@property (nonatomic, retain) NSString *currentPhotoId;
@property (nonatomic, retain) NSMutableArray *arrayDetailView;
@property (nonatomic, assign) NSInteger currentIndex;

-(void) configureView;
-(IBAction)closeImagesViewController:(id)sender;
-(void) rotatePhotosScrollView;


@end
