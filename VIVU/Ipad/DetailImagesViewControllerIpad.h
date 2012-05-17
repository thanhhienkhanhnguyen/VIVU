//
//  DetailImagesViewControllerIpad.h
//  VIVU
//
//  Created by MacPro on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImagesProfileProvider.h"

@protocol DetailImagesViewControllerIpad <NSObject>

-(void)closeDetailImage;

@end

@interface DetailImagesViewControllerIpad : UIViewController<ImagesProfileProviderDelegate>
{
 
}
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) id<DetailImagesViewControllerIpad> delegate;
@property (nonatomic, retain) ImagesProfileProvider *requestBigImage;
@property (nonatomic, retain) UISwipeGestureRecognizer *gestureLeft;
@property (nonatomic, retain) UISwipeGestureRecognizer *gestureRight;
@property (nonatomic, retain) NSString *currentImageId;
@property (nonatomic, retain) NSString *currentUrl;
@property (nonatomic, retain) UIActivityIndicatorView *spiner;



-(void)loadImageFromID:(NSString *)imageId url:(NSString *)url;
-(IBAction)closeImageView:(id)sender;

@end
