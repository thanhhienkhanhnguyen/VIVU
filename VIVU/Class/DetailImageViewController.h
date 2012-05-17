//
//  DetailImageViewController.h
//  VIVU
//
//  Created by Khanh on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "ImagesProfileProvider.h"
#import <UIKit/UIKit.h>

@protocol SubViewDelegate <NSObject>

-(void)callBackToParrentClass:(NSString *)imageID Url:(NSString *)url;
@end
@interface SubView : UIView
@property (nonatomic, assign) id<SubViewDelegate> delegateSubView;

@end


@protocol DetailImageViewDelegate <NSObject>

-(void) closeView;
-(void) loadPreImage:(NSString *)Id;
-(void) loadNextImage:(NSString *)Id;

@end

@interface DetailImageViewController : UIViewController<ImagesProfileProviderDelegate,SubViewDelegate>
{
    UISwipeGestureRecognizer *gestureLeft;
    UISwipeGestureRecognizer *gestureRight;
}
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) id<DetailImageViewDelegate> delegate;
@property (nonatomic, retain) ImagesProfileProvider *requestBigImage;
@property (nonatomic, retain) UISwipeGestureRecognizer *gestureLeft;
@property (nonatomic, retain) UISwipeGestureRecognizer *gestureRight;
@property (nonatomic, retain) NSString *currentImageId;
@property (nonatomic, retain) NSString *currentUrl;
@property (nonatomic, retain) UIActivityIndicatorView *spiner;



-(void)loadImageFromID:(NSString *)imageId url:(NSString *)url;
-(IBAction)closeImageView:(id)sender;

@end


